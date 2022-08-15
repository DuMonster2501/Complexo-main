-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("methlabs",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ 45.40,3714.058,11.00,40,0 },
	{ 41.05,3714.898,11.00,20,0 },
	{ 38.08,3714.555,11.00,60,0 },
	{ 42.65,3712.817,11.00,20,0 },
	{ 38.91,3710.714,11.00,40,0 },
	{ 35.15,3711.206,11.00,20,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(gallons) do
			if v[5] > 0 and v[5] < 100 then
				v[5] = v[5] + 2
			end
		end
		TriggerClientEvent("methlabs:labUpdate",-1,gallons)
		Citizen.Wait(36000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkStatus(processId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"TheLost") then
			if parseInt(gallons[processId][5]) <= 0 then
				if vRP.tryGetInventoryItem(user_id,"analgesic",parseInt(gallons[processId][4])) then
					gallons[processId][5] = 1
					TriggerClientEvent("methlabs:labUpdate",-1,gallons)
				else
					TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..vRP.format(parseInt(gallons[processId][4])).."x "..vRP.itemNameList("analgesic").."</b>.",5000)
				end
			elseif parseInt(gallons[processId][5]) >= 100 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("methliquid") * parseInt(gallons[processId][4]) <= vRP.getBackpack(user_id) then
					gallons[processId][5] = 0
					TriggerClientEvent("methlabs:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"methliquid",parseInt(gallons[processId][4]),true)
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRODUCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkProduction()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"TheLost") then
			if vRP.tryGetInventoryItem(user_id,"methliquid",10) then
				TriggerClientEvent("Progress",source,5000,"Checando...")
				TriggerClientEvent("cancelando",source,true)
				Citizen.Wait(5000)
				vRP.giveInventoryItem(user_id,"meth",10,true)
				TriggerClientEvent("cancelando",source,false)
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>10x "..vRP.itemNameList("methliquid").."</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("methlabs:labUpdate",source,gallons)
end)