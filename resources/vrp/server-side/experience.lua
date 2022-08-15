-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBACKPACK - NEED TRY MOCHILAS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBackpack(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.backpack == nil then
		data.backpack = 50
	end

	return data.backpack
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBackpack(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data then
		data.backpack = amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONUSDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.bonusDelivery(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.delivery == nil then
		data.delivery = 0
	end

	return data.delivery
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBONUSDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBonusDelivery(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data.delivery then
		data.delivery = data.delivery + amount
	else
		data.delivery = amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONUSPOSTOP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.bonusPostOp(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.postop == nil then
		data.postop = 0
	end

	return data.postop
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBONUSPOSTOP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setbonusPostOp(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data.postop then
		data.postop = data.postop + amount
	else
		data.postop = amount
	end
end