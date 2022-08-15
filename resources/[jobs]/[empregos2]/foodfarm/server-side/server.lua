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
Tunnel.bindInterface("foodfarm",cnVRP)
vCLIENT = Tunnel.getInterface("foodfarm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVALANCHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("avalanches",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Avalanches") then
			vCLIENT.toggleService(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"damage-item","<div style='opacity: 0.7;'><i>Aviso sobre sua Mochila</i></div>Você não tem mais espaço em sua Mochila.",5000)
			TriggerClientEvent("sound:source",source,"when",0.5)
			return
		end

		if not status then
			vRP.giveInventoryItem(user_id,"bread",2,true)
			vRP.giveInventoryItem(user_id,"alface",1,true)
			vRP.giveInventoryItem(user_id,"burguer",1,true)
			vRP.giveInventoryItem(user_id,"queijo",1,true)
			vRP.giveInventoryItem(user_id,"tomate",1,true)
			TriggerClientEvent("sound:source",source,"takeThis",0.5)
		else
			vRP.giveInventoryItem(user_id,"bread",2,true)
			vRP.giveInventoryItem(user_id,"alface",1,true)
			vRP.giveInventoryItem(user_id,"burguer",1,true)
			vRP.giveInventoryItem(user_id,"queijo",1,true)
			vRP.giveInventoryItem(user_id,"tomate",1,true)
			TriggerClientEvent("sound:source",source,"takeThis",0.5)
		end

	end
end