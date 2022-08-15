-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("radio",cRP)
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local myFrequency = 0
local activeRadio = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("radioClose",function(data,cb)
	vRP.removeObjects("one")
	SetNuiFocus(false,false)
    SendNUIMessage({ action = "hideMenu" })
    cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:openSystem")
AddEventHandler("radio:openSystem",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })

	if not IsPedInAnyVehicle(PlayerPedId()) then
		vRP.createObjects("cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data.freq) >= 1 and parseInt(data.freq) <= 999 then
		vSERVER.activeFrequency(data.freq)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function(data)
	if myFrequency ~= 0 then
		TriggerEvent("radio:outServers")
		TriggerEvent("Notify","amarelo","Rádio desativado.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startFrequency(frequency)
	if activeFrequencys ~= 0 then
		exports["tokovoip"]:removePlayerFromRadio(activeFrequencys)
	end

	exports["tokovoip"]:addPlayerToRadio(frequency)
	activeFrequencys = frequency
	activeRadio = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	if activeFrequencys ~= 0 then
		exports["tokovoip"]:removePlayerFromRadio(activeFrequencys)
		TriggerEvent("hud:RadioDisplay",0)
		activeFrequencys = 0
		activeRadio = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:THREADCHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		if activeRadio then
			if vSERVER.checkRadio() then
				TriggerEvent("radio:outServers")
			end
		end
		Citizen.Wait(10000)
	end
end)