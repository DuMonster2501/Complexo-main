-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("radio",cnVRP)
vCLIENT = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,911)
					TriggerClientEvent("hud:RadioDisplay",source,911)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 912 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("hud:RadioDisplay",source,912)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 913 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,913)
					TriggerClientEvent("hud:RadioDisplay",source,913)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 914 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,914)
					TriggerClientEvent("hud:RadioDisplay",source,914)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 915 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,915)
					TriggerClientEvent("hud:RadioDisplay",source,915)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"Paramedic") then
					vCLIENT.startFrequency(source,112)
					TriggerClientEvent("hud:RadioDisplay",source,112)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"Mechanic") then
					vCLIENT.startFrequency(source,443)
					TriggerClientEvent("hud:RadioDisplay",source,443)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 224 then
				if vRP.hasPermission(user_id,"Bennys") then
					vCLIENT.startFrequency(source,224)
					TriggerClientEvent("hud:RadioDisplay",source,224)
					TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("hud:RadioDisplay",source,parseInt(freq))
				TriggerClientEvent("Notify",source,"verde",""..parseInt(freq)..".0Mhz</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"radio") < 1 then
			return true
		end
		return false
	end
end