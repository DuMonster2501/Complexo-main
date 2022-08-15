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
Tunnel.bindInterface("miner",cRP)
vCLIENT = Tunnel.getInterface("miner")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 1
local collectMax = 2
local amount = {}
local amountMin = 2
local amountMax = 3
-----------------------------------------------------------------------------------------------------------------------------------------
-- miner
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("minerador",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.toggleService(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + 1 > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			Wait(1)
		else
			
			local random = math.random(100)
			if parseInt(random) >= 87 then
				vRP.giveInventoryItem(user_id,"turquesa",math.random(3),true)
			elseif parseInt(random) >= 76 and parseInt(random) <= 86 then
				vRP.giveInventoryItem(user_id,"safira",math.random(3),true)
			elseif parseInt(random) >= 66 and parseInt(random) <= 75 then
				vRP.giveInventoryItem(user_id,"esmeralda",math.random(3),true)
			elseif parseInt(random) >= 51 and parseInt(random) <= 65 then
				vRP.giveInventoryItem(user_id,"diamante",math.random(3),true)
			elseif parseInt(random) >= 46 and parseInt(random) <= 50 then
				vRP.giveInventoryItem(user_id,"copper",math.random(5),true)
			elseif parseInt(random) >= 26 and parseInt(random) <= 45 then
				vRP.giveInventoryItem(user_id,"ametista",math.random(3),true)
			elseif parseInt(random) >= 7 and parseInt(random) <= 25 then
				vRP.giveInventoryItem(user_id,"ambar",math.random(3),true)
			elseif parseInt(random) >= 1 and parseInt(random) <= 6 then
				vRP.giveInventoryItem(user_id,"aluminum",math.random(5),true)
			end
			
			vRP.upgradeStress(user_id,2)
			collect[source] = nil
			return true
		end
		return false
	end
end