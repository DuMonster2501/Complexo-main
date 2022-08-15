-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("atm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENATM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("atm:openATM",function()
	if vSERVER.requestWanted() and (not exports["player"]:blockCommands() or not exports["player"]:handCuff()) then 
		SetNuiFocus(true,true)	    
		SendNUIMessage({ action = "show", saldo = tostring(saldo) })
		vRP._playAnim(false,{"amb@prop_human_atm@male@base","base"},true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ATM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("atm",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(cATM.atmObjects) do
		if vSERVER.requestWanted() and (not exports["player"]:blockCommands() or not exports["player"]:handCuff()) then 
			if DoesObjectOfTypeExistAtCoords(coords,0.6,GetHashKey(v),true) then
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "show", saldo = tostring(saldo) })
				vRP._playAnim(false,{"amb@prop_human_atm@male@base","base"},true)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hide" })
	vRP._playAnim(false,{"amb@prop_human_atm@male@exit","exit"},false)
	Citizen.Wait(4000)
	vRP._stopAnim()
end)

RegisterNetEvent("atmCloseEvent")
AddEventHandler("atmCloseEvent", function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hide" })
	vRP._playAnim(false,{"amb@prop_human_atm@male@exit","exit"},false)
	Citizen.Wait(4000)
	vRP._stopAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deposit",function(data)
	if parseInt(data["value"]) > 0 then
		vSERVER.atmDeposit(data["value"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("withdraw",function(data)
	if parseInt(data["value"]) > 0 then
		vSERVER.atmWithdraw(data["value"])
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saldodoBanco",function(data,cb)
    local resultado = vSERVER.getSaldoBank()
	--TriggerEvent("Notify","amarelo",resultado,3000)
	if resultado then
		cb({ valorfinal = resultado })
	else
		local resultado = vSERVER.getSaldo()
		cb({ valorfinal = resultado })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLETRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandleTransfer", function(data,cb)
	local amount,target = parseInt(data["amount"]),parseInt(data["target"])
	local newSaldo = vSERVER.transferirValor(amount,target)
	cb({ saldo = tostring(newSaldo) })
end)