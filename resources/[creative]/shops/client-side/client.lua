-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("shops",cnVRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,weight,maxweight,infos = vSERVER.requestShop(data.shop)
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data,cb)
	vSERVER.functionShops(data.shop,data.item,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:Update")
AddEventHandler("shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DEPARTAMENTSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:departamentStore",function()
	if GetClockHours() >= 0 and GetClockHours() <= 24 then
		SendNUIMessage({ action = "showNUI", name = tostring("departamentStore"), type = vSERVER.getShopType("departamentStore") })
		SetNuiFocus(true,true)
		TriggerEvent("sounds:source","shop",0.5)
	else
		TriggerEvent("Notify","amarelo","Loja fechada, a mesma só funciona das <b>15</b> ás <b>20</b> horas.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:AMMUNATIONSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:ammunationStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("ammunationStore"), type = vSERVER.getShopType("ammunationStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:NORMALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:normalpharmacyStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("normalpharmacyStore"), type = vSERVER.getShopType("normalpharmacyStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CASINOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:casinoStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("casinoStore"), type = vSERVER.getShopType("casinoStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOSPITALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hospitalpharmacyStore",function()
	if vSERVER.requestPerm("hospitalpharmacyStore") then
		SendNUIMessage({ action = "showNUI", name = tostring("hospitalpharmacyStore"), type = vSERVER.getShopType("hospitalpharmacyStore") })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEGAMALL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:megaMallStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("megaMallStore"), type = vSERVER.getShopType("megaMallStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:RECYCLINGSELL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:recyclingSell",function()
		SendNUIMessage({ action = "showNUI", name = tostring("recyclingSell"), type = vSERVER.getShopType("recyclingSell") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BARSSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:barsStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("barsStore"), type = vSERVER.getShopType("barsStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:JEWELRYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:jewelryStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("jewelryStore"), type = vSERVER.getShopType("jewelryStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HUNTINGSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:huntingStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("huntingStore"), type = vSERVER.getShopType("huntingStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HUNTINGSTORE2
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:huntingStore2",function()
	SendNUIMessage({ action = "showNUI", name = tostring("huntingStore2"), type = vSERVER.getShopType("huntingStore2") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("coffeeMachine"), type = vSERVER.getShopType("coffeeMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COLAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:colaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("colaMachine"), type = vSERVER.getShopType("colaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("sodaMachine"), type = vSERVER.getShopType("sodaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("donutMachine"), type = vSERVER.getShopType("donutMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("burgerMachine"), type = vSERVER.getShopType("burgerMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("hotdogMachine"), type = vSERVER.getShopType("hotdogMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("waterMachine"), type = vSERVER.getShopType("waterMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:mechanic",function()
	SendNUIMessage({ action = "showNUI", name = tostring("mechanic"), type = vSERVER.getShopType("mechanic") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:drugsSelling",function()
	SendNUIMessage({ action = "showNUI", name = tostring("drugsSelling"), type = vSERVER.getShopType("drugsSelling") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DigitalDentStore
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:DigitalDentStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("DigitalDentStore"), type = vSERVER.getShopType("DigitalDentStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:POLICESTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:policeStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("policeStore"), type = vSERVER.getShopType("policeStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ 1272.33,-1711.61,54.78,"robberysSelling" },
	{ -947.73,-2044.73,9.41,"policeStore" },
	{ 1852.59,3691.92,34.27,"policeStore" },  
	{ -451.02,6011.51,31.72,"policeStore" },  
	{ -1082.23,-247.56,37.77,"premiumStore" },
	{ 839.62,-957.5,26.49,"mechanic" },
	{ 1116.1,219.91,-49.43,"casinoStore" }, -- 1
	{ 1116.55,221.85,-49.43,"casinoStore" }, -- 2
	{ 1116.62,218.05,-49.43,"casinoStore" } -- 3
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(shopList) do
		table.insert(innerTable,{ v[1],v[2],v[3],1,"E","Venda de Produtos","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(shopList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1 then
					timeDistance = 4

					if IsControlJustPressed(1,38) then
						if v[6] then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
						else
							if vSERVER.requestPerm(v[4]) then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
							end
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)