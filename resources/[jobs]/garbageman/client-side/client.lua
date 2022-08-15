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
Tunnel.bindInterface("garbageman",cRP)
vSERVER = Tunnel.getInterface("garbageman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timeSeconds = 0
local garbageList = {}
local inService = false
local vehModel = 1917016601
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGARBAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgarbage()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)

					for k,v in pairs(garbageList) do
						local distance = #(coords - vector3(v[1],v[2],v[3]))
						if distance <= 0.6 then
							timeDistance = 4
							DrawText3D(v[1],v[2],v[3],"~g~E~w~  VASCULHAR")
							if distance <= 0.6 and IsControlJustPressed(1,38) and timeSeconds <= 0 then
							    if GetEntityModel(GetPlayersLastVehicle()) == vehModel then
								    timeSeconds = 2
								    TriggerEvent("cancelando",true)
								    vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
									TriggerEvent("Progress",5000,"Procurando...")
								    Wait(5000)
								    vSERVER.paymentMethod(parseInt(k))
								    TriggerEvent("cancelando",false)
								    ClearPedTasks(ped)
								else
								    TriggerEvent("Notify","amarelo","Você precisa utilizar o veículo do <b>Lixeiro</b>.",3000)
								end
							end
						end
					end
				end
			end

			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVERIFYBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:verifyBox")
AddEventHandler("garbageman:verifyBox",function(verifyBox)
TriggerEvent("cancelando",true)
local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		TriggerEvent("Progress",5000,"Vasculhando...")
		vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
		Wait(5000)
		vSERVER.paymentBoxMethod()
		TriggerEvent("cancelando",false)
		ClearPedTasks(ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getGarbageStatus()
	return inService
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startGarbageman()
	startthreadgarbage()
	startthreadgarbageseconds()
	inService = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopGarbageman()
	inService = false
	for k,v in pairs(blips) do
		if DoesBlipExist(blips[k]) then
			RemoveBlip(blips[k])
			blips[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:updateGarbageList")
AddEventHandler("garbageman:updateGarbageList",function(status)
	garbageList = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:removeGarbageBlips")
AddEventHandler("garbageman:removeGarbageBlips",function(number)
	if DoesBlipExist(blips[number]) then
		RemoveBlip(blips[number])
		blips[number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garbageman:insertBlips")
AddEventHandler("garbageman:insertBlips",function(statusList)
	if inService then
		for k,v in pairs(blips) do
			if DoesBlipExist(blips[k]) then
				RemoveBlip(blips[k])
				blips[k] = nil
			end
		end

		Citizen.Wait(1000)

		for k,v in pairs(statusList) do
			blips[k] = AddBlipForRadius(v[1],v[2],v[3],5.0)
			SetBlipAlpha(blips[k],255)
			SetBlipColour(blips[k],57)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgarbageseconds()
	Citizen.CreateThread(function()
		while true do
			if timeSeconds > 0 then
				timeSeconds = timeSeconds - 1
			end
			Citizen.Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end