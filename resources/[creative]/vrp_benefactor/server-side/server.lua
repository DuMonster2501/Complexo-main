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
Tunnel.bindInterface("benefactor",cnVRP)
vCLIENT = Tunnel.getInterface("benefactor")
vPLAYER = Tunnel.getInterface("vrp_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local typeCars = {}
local typeBikes = {}
local beneModels = {
    [1] = { model = "zion" },
    [2] = { model = "jackal" },
    [3] = { model = "faction2" },
    [4] = { model = "mesa" }
}
local lockReq = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local vehicles = vRP.vehicleGlobal()
	for k,v in pairs(vehicles) do
		if v[4] == "cars" then
			table.insert(typeCars,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]) })
		elseif v[4] == "bikes" then
			table.insert(typeBikes,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("benefactor:syncVehicles",source,beneModels)
	TriggerClientEvent("benefactor:syncList",source,typeCars,typeBikes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("benefactor:setVehicles")
AddEventHandler("benefactor:setVehicles",function(veh,slot)
	beneModels[slot].model = veh
	TriggerClientEvent("benefactor:syncVehicles",-1,beneModels)
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
			TriggerClientEvent("Notify",source,"negado","Encontramos faturas pendentes.",3000)
			return
		end

		local vehName = tostring(name)
		local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(user_id) })
		local myGarages = vRP.getInformation(user_id)
		if vRP.getPremium(user_id) then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) + 2 then
				TriggerClientEvent("Notify",source,"importante","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		else
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"importante","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehName })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(vehName).."</b>.",3000)
			return
		else
			if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
				vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
				TriggerClientEvent("Notify",source,"sucesso","A compra foi concluída com sucesso.",5000)
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
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
		if vRP.vehicleType(name) ~= nil or vRP.vehicleType(name) == "donate" then
			if not lockReq[user_id] or lockReq[user_id] <= os.time() then
				lockReq[user_id] = os.time() + 300
				local vehName = tostring(name)
				local getInvoice = vRP.getInvoice(user_id)
				if getInvoice[1] ~= nil then
					TriggerClientEvent("Notify",source,"negado","Encontramos faturas pendentes.",3000)
					return
				end

				vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..vehName })
				vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..vehName })
				vRP.execute("vRP/rem_vehicle",{ user_id = parseInt(user_id), vehicle = vehName })
				vRP.addBank(user_id,parseInt(vRP.vehiclePrice(name)*0.75))
				TriggerClientEvent("Notify",source,"sucesso","Venda concluida com sucesso.",7000)
			else
				TriggerClientEvent("Notify",source,"negado","Aguarde 5 minutos para vender novamente.",7000)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Voce nao pode vender este veiculo.",7000)
		end
	end
end