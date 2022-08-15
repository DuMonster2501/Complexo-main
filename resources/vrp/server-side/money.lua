-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addBank(user_id,amount)
	if amount > 0 then
		vRP.execute("vRP/add_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBank(user_id,amount)
	if amount > 0 then
		vRP.execute("vRP/set_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delBank(user_id,amount)
	if amount > 0 then
		vRP.execute("vRP/del_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBank(user_id)
	local consult = vRP.getInformation(user_id)
	if consult[1] then
		return consult[1].bank
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentBank(user_id,amount)
	if amount > 0 then
		local consult = vRP.getInformation(user_id)
		if consult[1] then
			if consult[1].bank >= amount then
				vRP.execute("vRP/del_bank",{ id = parseInt(user_id), bank = parseInt(amount) })

				local source = vRP.getUserSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "-","dollars",vRP.format(amount),"Dólares" })
					TriggerClientEvent("sounds:source",source,"cash",0.3)
				end
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.withdrawCash(user_id,amount)
	if amount > 0 then
		local consult = vRP.getInformation(user_id)
		if consult[1] then
			if consult[1].bank >= amount then
				vRP.giveInventoryItem(user_id,"dollars",amount,true)
				vRP.execute("vRP/del_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setInvoice(user_id,price,nuser_id,text)
	vRP.execute("vRP/add_invoice",{ user_id = user_id, nuser_id = tostring(nuser_id), date = os.date("%d.%m.%Y"), price = price, text = tostring(text) })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInvoice(user_id)
	return vRP.query("vRP/get_invoice",{ user_id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMYINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getMyInvoice(nuser_id)
	return vRP.query("vRP/get_myinvoice",{ nuser_id = nuser_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setFines(user_id,price,nuser_id,text)
	vRP.execute("vRP/add_fines",{ user_id = user_id, nuser_id = tostring(nuser_id), date = os.date("%d.%m.%Y"), price = price, text = tostring(text) })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getFines(user_id)
	return vRP.query("vRP/get_fines",{ user_id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setSalary(user_id,price)
	vRP.execute("vRP/add_salary",{ user_id = user_id, date = os.date("%d.%m.%Y"), price = price })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getSalary(user_id)
	return vRP.query("vRP/get_salary",{ user_id = user_id })
end