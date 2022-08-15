-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local sacou = 0
local depositou = 0
local salario = 0
local fatura = 0
local multado = 0
local transferido = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("bank",cRP)
vCLIENT = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
-- function cRP.requestWanted()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if not vRP.wantedReturn(user_id) then
-- 			return true
-- 		end
-- 		return false
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestBank()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		return identity.bank
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestFines()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local fines = {}
		local consult = vRP.getFines(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = "Government", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return fines
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finesPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if multado == 0 then
			multado = multado + 1
			vCLIENT.blockButtons(source,true)
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"salario","Multa sendo paga...",5000)
			SetTimeout(3000,function()
				vCLIENT.blockButtons(source,false)
				if vRP.paymentBank(user_id,parseInt(price)) then
					TriggerClientEvent("Notify",source,"dinheiro","Multa paga com sucesso!",5000)
					TriggerClientEvent("bank:Update",source,"requestFines")
					vRP.execute("vRP/del_fines",{ id = parseInt(id), user_id = parseInt(user_id) })
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end)
		else
			TriggerClientEvent("Notify",source,"tempo","Aguarde 10 segundos para pagar outro multa.",5000)
		end
		if multado >= 1 then
			Wait(10000)
			multado = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMySalarys()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local salary = {}
		local consult = vRP.getSalary(user_id)
		for k,v in pairs(consult) do
			table.insert(salary,{ id = v.id, user_id = parseInt(v.user_id),  date = v.date, price = parseInt(v.price) })
		end
		return salary
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.salaryPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if salario == 0 then
			vCLIENT.blockButtons(source,true)
			salario = salario + 1
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"salario","Transferindo seu salário...",5000)
			SetTimeout(3000,function()
				vRP.execute("vRP/del_salary",{ id = parseInt(id), user_id = parseInt(user_id) })
				vRP.addBank(user_id,tonumber(price))
				vCLIENT.blockButtons(source,false)
				TriggerClientEvent("Notify",source,"dinheiro","Sálario transferido com sucesso!",5000)
				TriggerClientEvent("bank:Update",source,"requestMySalarys")
			end)
		end
		if salario >= 1 then 
			Citizen.Wait(3500)
			salario = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getInvoice(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = "Governament", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMyInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getMyInvoice(user_id)
		for k,v in pairs(consult) do
			local identity = vRP.getUserIdentity(v.user_id)
			if identity then
				table.insert(invoices,{ name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invoicesPayment(id,price,nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if fatura == 0 then
			fatura = fatura + 1
			vCLIENT.blockButtons(source,true)
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"salario","Fatura sendo paga...",5000)
			SetTimeout(3000,function()
				vCLIENT.blockButtons(source,false)
				if vRP.paymentBank(user_id,parseInt(price)) then
					TriggerClientEvent("Notify",source,"dinheiro","Fatura paga com sucesso!",5000)
					if parseInt(nuser_id) > 0 then
						vRP.addBank(nuser_id,parseInt(price))
					end
					TriggerClientEvent("bank:Update",source,"requestInvoices")
					vRP.execute("vRP/del_invoice",{ id = parseInt(id), user_id = parseInt(user_id) })
				else
					TriggerClientEvent("bankCloseEvent",source)
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end)
		end

		if fatura >= 1 then
			Wait(2000)
			fatura = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if depositou == 0 then
			depositou = depositou + 1

			vCLIENT.blockButtons(source,true)
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"salario","Efetuando deposito...",5000)
			SetTimeout(3000,function()
				vCLIENT.blockButtons(source,false)
				TriggerClientEvent("Notify",source,"dinheiro","Deposito efetuado com sucesso!",5000)
				if parseInt(amount) > 0 then
					if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(amount)) then
						vRP.addBank(user_id,parseInt(amount))
						TriggerClientEvent("bank:Update",source,"requestInicio")
					end
				end
			end)
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"tempo","Aguarde 15 segundos para efetuar um deposito.",5000)
		end
		if depositou >= 1 then
			Wait(15000)
			depositou = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Encontramos faturas pendentes.",3000)
			return
		end

		local getFines = vRP.getFines(user_id)
		if getFines[1] ~= nil then
			TriggerClientEvent("Notify",source,"vermelho","Encontramos multas pendentes.",3000)
			return
		end
		if sacou == 0 then
			sacou = sacou + 1
			if parseInt(amount) > 0 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("dollars") * parseInt(amount) <= vRP.getBackpack(user_id) then
					vCLIENT.blockButtons(source,true)
					TriggerClientEvent("bankCloseEvent",source)
					TriggerClientEvent("Notify",source,"salario","Sacando seu dinheiro...",5000)
					SetTimeout(3000,function()
						vCLIENT.blockButtons(source,false)
						if vRP.withdrawCash(user_id,parseInt(amount)) then
							TriggerClientEvent("Notify",source,"dinheiro","Dinheiro sacado com sucesso!",5000)
							TriggerClientEvent("bank:Update",source,"requestInicio")
						else
							TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
						end
					end)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		else
			TriggerClientEvent("bankCloseEvent",source)
			TriggerClientEvent("Notify",source,"tempo","Aguarde um minuto para efetuar outro saque.",5000)
		end

		if sacou >= 1 then 
			Wait(60000)
			sacou = 0
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERIRVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.transferirValor(amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local nplayer = vRP.getUserSource(target)
	local nuser_id = vRP.getUserId(nplayer)
	local identity2 = vRP.getUserIdentity(nuser_id)
	local banco = 0
	local banco = vRP.getBank(user_id)
	local banconu = vRP.getBank(nuser_id)

	--if nuser_id then
		if nuser_id ~= user_id then
			if tonumber(amount) > 0 then
				if banco > tonumber(amount) then
					if transferido == 0 then
						transferido = transferido + 1
						vCLIENT.blockButtons(source,true)
						TriggerClientEvent("bankCloseEvent",source)
						TriggerClientEvent("Notify",source,"salario","Transferindo...",5000)
						SetTimeout(3000,function()
							vCLIENT.blockButtons(source,false)
							vRP.paymentBank(user_id,parseInt(amount))
							vRP.addBank(nuser_id,banconu+tonumber(amount))
							TriggerClientEvent("Notify",nplayer,"dinheiro","<b>"..identity.name.." "..identity.name2.."</b> depositou <b>$"..amount.." dólares</b> na sua conta.",8000)
							TriggerClientEvent("Notify",source,"dinheiro","Você transferiu <b>$"..amount.." dólares</b> para conta de <b>"..identity2.name.." "..identity2.name2.."</b>.",8000)
						end)
					else
						TriggerClientEvent("bankCloseEvent",source)
						TriggerClientEvent("Notify",source,"tempo","Aguarde 30 segundos para efetuar outra transferência",5000)
					end
				end
			end
		else
			TriggerClientEvent("bankCloseEvent",source)
			--TriggerClientEvent("Notify",source,"negado","Não encontramos a conta do ID fornecido.",5000)
		end
	--end
	if transferido >= 1 then 
		Wait(30000)
		transferido = 0
	end
end