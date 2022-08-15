local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

damage = {}
Tunnel.bindInterface("itemdamage",damage)

local cooldown = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(cooldown) do
			if v > 0 then
				cooldown[k] = v - 1
			end
		end
	end
end)

function damage.damageItem()
	local source = source
	local user_id = vRP.getUserId(source)

	for k,v in pairs(config.itemList) do
		local item = v.item
		local damageItem = v.damageItem
		local percentage = 0

		if vRP.getInventoryItemAmount(user_id,item) > 0 then
			local itemAmmount = parseInt(vRP.getInventoryItemAmount(user_id,item))
			local itemName = vRP.itemNameList(item)

			if damageItem == nil then
				if cooldown[user_id] == 0 or not cooldown[user_id] then
					cooldown[user_id] = 5
					percentage = math.random(100)
					if percentage >= 60 then
						if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
							if percentage >= 70 then
								TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName.."</b> caiu de sua mochila.",5000)
							else
								TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName.."</b> caiu de sua mochila.",5000)
							end
							percentage = 0
							return true
						end
					end
				else
					return false
				end
			else
				if vRP.tryGetInventoryItem(user_id,item,itemAmmount) then
					vRP.giveInventoryItem(user_id,damageItem,itemAmmount)
					TriggerClientEvent("Notify",source,"amarelo","Você entrou na água e perdeu <b>"..itemName.."</b>.",3000)
					return true
				end
			end
		end
	end
end