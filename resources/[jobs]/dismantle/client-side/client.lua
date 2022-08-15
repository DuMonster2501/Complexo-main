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
Tunnel.bindInterface("dismantle",cRP)
vSERVER = Tunnel.getInterface("dismantle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inService = false
local timeDismantle = 0
local disX,disY,disZ = 2342.71,3052.38,47.67
local listX,listY,listZ = 2340.87,3128.03,48.21
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    { 2340.87,3128.03,48.21 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreaddesmanche()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)
					local distance = #(coords - vector3(disX,disY,disZ))
					if distance <= 3 then
						timeDistance = 4
						dwText("~y~E~w~  PRESSIONE PARA DESMANCHAR",0.95)
						if IsControlJustPressed(1,38) and timeDismantle <= 0 then
							timeDismantle = 3
							local status,vehicle = vSERVER.checkVehlist()
							if status then
								TaskTurnPedToFaceEntity(ped,vehicle,1000)
								Citizen.Wait(2000)
								SetEntityInvincible(ped,true)
								FreezeEntityPosition(ped,true)
								TriggerEvent("cancelando",true)
								FreezeEntityPosition(vehicle,true)
								vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

								for i = 0,5 do
									Citizen.Wait(10000)
									SetVehicleDoorBroken(vehicle,i,false)
								end

								for i = 0,7 do
									Citizen.Wait(10000)
									SetVehicleTyreBurst(vehicle,i,1,1000.01)
								end

								vRP.removeObjects()
								SetEntityInvincible(ped,false)
								FreezeEntityPosition(ped,false)
								TriggerEvent("cancelando",false)
								vSERVER.paymentMethod(vehicle)
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
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timeDismantle > 0 then
			timeDismantle = timeDismantle - 1
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(listX,listY,listZ))
			if distance <= 1 then
				timeDistance = 4
				if IsControlJustPressed(1,38) and distance <= 1.1 then
					startthreaddesmanche()
					vSERVER.acessList()
					inService = true
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(localidades) do
		table.insert(innerTable,{ v[1],v[2],v[3],1,"E","Ferro Velho","Pressione para conversar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end