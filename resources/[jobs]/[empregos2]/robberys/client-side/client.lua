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
Tunnel.bindInterface("robberys",cRP)
vSERVER = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local startRobbery = false
local robberyTimer = 0
local robberyId = 0
local vars = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(vars) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					timeDistance = 4

					if not startRobbery then
						if distance <= 1 then
							DrawText3D(v.x,v.y,v.z-0.4,"~g~E~w~  ROUBAR",400)
							if distance <= 1 and IsControlJustPressed(1,38) and vSERVER.checkPolice(k,coords) then
								robberyId = k
								startRobbery = true
								robberyTimer = v.time
							end
						end
					else
						DrawText3D(v.x,v.y,v.z-0.4,"AGUARDE  "..robberyTimer.."  SEGUNDOS",370)
					end
				end
			end

			if startRobbery then
				local distance = #(coords - vector3(vars[robberyId].x,vars[robberyId].y,vars[robberyId].z))
				if distance > vars[robberyId].distance or GetEntityHealth(ped) <= 101 then
					startRobbery = false
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if startRobbery then
			if robberyTimer > 0 then
				robberyTimer = robberyTimer - 1
				if robberyTimer <= 0 then
					startRobbery = false
					vSERVER.paymentMethod(robberyId)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateVars(status)
	vars = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(176,180,193,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/height
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,50,55,67,200)
end