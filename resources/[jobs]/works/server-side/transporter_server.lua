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
Tunnel.bindInterface("transporter",cnVRP)
vCLIENT = Tunnel.getInterface("transporter")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 2
local collectMax = 3

local amount = {}
local amountMin = 2
local amountMax = 3

local paymentMin = 75
local paymentMax = 105
local consumeItem = "pouch"
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("transportador",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.toggleService(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTCOLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.amountCollect()
	local source = source
	if collect[source] == nil then
		collect[source] = math.random(collectMin,collectMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.amountService()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(amountMin,amountMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.collectMethod()
	cnVRP.amountCollect()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + vRP.itemWeightList(tostring(consumeItem)) * parseInt(collect[source]) <= vRP.getBackpack(user_id) then
			vRP.upgradeStress(user_id,1)
			vRP.giveInventoryItem(user_id,tostring(consumeItem),parseInt(collect[source]),true)
			collect[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
			Wait(1)
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod()
	cnVRP.amountService()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,tostring(consumeItem),parseInt(amount[source])) then
			vRP.upgradeStress(user_id,1)
			local value = math.random(paymentMin,paymentMax) * amount[source]

			vRP.giveInventoryItem(user_id,"dollars",parseInt(value))
			amount[source] = nil

			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>"..vRP.format(parseInt(amount[source])).."x "..vRP.itemNameList(consumeItem).."</b>.",5000)
		end

		return false
	end
end