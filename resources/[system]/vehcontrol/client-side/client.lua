---------------------------------------------------------------------
local count_bcast_timer = 0
local delay_bcast_timer = 200
---------------------------------------------------------------------
local count_sndclean_timer = 0
local delay_sndclean_timer = 400
---------------------------------------------------------------------
local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180
---------------------------------------------------------------------
local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true
---------------------------------------------------------------------
local state_indic = {}
local state_lxsiren = {}
local state_airmanu = {}
---------------------------------------------------------------------
local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3
---------------------------------------------------------------------
local snd_lxsiren = {}
local snd_airmanu = {}
---------------------------------------------------------------------
local eModelsWithFireSrn = {
	"FIRETRUK"
}
---------------------------------------------------------------------
local eModelsWithPcall = {
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD"
}
---------------------------------------------------------------------
function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1,#eModelsWithFireSrn,1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end
---------------------------------------------------------------------
function usePowercallAuxSrn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithPcall, 1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	return false
end
---------------------------------------------------------------------
function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0

		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end

		for k, v in pairs(state_airmanu) do
			if v then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k,-1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end
---------------------------------------------------------------------
function TogIndicStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,true)
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,true)
		end
		state_indic[veh] = newstate
	end
end
---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh,toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh,toggle)
	end
end
---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end

			if newstate == 1 then
				if useFiretruckSiren(veh) then
					TogMuteDfltSrnForVeh(veh,false)
				else
					snd_lxsiren[veh] = GetSoundId()	
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
					TogMuteDfltSrnForVeh(veh,true)
				end
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_AMBULANCE_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_POLICE_WARNING",veh,0,0,0)
				end
				TogMuteDfltSrnForVeh(veh,true)
			else
				TogMuteDfltSrnForVeh(veh,true)
			end
			state_lxsiren[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
function SetAirManuStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end

			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_FIRETRUCK_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_airmanu[veh],"SIRENS_AIRHORN",veh,0,0,0)
				end
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
			end
			state_airmanu[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c",function(sender,toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh,toggle)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		CleanupSounds()

		local slyphe = 500
		local playerped = PlayerPedId()
		if IsPedInAnyVehicle(playerped,false) then
			slyphe = 250
			local veh = GetVehiclePedIsUsing(playerped)
			if GetPedInVehicleSeat(veh,-1) == playerped then
				slyphe = 3
				DisableControlAction(1,84,true)
				DisableControlAction(1,83,true)

				if state_indic[veh] ~= ind_state_o and state_indic[veh] ~= ind_state_l and state_indic[veh] ~= ind_state_r and state_indic[veh] ~= ind_state_h then
					state_indic[veh] = ind_state_o
				end

				if actv_ind_timer then
					if state_indic[veh] == ind_state_l or state_indic[veh] == ind_state_r then
						if GetEntitySpeed(veh) < 6 then
							count_ind_timer = 0
						else
							if count_ind_timer > delay_ind_timer then
								count_ind_timer = 0
								actv_ind_timer = false
								state_indic[veh] = ind_state_o
								TogIndicStateForVeh(veh,state_indic[veh])
								count_bcast_timer = delay_bcast_timer
							else
								count_ind_timer = count_ind_timer + 1
							end
						end
					end
				end

				if GetVehicleClass(veh) == 18 then
					local actv_manu = false
					local actv_horn = false

					DisableControlAction(1,86,true)
					DisableControlAction(1,19,true)
					DisableControlAction(1,85,true)
					DisableControlAction(1,80,true)
					SetVehRadioStation(veh,"OFF")
					SetVehicleRadioEnabled(veh,false)

					if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 then
						state_lxsiren[veh] = 0
					end

					if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 then
						state_airmanu[veh] = 0
					end

					if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
						TogMuteDfltSrnForVeh(veh,false)
						dsrn_mute = false
					else
						TogMuteDfltSrnForVeh(veh,true)
						dsrn_mute = true
					end

					if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
						SetLxSirenStateForVeh(veh,0)
						count_bcast_timer = delay_bcast_timer
					end

					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,85) then
							if IsVehicleSirenOn(veh) then
								TriggerEvent("sound:source","sirenOffline",0.5)
								SetVehicleSiren(veh,false)
							else
								TriggerEvent("sound:source","sirenOnline",0.5)
								Citizen.Wait(150)
								SetVehicleSiren(veh,true)
								count_bcast_timer = delay_bcast_timer
							end
						elseif IsDisabledControlJustReleased(0,19) then
							local cstate = state_lxsiren[veh]
							if cstate == 0 then
								if IsVehicleSirenOn(veh) then
									SetLxSirenStateForVeh(veh,1)
									count_bcast_timer = delay_bcast_timer
								end
							else
								SetLxSirenStateForVeh(veh,0)
								count_bcast_timer = delay_bcast_timer
							end
						end

						if state_lxsiren[veh] > 0 then
							if IsDisabledControlJustReleased(0,80) then
								if IsVehicleSirenOn(veh) then
									local cstate = state_lxsiren[veh]
									local nstate = 1

									if cstate == 1 then
										nstate = 2
									elseif cstate == 2 then
										nstate = 3
									else	
										nstate = 1
									end
									SetLxSirenStateForVeh(veh,nstate)
									count_bcast_timer = delay_bcast_timer
								end
							end
						end

						if state_lxsiren[veh] < 1 then
							if IsDisabledControlPressed(1,80) then
								actv_manu = true
							else
								actv_manu = false
							end
						else
							actv_manu = false
						end

						if IsDisabledControlPressed(1,86) then
							actv_horn = true
						else
							actv_horn = false
						end
					end

					local hmanu_state_new = 0
					if actv_horn and not actv_manu then
						hmanu_state_new = 1
					elseif not actv_horn and actv_manu then
						hmanu_state_new = 2
					elseif actv_horn and actv_manu then
						hmanu_state_new = 3
					end

					if hmanu_state_new == 1 then
						if not useFiretruckSiren(veh) then
							if state_lxsiren[veh] > 0 and not actv_lxsrnmute_temp then
								srntone_temp = state_lxsiren[veh]
								SetLxSirenStateForVeh(veh,0)
								actv_lxsrnmute_temp = true
							end
						end
					else
						if not useFiretruckSiren(veh) then
							if actv_lxsrnmute_temp then
								SetLxSirenStateForVeh(veh,srntone_temp)
								actv_lxsrnmute_temp = false
							end
						end
					end

					if state_airmanu[veh] ~= hmanu_state_new then
						SetAirManuStateForVeh(veh, hmanu_state_new)
						count_bcast_timer = delay_bcast_timer
					end
				end

				if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then
					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,84) then
							local cstate = state_indic[veh]
							if cstate == ind_state_l then
								state_indic[veh] = ind_state_o
								actv_ind_timer = false
							else
								state_indic[veh] = ind_state_l
								actv_ind_timer = true
							end
							count_ind_timer = 0
							count_bcast_timer = delay_bcast_timer
							TogIndicStateForVeh(veh,state_indic[veh])
						elseif IsDisabledControlJustReleased(0,83) then
							local cstate = state_indic[veh]
							if cstate == ind_state_r then
								state_indic[veh] = ind_state_o
								actv_ind_timer = false
							else
								state_indic[veh] = ind_state_r
								actv_ind_timer = true
							end
							count_ind_timer = 0
							count_bcast_timer = delay_bcast_timer
							TogIndicStateForVeh(veh,state_indic[veh])
						elseif IsControlJustReleased(1,202) then
							if GetLastInputMethod(0) then
								local cstate = state_indic[veh]
								if cstate == ind_state_h then
									state_indic[veh] = ind_state_o
								else
									state_indic[veh] = ind_state_h
								end
								actv_ind_timer = false
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer
								TogIndicStateForVeh(veh,state_indic[veh])
							end
						end
					end

					if count_bcast_timer > delay_bcast_timer then
						count_bcast_timer = 0
						if GetVehicleClass(veh) == 18 then
							TriggerServerEvent("lvc_TogDfltSrnMuted_s",dsrn_mute)
							TriggerServerEvent("lvc_SetLxSirenState_s",state_lxsiren[veh])
							TriggerServerEvent("lvc_SetAirManuState_s",state_airmanu[veh])
						end
						TriggerServerEvent("lvc_TogIndicState_s",state_indic[veh])
					else
						count_bcast_timer = count_bcast_timer + 1
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)