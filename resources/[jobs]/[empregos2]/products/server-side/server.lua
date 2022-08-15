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
Tunnel.bindInterface("products",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "cocaine", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "joint", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "meth", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "ecstasy", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "lean", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "keyboard", priceMin = 6, priceMax = 12, randMin = 1, randMax = 3 },
	{ item = "mouse", priceMin = 6, priceMax = 12, randMin = 1, randMax = 3 },
	{ item = "ring", priceMin = 6, priceMax = 12, randMin = 2, randMax = 4 },
	{ item = "watch", priceMin = 14, priceMax = 18, randMin = 3, randMax = 6 },
	{ item = "goldbar", priceMin = 20, priceMax = 24, randMin = 2, randMax = 4 },
	{ item = "playstation", priceMin = 12, priceMax = 14, randMin = 1, randMax = 1 },
	{ item = "xbox", priceMin = 12, priceMax = 14, randMin = 1, randMax = 1 },
	{ item = "legos", priceMin = 6, priceMax = 10, randMin = 1, randMax = 1 },
	{ item = "ominitrix", priceMin = 10, priceMax = 14, randMin = 1, randMax = 1 },
	{ item = "bracelet", priceMin = 14, priceMax = 16, randMin = 1, randMax = 1 },
	{ item = "dildo", priceMin = 8, priceMax = 12, randMin = 1, randMax = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local rand = math.random(v.randMin,v.randMax)
			local price = math.random(v.priceMin,v.priceMax)
			if vRP.getInventoryItemAmount(user_id,v.item) >= parseInt(rand) then
				amount[user_id] = { v.item,rand,price }

				TriggerClientEvent("products:lastItem",source,v.item)

				if (v.item == "joint" or v.item == "lean" or v.item == "meth" or v.item == "ecstasy" or v.item == "cocaine") and math.random(100) >= 75 then
					local x,y,z = vRPclient.getPositions(source)
					local copAmount = vRP.numPermission("Police")
					for k,v in pairs(copAmount) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Denúncia de Venda de Drogas", x = x, y = y, z = z, rgba = {41,76,119} })
						end)
					end
				end

				return true
			-- else
			-- 	TriggerClientEvent("Notify",source,"negado","Voce nao possui nada que me interesse",5000)
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,amount[user_id][1],amount[user_id][2],true) then
			vRP.upgradeStress(user_id,2)
			local value = amount[user_id][3] * amount[user_id][2]
			vRP.giveInventoryItem(user_id,"dollars2",parseInt(value),true)
			TriggerClientEvent("sound:source",source,"coin",0.5)
		end
	end
end