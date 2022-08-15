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
Tunnel.bindInterface("skinshop",cRP)
vCLIENT = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateClothes(clothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"Clothings",clothes)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.applySkin(nplayer,GetHashKey(args[2]))
				vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mascara",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getMask(source)
				TriggerClientEvent("skinshop:setMask",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("skinshop:setMask",source)
			end
		else
			TriggerClientEvent("skinshop:setMask",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chapeu",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getHat(source)
				TriggerClientEvent("skinshop:setHat",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("skinshop:setHat",source)
			end
		else
			TriggerClientEvent("skinshop:setHat",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("oculos",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getGlasses(source)
				TriggerClientEvent("skinshop:setGlasses",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("skinshop:setGlasses",source)
			end
		else
			TriggerClientEvent("skinshop:setGlasses",source)
		end
	end
end)