
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
Tunnel.bindInterface("atm",cnVRP)
vCLIENT = Tunnel.getInterface("atm")

local saque = 0
local deposito = 0
local bugatm = 0
local transferido = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestWanted()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) then
			return true
		end
		return false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALDO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getSaldo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getBank(user_id)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getSaldoBank()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
	--	TriggerClientEvent("Notify",source,"amarelo","kd o valor",5000)
		local valor = vRP.getBank(user_id)
	--	TriggerClientEvent("Notify",source,"amarelo",valor,5000)
        return valor
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(atmTimers) do
			if v[1] > 0 then
				v[1] = v[1] - 10
				if v[1] <= 0 then
					atmTimers[k] = nil
				end
			end
		end
		Citizen.Wait(10000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SACARVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.atmWithdraw(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if parseInt(valor) > 5000 then
			TriggerClientEvent("atmCloseEvent",source)
			TriggerClientEvent("Notify",source,"amarelo","Limite de saque máximo atingido.",5000)
			TriggerClientEvent("atmActived",source,false)
			return 
		end
		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("atmCloseEvent",source)
			TriggerClientEvent("Notify",source,"negado","Encontramos faturas pendentes.",3000)
			return
		end
		local getFines = vRP.getFines(user_id)
		if getFines[1] ~= nil then
			TriggerClientEvent("atmCloseEvent",source)
			TriggerClientEvent("Notify",source,"negado","Encontramos multas pendentes.",3000)
			TriggerClientEvent("atmActived",source,false)
			return
		end
		if valor == saque then
			TriggerClientEvent("atmCloseEvent",source)
			TriggerClientEvent("Notify",source,"vermelho","Você acabou de solicitar o mesmo valor, tente mais tarde.",10000)
		else
			if parseInt(valor) > 0 then
				saque = valor
				if atmTimers[user_id] then
					if atmTimers[user_id][1] > 0 and atmTimers[user_id][2] >= 5000 then
						TriggerClientEvent("Notify",source,"azul","Aguarde "..vRP.getTimers(parseInt(atmTimers[user_id][1])).."</b>.",5000)
						return vRP.getBank(user_id)
					end

					if bugatm == 0 then 
						bugatm = bugatm + 1
						TriggerClientEvent("atmCloseEvent",source)
						if (atmTimers[user_id][2] + parseInt(valor)) <= 5000 then
							TriggerClientEvent("Notify",source,"salario","Sacando...",5000)
							SetTimeout(3000,function()
								atmTimers[user_id] = { 600,parseInt(valor) }
								TriggerClientEvent("atmActived",source,false)
								TriggerClientEvent("cancelando",source,true)
								TriggerClientEvent("Notify",source,"dinheiro","Saque realizado com sucesso!",6000)
								if vRP.withdrawCash(user_id,parseInt(valor)) then
									TriggerClientEvent("cancelando",source,true)
									TriggerClientEvent("atmActived",source,false)
									TriggerClientEvent("Notify",source,"dinheiro","Saque realizado com sucesso!",6000)
									atmTimers[user_id][2] = atmTimers[user_id][2] +  parseInt(valor)
								else
									TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
								end
							end)
						else
							TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de retiradas.",5000)
						end

					else
						TriggerClientEvent("atmActived",source,false)
						bugatm = bugatm + 1
						TriggerClientEvent("Notify",source,"azul","Aguarde 15 segundos para efetuar outro saque.",10000)
						return
					end
				else
					if bugatm == 0 then 
						bugatm = bugatm + 1
						TriggerClientEvent("atmCloseEvent",source)
						if vRP.withdrawCash(user_id,parseInt(valor)) then
							atmTimers[user_id] = { 600,parseInt(valor) }
							TriggerClientEvent("atmActived",source,false)
							TriggerClientEvent("cancelando",source,true)
							TriggerClientEvent("Progress",source,5000,"Utilizando...")
							TriggerClientEvent("Notify",source,"dinheiro","Saque realizado com sucesso!",6000)
						else
							TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
						end
					else
						TriggerClientEvent("atmCloseEvent",source)
						TriggerClientEvent("atmActived",source,false)
						bugatm = bugatm + 1
						TriggerClientEvent("Notify",source,"azul","Você está fazendo isso rápido demais, tente mais tarde.",10000)
						return
					end
				end
			end
		end

		if bugatm >= 1 then 
			Citizen.Wait(15000)
			bugatm = 0
			TriggerClientEvent("cancelando",source,false)
		end

		if saque >= 1 then 
			Citizen.Wait(60000)
			saque = 0
			TriggerClientEvent("cancelando",source,false)
		end

		return vRP.getBank(user_id)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SACARVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.atmDeposit(valor)
	local source = source
	local amount = valor
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if parseInt(amount) > 0 then
			if bugatm == 0 then 
				bugatm = bugatm + 1
				if amount == deposito then
					TriggerClientEvent("Notify",source,"vermelho","Você acabou de depositar mesmo valor, tente mais tarde.",10000)
				else
					deposito = amount
					if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(amount),true,slot) then
						TriggerClientEvent("atmCloseEvent",source)
						TriggerClientEvent("Notify",source,"salario","Depositando...",5000)
						SetTimeout(3000,function()
							vRP.addBank(user_id,parseInt(amount))
							TriggerClientEvent("atmActived",source,false)
							TriggerClientEvent("cancelando",source,true)
							TriggerClientEvent("Notify",source,"dinheiro","Deposito realizado com sucesso!",6000)
						end)
					else
						TriggerClientEvent("atmCloseEvent",source)
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta carteira.",5000)
					end
				end
			else
				TriggerClientEvent("atmCloseEvent",source)
				TriggerClientEvent("atmActived",source,false)
				bugatm = bugatm + 1
				TriggerClientEvent("Notify",source,"azul","Você acabou de depositar, tente mais tarde.",10000)
				return
			end
		end

		if bugatm >= 1 then 
			Citizen.Wait(5000)
			bugatm = 0
			TriggerClientEvent("cancelando",source,false)
		end

		if deposito >= 1 then 
			Citizen.Wait(60000)
			deposito = 0
			TriggerClientEvent("cancelando",source,false)
		end
		
		return vRP.getBank(user_id)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERIRVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.transferirValor(amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local nplayer = vRP.getUserSource(target)
	local nuser_id = vRP.getUserId(nplayer)
	local identity2 = vRP.getUserIdentity(nuser_id)
	local banco = 0
	local banco = vRP.getBank(user_id)
	local banconu = vRP.getBank(nuser_id)

	if nuser_id then
		if nuser_id ~= user_id then
			if tonumber(amount) >= 0 and tonumber(amount) <= 3000 then
				if banco > tonumber(amount) then
					if transferido == 0 then
						transferido = transferido + 1
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("bankCloseEvent",source)
						TriggerClientEvent("Notify",source,"salario","Transferindo...",5000)
						SetTimeout(3000,function()
							TriggerClientEvent("cancelando",source,false)
							vRP.paymentBank(user_id,parseInt(amount))
							vRP.addBank(nuser_id,banconu+tonumber(amount))
							TriggerClientEvent("Notify",nplayer,"dinheiro","<b>"..identity.name.." "..identity.name2.."</b> depositou <b>$"..amount.." dólares</b> na sua conta.",8000)
							TriggerClientEvent("Notify",source,"dinheiro","Você transferiu <b>$"..amount.." dólares</b> para conta de <b>"..identity2.name.." "..identity2.name2.."</b>.",8000)
						end)
					else
						TriggerClientEvent("atmCloseEvent",source)
						TriggerClientEvent("Notify",source,"negado","Aguarde 5 minutos para efetuar outra transferência",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Caixas eletronicos só aceitam até 3.000,00 dólares de transferencia.",5000)
			end
		else
			TriggerClientEvent("atmCloseEvent",source)
			TriggerClientEvent("Notify",source,"negado","Não encontramos a conta do ID fornecido.",5000)
		end
	end
	if transferido >= 1 then 
		Wait(300000)
		transferido = 0
	end
end