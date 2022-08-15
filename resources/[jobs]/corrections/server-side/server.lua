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
cRP = {}
Tunnel.bindInterface("corrections",cRP)
vCLIENT = Tunnel.getInterface("corrections")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,"Police")
	else
--		TriggerClientEvent("Notify",source,"negado","Apenas mecânicos podem tunar veículos.",5000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,1)
		local value = math.random(220,380)

		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
	end
end