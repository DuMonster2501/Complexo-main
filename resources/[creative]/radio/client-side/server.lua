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
vCLIENT = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,911)
					TriggerClientEvent("hud:channel",source,911)
					TriggerClientEvent("Notify",source,"verde","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 912 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("hud:channel",source,912)
					TriggerClientEvent("Notify",source,"verde","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"Paramedic") then
					vCLIENT.startFrequency(source,112)
					TriggerClientEvent("hud:channel",source,112)
					TriggerClientEvent("Notify",source,"verde","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"Mechanic") then
					vCLIENT.startFrequency(source,443)
					TriggerClientEvent("hud:channel",source,443)
					TriggerClientEvent("Notify",source,"verde","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("hud:channel",source,parseInt(freq))
				TriggerClientEvent("Notify",source,"verde","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"radio") < 1 then
			return true
		end
		return false
	end
end