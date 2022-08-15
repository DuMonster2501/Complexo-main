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
Tunnel.bindInterface("checkin",cRP)
vSERVER = Tunnel.getInterface("checkin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local checkIn = {
	{ 1140.07,-1536.97,35.39,"Fiacre" },
	{ 1832.58,3676.68,34.28,"Fiacre2" },
	{ -254.7,6331.95,32.43,"Fiacre3" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDSIN
-----------------------------------------------------------------------------------------------------------------------------------------
local bedsIn = {
	["Fiacre"] = {
		{ 1148.95,-1562.89,36.3,6.37 },
		{ 1148.81,-1565.88,36.3,182.39 },
		{ 1120.49,-1547.0,35.9,2.49 },
		{ 1123.66,-1546.89,35.9,353.98 }
	},
	["Fiacre2"] = {
		{ 1818.23,3672.96,35.2,300.78},
		{ 1817.28,3674.58,35.2,295.45 },
		{ 1818.21,3677.54,35.2,216.44 },
		{ 1819.88,3678.65,35.2,211.44 }
	},
	["Fiacre3"] = {
		{ -252.23,6323.15,33.35,134.62 },
		{ -256.1,6315.47,33.35,312.67 },
		{ -254.34,6313.71,33.35,312.67 },
		{ -247.09,6318.09,33.35,134.13 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(checkIn) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~  ATENDIMENTO")
					if distance <= 2 and IsControlJustPressed(1,38) and vSERVER.checkServices() then
						local checkBusy = 0
						local checkSelected = v[4]

						for _,v in pairs(bedsIn[checkSelected]) do
							checkBusy = checkBusy + 1

							local checkPos = nearestPlayer(v[1],v[2],v[3])
							if checkPos == nil then
								if vSERVER.paymentCheckin() then
									TriggerEvent("player:blockCommands",true)
									SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
									
									if GetEntityHealth(ped) <= 101 then
										vRP.revivePlayer(102)
									end

									DoScreenFadeOut(1000)
									Citizen.Wait(1000)

									SetEntityCoords(ped,v[1],v[2],v[3])

									Citizen.Wait(500)
									TriggerEvent("emotes","checkinskyz")

									Citizen.Wait(5000)
									DoScreenFadeIn(1000)
								end
								
								break
							end
						end

						if checkBusy >= #bedsIn[checkSelected] then
							TriggerEvent("Notify","amarelo","Todas as macas estão ocupadas, aguarde.",5000)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers(x2,y2,z2)
	local r = {}
	local players = vRP.getPlayers()
	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local distance = #(coords - vector3(x2,y2,z2))
			if distance <= 2 then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayer(x,y,z)
	local p = nil
	local players = nearestPlayers(x,y,z)
	local min = 2.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
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