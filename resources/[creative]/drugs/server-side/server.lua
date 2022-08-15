-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPRAGE = Tunnel.getInterface("garages")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("drugs",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
local insertPedlist = {}

--------------------------------------------------------------------------------------------------------------
-- ADICIONA O NPC NA LISTA
--------------------------------------------------------------------------------------------------------------
function cRP.insertPedlist(npc)
    TriggerClientEvent("drugs:insertList",source,npc)
end

function cRP.giveKey(placa)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("setPlateEveryone",placa)
		TriggerEvent("setPlatePlayers",placa,user_id)
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "cocaine", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "joint", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "meth", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "ecstasy", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 },
	{ item = "lean", priceMin = 2, priceMax = 10, randMin = 3, randMax = 6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return not vRP.hasPermission(user_id,"Police") or not vRP.hasPermission(user_id,"Mechanic") or not vRP.hasPermission(user_id,"Paramedic")
	else
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local rand = math.random(v.randMin,v.randMax)
			local price = math.random(v.priceMin,v.priceMax)
			if vRP.getInventoryItemAmount(user_id,v.item) >= parseInt(rand) then
				amount[user_id] = { v.item,rand,price }

				TriggerClientEvent("drugs:lastItem",source,v.item)

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
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,amount[user_id][1],amount[user_id][2],true) then
			vRP.upgradeStress(user_id,2)
			local value = amount[user_id][3] * amount[user_id][2]
			vRP.giveInventoryItem(user_id,"dollars2",parseInt(value),true)
			TriggerClientEvent("sounds:source",source,"coin",0.5)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------

local RntRoubo = {
	[1] = { item = "dildo", RnTMin = 1, RnTMax = 3 },
	[2] = { item = "bracelet", RnTMin = 2, RnTMax = 4, },
	[3] = { item = "ominitrix", RnTMin = 1, RnTMax = 3, },
	[4] = { item = "watch", RnTMin = 1, RnTMax = 3, },
	[5] = { item = "dollars", RnTMin = 100, RnTMax = 250, },
	[6] = { item = "lighter", RnTMin = 1, RnTMax = 2, },
	[7] = { item = "silverring", RnTMin = 1, RnTMax = 2, },
	[8] = { item = "domino", RnTMin = 3, RnTMax = 5, },
	[9] = { item = "teddy", RnTMin = 1, RnTMax = 2, },
	[10] = { item = "rose", RnTMin = 1, RnTMax = 3, },
}

function cRP.paymentRobbery()
	local source = source
	local user_id = vRP.getUserId(source)

	local resultado = RntRoubo[math.random(#RntRoubo)]
	local resultado2 = RntRoubo[math.random(#RntRoubo)]

	local quantidade = math.random(resultado.RnTMin,resultado.RnTMax)
	local quantidade2 = math.random(resultado2.RnTMin,resultado2.RnTMax)

	local chance = math.random(100)

	if user_id then
		vRP.giveInventoryItem(user_id,resultado.item,quantidade,true)
		if chance < 40 then
			vRP.giveInventoryItem(user_id,resultado2.item,quantidade2,true)
		end
		TriggerClientEvent("sounds:source",source,"coin",0.5)
		quantidade = nil
		resultado = nil
	end
end