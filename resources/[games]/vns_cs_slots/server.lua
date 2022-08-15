local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP")

local ToClient = {}
Tunnel.bindInterface(GetCurrentResourceName(),ToClient)

math.randomseed(os.clock()*100000000000)
math.randomseed(os.clock()*math.random())
math.randomseed(os.clock()*math.random())

-- ESX = nil
local activeSlot = {}
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ToClient.IsSeatUsed = function(index)
	if activeSlot[index] ~= nil then
		if activeSlot[index].used then
			return true
		else
			activeSlot[index].used = true
			return false
		end
	else
		activeSlot[index] = {}
		activeSlot[index].used = true
		return false
	end
end

RegisterServerEvent('casino:slots:notUsing')
AddEventHandler('casino:slots:notUsing',function(index)
	if activeSlot[index] ~= nil then
		activeSlot[index].used = false
	end
end)



RegisterServerEvent('casino:taskStartSlots')
AddEventHandler('casino:taskStartSlots',function(index, data)
	local source = source
	--local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = vRP.getUserId(source)
	local tirar = vRP.tryGetInventoryItem(user_id,Config.ItemName,data.bet)
	if tirar then
		if activeSlot[index] then
			local w = {a = math.random(1,16),b = math.random(1,16),c = math.random(1,16)}
			
			local rnd1 = math.random(1,100)
			local rnd2 = math.random(1,100)
			local rnd3 = math.random(1,100)
			
			if Config.Offset then
				if rnd1 > 70 then w.a = w.a + 0.5 end
				if rnd2 > 70 then w.b = w.b + 0.5 end
				if rnd3 > 70 then w.c = w.c + 0.5 end
			end
			
			TriggerClientEvent('casino:slots:startSpin', source, index, w)
			activeSlot[index].win = w
		end
	end
end)



RegisterServerEvent('casino:slotsCheckWin')
AddEventHandler('casino:slotsCheckWin',function(index, data, dt)
	local source = source
	if activeSlot[index] then
		if activeSlot[index].win then
			if activeSlot[index].win.a == data.a
			and activeSlot[index].win.b == data.b
			and activeSlot[index].win.c == data.c then
				CheckForWin(source,activeSlot[index].win, dt)
			end
		end
	end
end)



function CheckForWin(source, w, data)
	local user_id = vRP.getUserId(source)
	local a = Config.Wins[w.a]
	local b = Config.Wins[w.b]
	local c = Config.Wins[w.c]
	local total = 0
	if a == b and b == c and a == c then
		if Config.Mult[a] then
			total = data.bet*Config.Mult[a]
		end		
	elseif a == '6' and b == '6' then
		total = data.bet*5
	elseif a == '6' and c == '6' then
		total = data.bet*5
	elseif b == '6' and c == '6' then
		total = data.bet*5
		
	elseif a == '6' then
		total = data.bet*2
	elseif b == '6' then
		total = data.bet*2
	elseif c == '6' then
		total = data.bet*2
	end
	if total > 0 then
		
		local peso = (vRP.getInventoryMaxWeight(user_id) - vRP.getInventoryWeight(user_id)) - (vRP.getItemWeight(Config.ItemName)*total)
		if peso >= 0 then
			vRP.giveInventoryItem(user_id,Config.ItemName,total)
			TriggerClientEvent('Notify', source, 'verde','Você ganhou um total de: '..total..'x '..vRP.itemNameList(Config.ItemName))
			return
		end
		TriggerClientEvent('Notify', source, 'vermelho','Mochila cheia.')
	end
end

ToClient.itemNameList = function(item)
	return vRP.itemNameList(item)
end