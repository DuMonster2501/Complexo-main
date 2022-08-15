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
Tunnel.bindInterface("bdonate",cnVRP)
vCLIENT = Tunnel.getInterface("bdonate")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local typeCars = {}
local typeBikes = {}
local beneModels = {
    [1] = { model = "mclarensenna" },
    [2] = { model = "ferrarif12" },
    [3] = { model = "nissangtr2" },
    [4] = { model = "teslaprior" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local vehicles = vRP.vehicleGlobal()
	for k,v in pairs(vehicles) do
		if v[4] == "donate" then
			table.insert(typeCars,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]) })
		elseif v[4] == "donatebikes" then
			table.insert(typeBikes,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("bdonate:syncVehicles",source,beneModels)
	TriggerClientEvent("bdonate:syncList",source,typeCars,typeBikes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bdonate:setVehicles")
AddEventHandler("bdonate:setVehicles",function(veh,slot)
	beneModels[slot].model = veh
	TriggerClientEvent("bdonate:syncVehicles",-1,beneModels)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOWNED
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getOwned()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehList = {}
		local vehicles = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicles) do
			table.insert(vehList,{ k = v.vehicle, name = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)*0.7), chest = parseInt(vRP.vehicleChest(v.vehicle)) })
		end
		return vehList
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestBuy(name,form)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Encontramos faturas pendentes.",3000)
			return
		end

		local vehName = tostring(name)
		local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(user_id) })
		local myGarages = vRP.getInformation(user_id)
		if vRP.getPremium(user_id) then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) + 2 then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		else
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehName })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>"..vRP.vehicleName(vehName).."</b>.",3000)
			return
		else
			if vRP.remGmsId(user_id,parseInt(vRP.vehiclePrice(vehName))) then
				vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
				vRP.execute("vRP/set_rental_time",{ user_id = parseInt(user_id), vehicle = vehName, premiumtime = parseInt(os.time()+30*24*60*60) })

				TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","Coins insuficiente na sua conta bancária.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestSell(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- local vehName = tostring(name)
		-- local getInvoice = vRP.getInvoice(user_id)
		-- if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Nao podemos revender carros vips.",5000)
		-- 	return
		-- end

		-- vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..vehName })
		-- vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..vehName })
		-- vRP.execute("vRP/rem_vehicle",{ user_id = parseInt(user_id), vehicle = vehName })
		-- vRP.addBank(user_id,parseInt(vRP.vehiclePrice(name)*0.75))
	end
end