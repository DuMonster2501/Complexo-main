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
Tunnel.bindInterface("miner",cRP)
vSERVER = Tunnel.getInterface("miner")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ouService = false
local inService = false
local selected = 0
local blip = nil
local coSelected = 0
local timeSeconds = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- POUCHS
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {
	{ -594.48,2078.32,131.49,111.27 },
	{ -590.01,2071.21,131.25,283.37 },
	{ -593.92,2086.1,131.55,294.14 },
	{ -595.53,2082.65,131.4,115.66 },
	{ -593.26,2073.58,131.48,122.9 },
	{ -591.62,2067.49,131.14,101.34 },
	{ -587.56,2059.36,130.62,261.0 },
	{ -587.86,2046.26,129.73,113.01 },
	{ -581.25,2038.74,128.9,291.79 },
	{ -578.84,2030.44,128.46,139.78 },
	{ -575.2,2029.87,128.16,311.61 },
	{ -572.84,2023.1,127.97,147.26 },
	{ -562.19,2011.42,127.37,137.24 },
	{ -552.5,1995.96,127.13,138.71 },
	{ -549.39,1996.32,127.04,298.78 },
	{ -546.6,1984.63,127.14,130.33 },
	{ -537.84,1983.05,127.03,344.33 },
	{ -532.34,1979.37,127.16,172.22 },
	{ -532.88,1982.12,126.98,357.71 },
	{ -523.88,1980.77,126.76,354.06 },
	{ -517.11,1977.65,126.66,169.55 },
	{ -508.15,1980.3,126.18,359.44 },
	{ -506.07,1977.91,126.22,182.76 },
	{ -494.45,1983.43,125.12,34.27 },
	{ -486.15,1984.21,124.43,203.23 },
	{ -475.34,1990.61,123.75,30.17 },
	{ -459.43,1998.01,123.66,241.66 },
	{ -455.55,2005.83,123.56,55.94 },
	{ -448.58,2009.43,123.65,226.07 },
	{ -450.72,2022.85,123.48,94.29 },
	{ -454.48,2045.24,122.86,309.0 },
	{ -451.05,2054.5,122.26,203.53 },
	{ -427.41,2065.11,120.49,17.01 },
	{ -423.09,2063.4,120.07,179.96 },
	{ -467.63,2065.11,120.78,113.2 },
	{ -467.5,2073.01,120.68,309.61 },
	{ -473.45,2087.09,120.04,94.57 },
	{ -541.58,1973.77,126.99,270.45 },
	{ -542.31,1957.51,126.71,101.72 },
	{ -538.1,1950.43,126.15,263.45 },
	{ -538.16,1940.71,125.71,116.59 },
	{ -533.87,1930.17,124.8,281.52 },
	{ -536.64,1922.81,124.26,85.64 },
	{ -538.69,1912.26,123.55,72.61 },
	{ -542.31,1902.06,123.11,231.03 },
	{ -553.93,1891.14,123.04,225.29 },
	{ -562.53,1889.07,123.17,47.27 },
	{ -563.52,1885.74,123.07,209.01 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleService()
	if inService then
		inService = false
		TriggerEvent("Notify","amarelo","O serviço de <b>Minerador</b> foi finalizado.",3000)
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
			blip = nil
		end
	else
		startmineservice()
		startmineserviceseconds()
		inService = true
		if not ouService then
			ouService = true
			coSelected = math.random(#collect)
		end
		makeBlipMarked()
		TriggerEvent("Notify","amarelo","O serviço de <b>Minerador</b> foi iniciado.",3000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startmineservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
					local collectDis = #(coords - vector3(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]))
					if collectDis <= 150 then
						timeDistance = 4
						DrawText3D(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3],"~g~E~w~  MINERAR")
						if collectDis <= 0.8 and IsControlJustPressed(1,38) and timeSeconds <= 0 then
							SetEntityHeading(ped,collect[coSelected][4])
							SetEntityCoords(ped,collect[coSelected][1],collect[coSelected][2],collect[coSelected][3]-1)
							timeSeconds = 2
							TriggerEvent("cancelando",true)
							TriggerEvent("Progress",5000,"Minerando...")
							vRP.playAnim(false,{"amb@world_human_hammering@male@base","base"},true)
							Wait(5000)
							vSERVER.collectMethod()
							TriggerEvent("cancelando",false)
							ClearPedTasks(ped)
							vRP.removeObjects()
							coSelected = math.random(#collect)
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
function startmineserviceseconds()
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
-- MAKEBLIPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	blip = AddBlipForCoord(collect[coSelected][1],collect[coSelected][2],collect[coSelected][3])
	SetBlipSprite(blip,1)
	SetBlipColour(blip,84)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Minério")
	EndTextCommandSetBlipName(blip)
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