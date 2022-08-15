-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("survival",cRP)
vSERVER = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deadPlayer = false
local deathtimer = 50
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			if not deadPlayer then
				timeDistance = 100
				deadPlayer = true

				local coords = GetEntityCoords(ped)
				NetworkResurrectLocalPlayer(coords,true,true,false)
				deathtimer = 1000

				if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
					vRP.playAnim(false,{"dead","dead_a"},true)
				end
				
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)

				TriggerEvent("radio:outServers")
				TriggerServerEvent("inventory:Cancel")
				TriggerEvent("hudActived",false)

			else
				if deathtimer > 0 then
					timeDistance = 4
					SetEntityHealth(ped,101)

					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
					
					SendNUIMessage({action = 'showDeath'})
                else
					SetNuiFocus(false, false)
				end
			end
		else
			SendNUIMessage({ action = 'hideDeath'})
			SetNuiFocus(false, false)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if deadPlayer and deathtimer > 0 then
			deathtimer = deathtimer - 1
            SendNUIMessage({ action = 'updateTimer', deathtimer = deathtimer})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if deathtimer <= 0 then
		vSERVER.ResetPedToHospital()
		SendNUIMessage({ action = 'hideDeath'})
		deadPlayer = false
		SetEntityInvincible(ped,false)
		TriggerEvent("hudActived",true)
	else
		TriggerEvent("Notify","amarelo","AGUARDE: <b>"..deathtimer.."</b> OU CHAME OS <b>PARAMÉDICOS</b>.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		TriggerEvent("hudActived",true)
		SendNUIMessage({ action = 'hideDeath'})
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,200)
		SetEntityInvincible(ped,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deadPlayer()
	return deadPlayer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerEvent("hudActived",true)

	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("survival:CheckIn")
AddEventHandler("survival:CheckIn",function()
	SetEntityHealth(PlayerPedId(),102)
	SetEntityInvincible(PlayerPedId(),false)

	Citizen.Wait(500)

	deadPlayer = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updatePrison")
AddEventHandler("updatePrison",function()
	SetEntityHealth(PlayerPedId(),110)
	SetEntityInvincible(PlayerPedId(),false)

	if deadPlayer then
		deadPlayer = false
		blockControls = true
		ClearPedTasks(PlayerPedId())
		TriggerEvent("resetBleeding")
		TriggerEvent("resetDiagnostic")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCURE
-----------------------------------------------------------------------------------------------------------------------------------------
local cure = false
function cRP.startCure()
	local ped = PlayerPedId()

	if cure then
		return
	end

	cure = true
	TriggerEvent("Notify","verde","O tratamento começou, espere o paramédico libera-lo.",3000)

	if cure then
		repeat
			Citizen.Wait(1000)
			if GetEntityHealth(ped) > 101 then
				SetEntityHealth(ped,GetEntityHealth(ped)+1)
			end
		until GetEntityHealth(ped) >= 200 or GetEntityHealth(ped) <= 101
			TriggerEvent("Notify","verde","Tratamento concluído.",3000)
			cure = false
			blockControls = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPEDINBED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.SetPedInBed()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
		if DoesEntityExist(object) then
			local x2,y2,z2 = table.unpack(GetEntityCoords(object))
			
			TeleportPlayer(ped,x2,y2,z2+v[2])
			SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)

			vRP.playAnim(false,{"dead","dead_a"},true)

			SetTimeout(7000,function()
				TriggerServerEvent("inventory:Cancel")
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCREENFADEINOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("survival:FadeOutIn")
AddEventHandler("survival:FadeOutIn",function()
	DoScreenFadeOut(1000)
	Citizen.Wait(5000)
	DoScreenFadeIn(1000)
end)