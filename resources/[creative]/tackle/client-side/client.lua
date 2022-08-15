-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local tackleSystem = 0
local anim = "dive_run_fwd_-45_loop"
local dict = "swimming@first_person@diving"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if (IsPedRunning(ped) or IsPedSprinting(ped)) and tackleSystem <= 0 and not IsPedSwimming(ped) then
			timeDistance = 0

			if IsControlJustPressed(1,38) then
				local userStatus = nearestPlayers()
				if userStatus then
					TriggerServerEvent("tackle:Update",GetPlayerServerId(userStatus))
					tackleSystem = 3

					if not IsPedRagdoll(ped) then
						RequestAnimDict(dict)
						while not HasAnimDictLoaded(dict) do
							Citizen.Wait(1)
						end

						if IsEntityPlayingAnim(ped,dict,anim,3) then
							ClearPedSecondaryTask(ped)
						else
							TaskPlayAnim(ped,dict,anim,8.0,-8,-1,49,0,0,0,0)

							local tackleSeconds = 3
							while tackleSeconds > 0 do
								Citizen.Wait(100)
								tackleSeconds = tackleSeconds - 1
							end

							ClearPedSecondaryTask(ped)
							SetPedToRagdoll(ped,1000,1000,0,0,0,0)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function()
	SetPedToRagdoll(PlayerPedId(),5000,5000,0,0,0,0)
	TriggerServerEvent("inventory:Cancel")
	tackleSystem = 3
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if tackleSystem > 0 then
			tackleSystem = tackleSystem - 1
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers()
	local ped = PlayerPedId()
	local nearestPlayer = false
	local listPlayers = GetPlayers()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,1.25,0.0)

	for _,v in ipairs(listPlayers) do
		local uPlayer = GetPlayerPed(v)
		if uPlayer ~= ped and not IsPedInAnyVehicle(uPlayer) then
			local uCoords = GetEntityCoords(uPlayer)
			local distance = #(coords - uCoords)
			if distance <= 1.25 then
				nearestPlayer = v
			end
		end
	end

	return nearestPlayer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local pedList = {}

	for k,v in ipairs(GetActivePlayers()) do
		table.insert(pedList,v)
	end

	return pedList
end