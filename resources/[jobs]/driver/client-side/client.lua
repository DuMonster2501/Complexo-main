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
Tunnel.bindInterface("driver",cnVRP)
vSERVER = Tunnel.getInterface("driver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local startX = 453.87
local startY = -600.47
local startZ = 28.59
local driverPosition = 1
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = { 418.92,-571.03,28.68 },
	[2] = { 929.41,182.91,76.29 },
	[3] = { 1644.11,1166.89,84.26 },
	[4] = { 2104.23,2630.44,51.76 },
	[5] = { 2402.38,2918.04,49.31 },
	[6] = { 1786.57,3356.21,40.51 },
	[7] = { 1620.82,3813.85,34.94 },
	[8] = { 1911.6,3793.09,32.31 },
	[9] = { 2493.37,4088.69,38.04 },
	[10] = { 2068.51,4693.82,41.19 },
	[11] = { 1676.39,4822.41,42.02 },
	[12] = { 2250.19,4986.36,42.23 },
	[13] = { 1667.97,6397.56,30.12 },
	[14] = { 235.51,6574.7,31.57 },
	[15] = { -85.11,6584.3,29.47 },
	[16] = { -137.53,6440.85,31.42 },
	[17] = { -235.39,6304.34,31.39 },
	[18] = { -422.67,6031.56,31.34 },
	[19] = { -756.66,5515.02,35.49 },
	[20] = { -1538.42,4976.01,62.28 },
	[21] = { -2246.9,4283.26,46.68 },
	[22] = { -2731.13,2292.23,19.05 },
	[23] = { -3233.06,1009.3,12.18 },
	[24] = { -3002.44,416.76,14.97 },
	[25] = { -1960.25,-504.23,11.82 },
	[26] = { -1371.7,-982.24,8.43 },
	[27] = { -1166.92,-1471.31,4.34 },
	[28] = { -1052.56,-1511.78,5.09 },
	[29] = { -900.75,-1206.71,4.94 },
	[30] = { -628.94,-924.13,23.28 },
	[31] = { -557.24,-845.49,27.61 },
	[32] = { -1059.11,-2066.85,13.2 },
	[33] = { -543.79,-2194.84,6.01 },
	[34] = { -60.68,-1806.51,27.21 },
	[35] = { 228.64,-1837.9,26.73 },
	[36] = { 291.46,-2002.07,20.31 },
	[37] = { 739.81,-2233.34,29.24 },
	[38] = { 1045.03,-2384.93,30.28 },
	[39] = { 1200.9,-685.64,60.6 },
	[40] = { 954.37,-146.43,74.45 },
	[41] = { 566.42,218.64,102.54 },
	[42] = { -429.1,252.36,83.02 },
	[43] = { -732.3,3.21,37.88 },
	[44] = { -1244.38,-302.64,37.32 },
	[45] = { -1403.93,-566.3,30.22 },
	[46] = { -1202.05,-876.7,13.28 },
	[47] = { -691.37,-961.63,19.79 },
	[48] = { -387.71,-851.57,31.5 },
	[49] = { 149.9,-1028.06,29.25 },
	[50] = { 120.26,-1356.98,29.19 },
	[51] = { 118.29,-785.88,31.3 },
	[52] = { 98.34,-628.98,31.57 }
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
		TriggerEvent("Notify","amarelo","O serviço de <b>Motorista</b> foi iniciado.",2000)
	else
		inService = false
		TriggerEvent("Notify","amarelo","O serviço de <b>Motorista</b> foi finalizado.",2000)
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
					local distance = #(coordsPed - vector3(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("bus")) then
						timeDistance = 4
						DrawMarker(21,coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,121,206,121,100,1,0,0,1)
						if distance <= 15 then
							local speed = GetEntitySpeed(veh) * 2.236936
							if IsControlJustPressed(1,38) and speed <= 20 and timeSeconds <= 0 then
								timeSeconds = 2
								if driverPosition == #coords then
									driverPosition = 1
									vSERVER.paymentMethod(true)
								else
									driverPosition = driverPosition + 1
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

	blip = AddBlipForCoord(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3],50.0)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,2)
	SetBlipScale(blip,0.5)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Parada de Ônibus")
	EndTextCommandSetBlipName(blip)
end