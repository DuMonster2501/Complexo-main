-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("tablet",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local motos = {}
local carros = {}
local aluguel = {}
local servicos = {}
local bichoSelect = "1"
local registerGames = {}

Citizen.CreateThread(function()
	local vehicles = vRP.vehicleGlobal()
	for k,v in pairs(vehicles) do
		if v[4] == "cars" then
			table.insert(carros,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500 })
		elseif v[4] == "bikes" then
			table.insert(motos,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500 })
		elseif v[4] == "donate" then
			table.insert(aluguel,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 1500})
		elseif v[4] == "work" then
			table.insert(servicos,{ k = k, name = v[1], price = v[3], chest = parseInt(v[2]), tax = 500})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdealership = "https://discord.com/api/webhooks/897251888746070017/weGjNpHrLnDdmRI-0_pHB7iYEdNgllL_LVIIQUD_572sTDmsGw1Yd1ig0WQ5Oy_qRaoU"
local webhookpaytax = "https://discord.com/api/webhooks/897251888746070017/weGjNpHrLnDdmRI-0_pHB7iYEdNgllL_LVIIQUD_572sTDmsGw1Yd1ig0WQ5Oy_qRaoU"

function creativelogs(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Aluguel()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return aluguel
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Servicos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return servicos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehList = {}
		local vehicles = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicles) do
			table.insert(vehList,{ k = v.vehicle, work = v.work, name = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)*0.7), chest = parseInt(vRP.vehicleChest(v.vehicle)) })
		end
		return vehList
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTABOUT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestAbout()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			local inventory = {}
			for k,v in pairs(inv) do
					inventory[k] = v
				end

			local identity = vRP.getUserIdentity(user_id)
			return inventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PIX
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.inputPix(value,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,value) then
			vRP.addBank(target,value)
			TriggerClientEvent("Notify",source,"verde","Você transferiu <b>$"..value.."</b> dólares para o PIX <b>"..target.."<b/>.",3000)

			local nSource = vRP.getUserSource(target)
			if nSource then
				TriggerClientEvent("itensNotify",nSource,{ "Recebeu","dollars",vRP.format(value),"Dólares" })
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",3000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BICHOS
-----------------------------------------------------------------------------------------------------------------------------------------
local bichoGames = {
	[1] = "Camelo",
	[2] = "Pavão",
	[3] = "Elefante",
	[4] = "Coelho",
	[5] = "Burro",
	[6] = "Gato",
	[7] = "Galo",
	[8] = "Trigre",
	[9] = "Rato"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local drawTimers = {
	["10:00:00"] = true,
	["11:13:00"] = true,
	["14:00:00"] = true,
	["16:00:00"] = true,
	["18:00:00"] = true,
	["20:00:00"] = true,
	["22:00:00"] = true,
	["00:00:00"] = true,
	["02:00:00"] = true,
	["04:00:00"] = true,
	["06:00:00"] = true,
	["08:00:00"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION LISTAR OU COMPRAR BICHO VALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.beastGame(value,animal)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if bichoGames[parseInt(animal)] and parseInt(value) > 0 then
			if registerGames[animal] == nil then
				registerGames[animal] = {}
			end
			if registerGames[animal][parseInt(user_id)] == nil then
				if vRP.paymentBank(user_id,parseInt(value)) then
					registerGames[animal][tostring(user_id)] = parseInt(value)
					TriggerClientEvent("Notify",source,"verde","Aposta de <b>$"..vRP.format(value).."</b> dólares no <b>"..bichoGames[parseInt(animal)].."</b>.",4000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Ja existe uma aposta no <b>"..bichoGames[parseInt(animal)].."</b>.",7000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
	while true do
		if drawTimers[os.date("%H:%M:%S")] then
			local winners = 0
			bichoSelect = tostring(math.random(#bichoGames))

			if registerGames[bichoSelect] then
				for k,v in pairs(registerGames[bichoSelect]) do
					winners = winners

					if vRP.getPremium(parseInt(k)) then
						vRP.addBank(parseInt(k), parseInt(v * 2.5))
						TriggerClientEvent("Notify",k,"verde","Recebeu $<b>"..vRP.format(parseInt(v[2] * 2.5)).."</b> do jogo do <b>Bicho</b>.",7000)
					else
						vRP.addBank(parseInt(k), parseInt(v * 2))
						TriggerClientEvent("Notify",k,"verde","Recebeu $<b>"..vRP.format(parseInt(v[2] * 2)).."</b> do jogo do <b>Bicho</b>.",7000)
					end
				end
			end

			if winners >= 1 then
				TriggerClientEvent("Notify",-1,"roxo","O resultado do <b>Jogo do Bicho</b> foi <b>"..bichoGames[parseInt(bichoSelect)].."</b>, Os pagamentos foram efetuados aos <b>"..winners.."</b> ganhadores do jogo do <b>bicho</b>.",11000)
			else
				TriggerClientEvent("Notify",-1,"roxo","O resultado do <b>Jogo do Bicho</b> foi <b>"..bichoGames[parseInt(bichoSelect)].."</b>, Os pagamentos foram efetuados aos ganhadores do jogo do <b>bicho</b>.",11000)
			end

			for i = 1, parseInt(#bichoGames) do
				registerGames[tostring(i)] = {}
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local vehName = tostring(name)
		local vehPlate = vRP.vehList(source,11)
		local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(user_id) })
		local myGarages = vRP.getInformation(user_id)
		local plateId = vRP.getVehiclePlate(vehPlate)

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Encontramos faturas pendentes.",3000)
			return
		end

		if vRP.getPremium(user_id) then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		elseif vRP.vehicleType(name) ~= "work" then
			if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) + 2 then
				TriggerClientEvent("Notify",source,"amarelo","Você atingiu o máximo de veículos em sua garagem.",3000)
				return
			end
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehName })
		if vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>"..vRP.vehicleName(vehName).."</b>.",3000)
			return
		else
			if vRP.vehicleType(name) == "donate" then
				if vRP.remGmsId(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
					vRP.execute("vRP/set_rental_time",{ user_id = parseInt(user_id), vehicle = vehName, premiumtime = parseInt(os.time()+30*24*60*60) })	
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Gemas insuficientes.",3000)
				end
			elseif vRP.vehicleType(name) == "work" then
				if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(true) })
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			else
				if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(vehName))) then
					vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
					vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 1, time = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"verde","A compra foi concluída com sucesso.",5000)
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[COMPROU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sellDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.vehicleType(name) == "donate" then
			TriggerClientEvent("Notify",source,"vermelho","Você não pode vender este veiculo.",7000)
		else
			if vRP.vehicleType(name) ~= nil then
				local vehName = tostring(name)
					vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..vehName })
					vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..vehName })
					vRP.execute("vRP/rem_vehicle",{ user_id = parseInt(user_id), vehicle = vehName })
					vRP.addBank(user_id,parseInt(vRP.vehiclePrice(name)*0.75))
					TriggerClientEvent("Notify",source,"verde","Venda concluida com sucesso.",7000)
					TriggerClientEvent("itensNotify",source,{ "RECEBEU","dollars",vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)),"Dólares" })
					creativelogs(webhookdealership,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não pode vender este veiculo.",7000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestTax(name,plate)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vehPlate = vRP.vehList(source,11)
	local plateId = vRP.getVehiclePlate(vehPlate)

	if user_id and name then
		if vRP.vehicleType(name) == "donate" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "cars" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "bikes" then
			if vRP.paymentBank(user_id,1500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
		if vRP.vehicleType(name) == "work" then
			if vRP.paymentBank(user_id,500) then
				vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
				TriggerClientEvent("Notify",source,"verde","Você pagou as taxas do seguro do seu veículo",5000)
				creativelogs(webhookpaytax,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[VENDEU]: "..vRP.vehicleName(name).." [POR]: $ "..vRP.format(parseInt(vRP.vehiclePrice(name)*0.75)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro suficiente em sua conta bancária.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startDrive(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.vehicleType(name) == "work" then
			TriggerClientEvent("Notify",source,"amarelo","Você não pode testar este veículo.",5000)
		else
			local paymentDrive = vRP.request(source,"Deseja iniciar um teste neste veículo por <b>$50</b> dólares?",15)
			if paymentDrive then
				if vRP.paymentBank(user_id,50) then
					TriggerClientEvent("Notify",source,"azul","Teste iniciado, para finalizar saia do veículo.",5000)
					SetPlayerRoutingBucket(source,math.random(1,500))
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","Você não possui dinheiro em sua conta bancária.")
					return false
				end
			end
			return false
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("Notify",source,"azul","Você saiu do veículo e seu teste foi encerrado.",5000)
		SetPlayerRoutingBucket(source,0)
	end
end