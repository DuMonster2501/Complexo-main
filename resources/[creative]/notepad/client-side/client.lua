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
Tunnel.bindInterface("notepad",cnVRP)
vSERVER = Tunnel.getInterface("notepad")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local notePad = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notepad:createNotepad")
AddEventHandler("notepad:createNotepad",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNotepad" })
	vRP.createObjects("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("escape",function()
	SetNuiFocus(false)
	vRP.removeObjects("one")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("editNote",function(data)
	SetNuiFocus(false)
	vRP.removeObjects("one")
	SendNUIMessage({ action = "hideNotepad" })
	vSERVER.editNotepad(data.id,data.text)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropNote",function(data)
	SetNuiFocus(false)
	vRP.removeObjects("one")
	SendNUIMessage({ action = "hideNotepad" })
	vSERVER.createNotepad(data.text)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notepad:removePlayers")
AddEventHandler("notepad:removePlayers",function(id)
	if notePad[id] ~= nil then
		notePad[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notepad:sendPlayers")
AddEventHandler("notepad:sendPlayers",function(id,status)
	notePad[id] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateNotepad(status)
	notePad = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(notePad) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= 5 then
					timeDistance = 4
					DrawText3Ds(v.x,v.y,v.z-0.8,"~g~E~w~   LER     ~r~G~w~   DESTRUIR")
					if distance <= 1.2 then
						if IsControlJustPressed(1,38) then
							SetNuiFocus(true,true)
							SendNUIMessage({ action = "showNotepad2", text = v.text, id = v.id })
							vRP.createObjects("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
						elseif IsControlJustPressed(1,47) then
							vSERVER.destroyNotepad(v.id)
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/500
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end