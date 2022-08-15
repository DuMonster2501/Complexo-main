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
Tunnel.bindInterface("methlabs",cnVRP)
vSERVER = Tunnel.getInterface("methlabs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(gallons) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4

					if v[5] >= 100 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   RETIRAR")
					elseif v[5] > 0 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~y~"..v[5].."%~w~  PROGRESSO")
					else
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   LIGAR")
					end

					if IsControlJustPressed(1,38) and distance <= 0.8 then
						vSERVER.checkStatus(k)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTRANSFORM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(39.01,3717.33,11.01))
			if distance <= 1.5 then
				timeDistance = 4
				DrawText3D(39.01,3717.33,11.01,"~g~E~w~   PRODUZIR")
				if IsControlJustPressed(1,38) and distance <= 0.8 then
					vSERVER.checkProduction()
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("methlabs:labUpdate")
AddEventHandler("methlabs:labUpdate",function(status)
	gallons = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end