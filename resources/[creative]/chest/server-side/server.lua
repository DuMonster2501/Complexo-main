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
Tunnel.bindInterface("chest",cnVRP)
vCLIENT = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chestOpen = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('createChest',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and vRP.hasPermission(user_id,"Admin") then
		local x,y,z = vRPclient.getPositions(source)

		local nome = vRP.prompt(source,"Nome do chest?","")
		if nome == "" then
			return
		end

		local perm = vRP.prompt(source,"Permissao do chest?","")
		if perm == "" then
			return
		end

		local tamanho = vRP.prompt(source,"Tamanho do chest?","")
		if tamanho == "" then
			return
		end

		vCLIENT.insertTable(-1,nome, { x,y,z } )
		vRP.execute("vRP/addChest", { permiss = perm, name = nome, x = x, y = y, z = z, weight = tamanho })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local rows = vRP.query("vRP/get_alltable")
    if #rows > 0 then
		for k,v in pairs(rows) do
			vCLIENT.insertTable(source,rows[k].name, { rows[k].x,rows[k].y,rows[k].z } )
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	Citizen.Wait(2000)
-- 	local rows = vRP.query("vRP/get_alltable")
--     if #rows > 0 then
-- 		for k,v in pairs(rows) do
-- 			vCLIENT.insertTable(-1,rows[k].name, { rows[k].x,rows[k].y,rows[k].z } )
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(parseInt(user_id)) then
			return false
		end
		local consult = vRP.query("vRP/getExistChest",{ name = chestName })
		if consult[1].name == chestName then
			if vRP.hasPermission(parseInt(user_id),consult[1].permiss) then
				chestOpen[user_id] = chestName
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestOpen[user_id] then
			chestOpen[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local myinventory = {}
		local mychestopen = {}
		local mychestname = chestOpen[parseInt(user_id)]
		if mychestname ~= nil then

			local inv = vRP.getInventory(parseInt(user_id))
			if inv then
				for k,v in pairs(inv) do
					if string.sub(v.item,1,9) == "toolboxes" then
						local advFile = LoadResourceFile("logsystem","toolboxes.json")
						local advDecode = json.decode(advFile)

						v.durability = advDecode[v.item]
					end

					v.amount = parseInt(v.amount)
					v.name = vRP.itemNameList(v.item)
					v.desc = vRP.itemDescList(v.item)
					v.tipo = vRP.itemTipoList(v.item)
					v.unity = vRP.itemUnityList(v.item)
					v.economy = vRP.itemEconomyList(v.item)
					v.peso = vRP.itemWeightList(v.item)
					v.index = vRP.itemIndexList(v.item)
					v.key = v.item
					v.slot = k

					myinventory[k] = v
				end
			end

			local data = vRP.getSData("chest:"..mychestname)
			local sdata = json.decode(data) or {}
			if data then
				for k,v in pairs(sdata) do
					table.insert(mychestopen,{desc = vRP.itemDescList(k), unity = vRP.itemUnityList(k), tipo = vRP.itemTipoList(k), economy = vRP.itemEconomyList(k),amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.itemWeightList(k) })
				end
			end
			local consult = vRP.query("vRP/getExistChest",{ name = mychestname })
			if consult[1].name == mychestname then
				return myinventory,mychestopen,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeChestWeight(sdata),consult[1].weight,{ identity.name.." "..identity.name2,parseInt(user_id),identity.phone,identity.registration,vRP.getBank(user_id) }
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cola"] = true,
	["soda"] = true,
	["coffee"] = true,
	["water"] = true,
	["dirtywater"] = true,
	["emptybottle"] = true,
	["hamburger"] = true,
	["tacos"] = true,
	["chocolate"] = true,
	["donut"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:populateSlot")
AddEventHandler("chest:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("chest:Update",source,"updateChest")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:updateSlot")
AddEventHandler("chest:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("chest:Update",source,"updateChest")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:sumSlot")
AddEventHandler("chest:sumSlot",function(itemName,slot,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(slot)].item == itemName then
				if vRP.tryChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,slot) then
					TriggerClientEvent("chest:Update",source,"updateChest")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.storeItem(itemName,slot,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if noStore[itemName] or vRP.itemSubTypeList(itemName) then
				TriggerClientEvent("Notify",source,"amarelo","Você não pode armazenar este item em baús.",5000)
				return
			end
			local consult = vRP.query("vRP/getExistChest",{ name = tostring(chestOpen[parseInt(user_id)]) })
			if consult[1].name == tostring(chestOpen[parseInt(user_id)]) then
				if vRP.storeChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,consult[1].weight,slot) then
					TriggerClientEvent("chest:Update",source,"updateChest")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.takeItem(itemName,slot,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.tryChestItem(user_id,"chest:"..tostring(chestOpen[parseInt(user_id)]),itemName,amount,slot) then
				TriggerClientEvent("chest:Update",source,"updateChest")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if chestOpen[user_id] then
		chestOpen[user_id] = nil
	end
end)