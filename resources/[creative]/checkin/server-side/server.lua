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
Tunnel.bindInterface("checkin",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) > 1 then
		TriggerClientEvent("Notify",source,"amarelo","Existem médicos em serviço.",3000)
		Wait(1000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Mechanic") then
			TriggerClientEvent("Notify",source,"verde","Seu tratamento ficou por conta da casa.",5000)
			return true
		end
		
		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1000
		end
		
		if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(value)) then
			TriggerClientEvent("Notify",source,"amarelo","Você pagou <b>$"..value.."</b> dólares pelo atendimento.",3000)
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem <b>$"..value.."</b> dólares.",3000)
			Wait(1000)
		end
	end
	return false
end