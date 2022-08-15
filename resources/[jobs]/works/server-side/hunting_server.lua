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
Tunnel.bindInterface("hunting",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			Wait(1)
		else
			
			local random = math.random(100)
			if parseInt(random) >= 96 then
				vRP.giveInventoryItem(user_id,"meatA",math.random(3),true)
			elseif parseInt(random) >= 78 and parseInt(random) <= 95 then
				vRP.giveInventoryItem(user_id,"meatB",math.random(3),true)
			elseif parseInt(random) >= 66 and parseInt(random) <= 75 then
				vRP.giveInventoryItem(user_id,"meatC",math.random(3),true)
			elseif parseInt(random) >= 36 and parseInt(random) <= 65 then
				vRP.giveInventoryItem(user_id,"meatS",math.random(3),true)
			elseif parseInt(random) >= 0 and parseInt(random) <= 35 then
				vRP.giveInventoryItem(user_id,"animalpelt",math.random(5),true)
			end
			
			collect[source] = nil
			return true
		end
		return false
	end
end