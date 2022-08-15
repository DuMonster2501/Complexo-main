-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args)
	SendNUIMessage({ action = "showAll" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Abrir as notificações","keyboard","f2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	data.street = GetStreetNameFromHashKey(GetStreetNameAtCoord(data.x,data.y,data.z))

	SendNUIMessage({ action = "notify", data = data })

	local blip = AddBlipForCoord(data.x,data.y,data.z)
	SetBlipSprite(blip,304)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(data.title)
	EndTextCommandSetBlipName(blip)
	SetTimeout(60000,function()
		RemoveBlip(blip)
	end)

	if parseInt(data.code) == 13 then
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
		Citizen.Wait(500)
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
		Citizen.Wait(500)
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
	elseif parseInt(data.code) == 10 then
		PlaySoundFrontend(-1,"Lose_1st","GTAO_FM_Events_Soundset",false)
	elseif parseInt(data.code) == 32 then
		PlaySoundFrontend(-1,"CHALLENGE_UNLOCKED","HUD_AWARDS",false)
	elseif parseInt(data.code) == 38 then
		PlaySoundFrontend(-1,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS",false)
	elseif parseInt(data.code) == 50 then
		PlaySoundFrontend(-1,"OOB_Cancel","GTAO_FM_Events_Soundset",false)
	elseif parseInt(data.code) == 72 then
		PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	else
		PlaySoundFrontend(-1,"Event_Message_Purple","GTAO_FM_Events_Soundset",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	SetNewWaypoint(data.x+0.0001,data.y+0.0001)
	SendNUIMessage({ action = "hideAll" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("phoneCall",function(data)
	SendNUIMessage({ action = "hideAll" })
	TriggerEvent("gcPhone:callNotifyPush",data.phone)
end)