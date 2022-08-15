-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("police",cRP)
vSERVER = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SendNUIMessage({ action = "closeSystem" })
	SetNuiFocus(false,false)
	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initPrison",function(data)
	vSERVER.initPrison(data["passaporte"],data["servicos"],data["multas"],data["texto"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initFine",function(data)
	vSERVER.initFine(data["passaporte"],data["multas"],data["texto"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updatePort",function(data)
	vSERVER.updatePort(data["passaporte"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updatePolice",function(data)
	vSERVER.updatePolice(data["passaporte"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("searchUser",function(data,cb)
	cb({ result = vSERVER.searchUser(data["passaporte"]) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:openSystem")
AddEventHandler("police:openSystem",function()
	local user_id = vRP.getUserId(source)
	local ped = PlayerPedId()
	if not IsPedSwimming(ped) then
		SendNUIMessage({ action = "openSystem" })
		TriggerEvent("dynamic:closeSystem")
		SetNuiFocus(true,true)

		if not IsPedInAnyVehicle(ped) then
			vRP.removeObjects()
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:INSERTBARRIER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:insertBarrier")
AddEventHandler("police:insertBarrier",function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local heading = GetEntityHeading(ped)
		local mHash = GetHashKey("prop_mp_barrier_02b")
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)

		RequestModel(mHash)
		while not HasModelLoaded(mHash) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(mHash) then
			local newObject = CreateObject(mHash,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(newObject)

			SetNetworkIdCanMigrate(netObjs,true)

			PlaceObjectOnGroundProperly(newObject)
			SetEntityAsMissionEntity(newObject,true,false)
			SetEntityHeading(newObject,heading - 180)
			FreezeEntityPosition(newObject,true)

			SetModelAsNoLongerNeeded(mHash)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:Update")
AddEventHandler("police:Update",function(action,data)
	SendNUIMessage({ action = action, data = data })
end)