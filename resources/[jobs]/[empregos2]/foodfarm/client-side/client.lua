-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("foodfarm",cnVRP)
vSERVER = Tunnel.getInterface("foodfarm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local startX = 1599.48
local startY = 6457.97
local startZ = 25.32
local avalanchesPosition = 1
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = { 2565.51,385.02,108.47 },
	[2] = { 28.11,-1359.32,29.35 },
	[3] = { 1160.3,-338.94,68.21 }, -- G
	[4] = { -711.79,-920.81,19.02 },
	[5] = { -55.17,-1759.34,28.98 },
	[6] = { 374.21,314.39,103.4 },
	[7] = { -3233.06,1004.51,12.28 },
	[8] = { 543.52,2679.15,42.23 },
	[9] = { 1968.64,3734.73,32.34 },
	[10] = { 2686.22,3280.44,55.25 },
	[11] = { 1694.36,4933.01,42.08 },
	[12] = { -1815.15,779.86,137.36 }, -- G
	[13] = { 1396.33,3593.53,34.94 },
	[14] = { -2982.43,392.11,14.88 },
	[15] = { -3029.73,592.67,7.8 },
	[16] = { 1151.26,-980.19,46.23 },
	[17] = { 1166.24,2688.92,38.02 }, -- G
	[18] = { -1501.71,-394.19,39.67 },
	[19] = { -1231.11,-895.05,12.24 },
	[20] = { 1724.29,6406.46,34.24 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.toggleService()
	local ped = PlayerPedId()

	if not inService then
		startthreadservice()
		startthreadtimeseconds()
		inService = true
		makeBlipMarked()
		TriggerEvent("Notify","verde","Você começou a trabalhar de <b>Motorista de Ônibus</b>.",5000)
		TriggerEvent("sound:source","quite",0.5)
	else
		inService = false
		TriggerEvent("Notify","aviso","Você parou de trabalhar de <b>Motorista de Ônibus</b>.",5000)
		TriggerEvent("sound:source","juntos",0.5)
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
			blip = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("burrito2")) then
						timeDistance = 4
						DrawMarker(21,coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,105,180,255,255,1,0,0,1)
						if distance <= 15 then
							local speed = GetEntitySpeed(veh) * 2.236936
							
							if IsControlJustPressed(1,38) and speed <= 40 and timeSeconds <= 0 then
								timeSeconds = 2
								if avalanchesPosition == #coords then
									avalanchesPosition = 1
									vSERVER.paymentMethod(true)
								else
									avalanchesPosition = avalanchesPosition + 1
									vSERVER.paymentMethod(false)
								end
								makeBlipMarked()
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
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadtimeseconds()
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
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	blip = AddBlipForCoord(coords[avalanchesPosition][1],coords[avalanchesPosition][2],coords[avalanchesPosition][3],50.0)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,26)
	SetBlipScale(blip,0.5)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Ingredientes")
	EndTextCommandSetBlipName(blip)
end