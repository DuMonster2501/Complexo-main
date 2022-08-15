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
Tunnel.bindInterface("prison",cRP)
vSERVER = Tunnel.getInterface("prison")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local prison = false
local numServices = 1
local prisonTimer = 0
local prisonLocal = 1
local coordsIntern = { 1679.94,2513.07,45.56 }
local coordsExtern = { 1846.49,2584.38,45.66 }
local coordsLeaver = { 1834.09,2594.34,46.02 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local services = {
	[1] = {
		[1] = { 1760.66,2541.37,45.56,272.13,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[2] = { 1760.66,2519.02,45.56,257.96,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[3] = { 1737.34,2504.68,45.56,167.25,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[4] = { 1706.97,2481.05,45.56,229.61,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[5] = { 1700.18,2474.75,45.56,229.61,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[6] = { 1679.62,2480.31,45.56,133.23,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[7] = { 1643.85,2490.77,45.56,195.6,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[8] = { 1622.41,2507.77,45.56,99.22,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[9] = { 1609.84,2539.68,45.56,138.9,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[10] = { 1608.97,2567.06,45.56,48.19,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[11] = { 1624.54,2577.39,45.56,274.97,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[12] = { 1629.93,2564.33,45.56,0.0,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[13] = { 1652.58,2564.35,45.56,5.67,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[14] = { 1624.75,2567.13,45.56,260.79,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[15] = { 1624.82,2567.86,45.56,274.97,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[16] = { 1639.93,2565.13,45.56,0.0,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[17] = { 1642.12,2565.17,45.56,0.0,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[18] = { 1643.98,2565.12,45.56,34.02,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[19] = { 1665.12,2567.66,45.56,0.0,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[20] = { 1715.97,2567.15,45.56,87.88,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[21] = { 1715.95,2567.97,45.56,85.04,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[22] = { 1716.02,2568.8,45.56,93.55,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[23] = { 1769.52,2565.61,45.56,357.17,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[24] = { 1772.75,2536.82,45.56,246.62,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[25] = { 1758.18,2509.01,45.56,260.79,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[26] = { 1757.85,2507.75,45.56,257.96,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[27] = { 1719.87,2502.68,45.56,255.12,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[28] = { 1698.89,2472.74,45.56,232.45,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[29] = { 1698.49,2472.36,45.56,209.77,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[30] = { 1635.63,2490.22,45.56,189.93,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[31] = { 1634.64,2490.12,45.56,181.42,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[32] = { 1618.45,2521.55,45.56,138.9,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[33] = { 1607.12,2541.79,45.56,138.9,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[34] = { 1606.29,2542.63,45.56,133.23,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[35] = { 1627.85,2543.56,45.56,229.61,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[36] = { 1630.42,2527.15,45.56,235.28,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[37] = { 1649.74,2538.41,45.56,59.53,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[38] = { 1657.56,2549.39,45.56,141.74,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[39] = { 1648.29,2536.11,45.56,325.99,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[40] = { 1636.19,2553.61,45.56,2.84,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[41] = { 1699.35,2532.14,45.56,90.71,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[42] = { 1699.64,2534.6,45.56,85.04,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil },
		[43] = { 1699.27,2535.83,45.56,130.4,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",nil }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLYPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
local polyPrison = PolyZone:Create({
	vector2(1599.45,2431.56),
	vector2(1543.26,2466.83),
	vector2(1540.58,2465.89),
	vector2(1537.80,2466.93),
	vector2(1536.79,2469.65),
	vector2(1537.92,2472.23),
	vector2(1540.80,2473.48),
	vector2(1536.07,2581.75),
	vector2(1533.29,2581.75),
	vector2(1531.35,2583.62),
	vector2(1531.15,2586.77),
	vector2(1533.02,2588.79),
	vector2(1536.04,2588.89),
	vector2(1568.57,2676.85),
	vector2(1566.71,2678.22),
	vector2(1566.08,2681.34),
	vector2(1567.89,2683.63),
	vector2(1570.29,2684.16),
	vector2(1572.85,2682.63),
	vector2(1647.19,2755.03),
	vector2(1645.70,2757.99),
	vector2(1646.85,2760.73),
	vector2(1649.50,2761.82),
	vector2(1652.07,2760.78),
	vector2(1653.18,2758.50),
	vector2(1769.56,2762.85),
	vector2(1770.16,2765.12),
	vector2(1772.76,2766.68),
	vector2(1775.47,2765.86),
	vector2(1777.09,2763.44),
	vector2(1776.01,2760.06),
	vector2(1836.80,2711.40),
	vector2(1846.36,2702.30),
	vector2(1847.30,2702.94),
	vector2(1849.87,2703.27),
	vector2(1852.21,2701.25),
	vector2(1852.37,2698.60),
	vector2(1850.69,2696.25),
	vector2(1848.18,2695.90),
	vector2(1823.39,2624.75),
	vector2(1825.63,2624.59),
	vector2(1827.44,2622.50),
	vector2(1827.38,2619.79),
	vector2(1823.81,2616.74),
	vector2(1827.65,2612.55),
	vector2(1851.68,2612.47),
	vector2(1851.87,2567.91),
	vector2(1832.34,2567.99),
	vector2(1819.15,2568.87),
	vector2(1817.03,2532.44),
	vector2(1824.94,2479.18),
	vector2(1826.98,2478.19),
	vector2(1828.07,2475.56),
	vector2(1826.83,2472.86),
	vector2(1824.38,2471.87),
	vector2(1821.40,2472.90),
	vector2(1764.08,2413.05),
	vector2(1765.36,2410.49),
	vector2(1764.36,2407.72),
	vector2(1761.70,2406.47),
	vector2(1758.85,2407.50),
	vector2(1757.83,2410.91),
	vector2(1662.19,2396.35),
	vector2(1662.43,2392.94),
	vector2(1660.08,2390.91),
	vector2(1657.42,2391.12),
	vector2(1655.45,2393.29),
	vector2(1655.68,2396.55)
},{ name = "Prison" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEMTREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if prison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(services[prisonLocal][numServices][1],services[prisonLocal][numServices][2],services[prisonLocal][numServices][3]))

			if distance <= 150 then
                timeDistance = 4
				DrawText3D(services[prisonLocal][numServices][1],services[prisonLocal][numServices][2],services[prisonLocal][numServices][3],"~g~E~w~  VASCULHAR")
				if distance <= 1.5 then
					if IsControlJustPressed(1,38) and prisonTimer <= 0 then
						prisonTimer = 3
						TriggerEvent("cancelando",true)

						SetEntityHeading(ped,services[prisonLocal][numServices][4])

						if services[prisonLocal][numServices][7] == nil then
							vRP._playAnim(false,{services[prisonLocal][numServices][5],services[prisonLocal][numServices][6]},true)
						else
							vRP.createObjects(services[prisonLocal][numServices][5],services[prisonLocal][numServices][6],services[prisonLocal][numServices][7],49,28422)
						end

						SetEntityCoords(ped,services[prisonLocal][numServices][1],services[prisonLocal][numServices][2],services[prisonLocal][numServices][3]-1)
						
						TriggerEvent("Progress",15000,"Vasculhando...")
						SetTimeout(15000,function()
							vRP.removeObjects()
							vSERVER.reducePrison()
							TriggerEvent("cancelando",false)
							
							if math.random(1000) > 975 then
						    	vSERVER.giveKey()
							end
						end)
					end
				end
			end

			if GetEntityHealth(ped) <= 101 then
				TriggerEvent("updatePrison")
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if prison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(coordsLeaver[1],coordsLeaver[2],coordsLeaver[3]))

			if distance <= 1.5 then
				timeDistance = 4
				DrawText3D(coordsLeaver[1],coordsLeaver[2],coordsLeaver[3],"~g~E~w~   FUGIR")

				if distance <= 1 and IsControlJustPressed(1,38) then
					if vSERVER.checkKey() then
						SetEntityCoords(ped,coordsExtern[1],coordsExtern[2],coordsExtern[3],1,0,0,0)
						if vSERVER.callPolice() then
							vSERVER.stopPrison()
						end
					end
				end
			end

			if not polyPrison:isPointInside(coords) then
				SetEntityCoords(ped,coordsIntern[1],coordsIntern[2],coordsIntern[3],1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if prisonTimer > 0 then
			prisonTimer = prisonTimer - 1
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startPrison(status)
	prison = true
	prisonLocal = status
	numServices = math.random(#services[prisonLocal])
	prisonBlips()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopPrison()
	prison = false
	if DoesBlipExist(blips) then
		RemoveBlip(blips)
		blips = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if prison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if prisonLocal == 1 then
				if not polyPrison:isPointInside(coords) then
					SetEntityCoords(ped,1677.72,2509.68,45.57)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function prisonBlips()
	if DoesBlipExist(blips) then
		RemoveBlip(blips)
		blips = nil
	end

	blips = AddBlipForCoord(services[prisonLocal][numServices][1],services[prisonLocal][numServices][2],services[prisonLocal][numServices][3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,71)
	SetBlipScale(blips,0.6)
	SetBlipAsShortRange(blips,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Serviço")
	EndTextCommandSetBlipName(blips)
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