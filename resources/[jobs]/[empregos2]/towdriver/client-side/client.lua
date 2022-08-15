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
Tunnel.bindInterface("towdriver",cRP)
vSERVER = Tunnel.getInterface("towdriver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeSeconds = 0
local tow = nil
local towed = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timeSeconds > 0 then
			timeSeconds = timeSeconds - 1
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.towPlayer()
	local vehicle = GetPlayersLastVehicle()
	if IsVehicleModel(vehicle,GetHashKey("flatbed")) and not IsPedInAnyVehicle(PlayerPedId()) then
		towed = vRP.getNearVehicle(11)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if tow then
				vSERVER.tryTow(VehToNet(vehicle),VehToNet(tow),"out")
				towed = nil
				tow = nil
			else
				if vehicle ~= towed then
					vSERVER.tryTow(VehToNet(vehicle),VehToNet(towed),"in")
					tow = towed
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:syncTow")
AddEventHandler("towdriver:syncTow",function(vehid01,vehid02,mod)
	if NetworkDoesNetworkIdExist(vehid01) and NetworkDoesNetworkIdExist(vehid02) then
		local vehicle = NetToEnt(vehid01)
		local towed = NetToEnt(vehid02)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if mod == "in" then
				local min,max = GetModelDimensions(GetEntityModel(towed))
				AttachEntityToEntity(towed,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
			elseif mod == "out" then
				AttachEntityToEntity(towed,vehicle,20,-0.5,-18.0,-0.2,0.0,0.0,0.0,false,false,true,false,20,true)
				DetachEntity(towed,false,false)
				SetVehicleOnGroundProperly(towed)
			end
		end
	end
end)