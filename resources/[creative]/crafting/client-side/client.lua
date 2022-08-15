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
Tunnel.bindInterface("crafting",cRP)
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,weight,maxweight,infos = vSERVER.requestCrafting(data.craft)
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data,cb)
	vSERVER.functionCrafting(data.index,data.craft,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data,cb)
	vSERVER.functionDestroy(data.index,data.craft,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("crafting:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("crafting:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateCrafting(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
    { 68.88,-1570.04,29.6,"generalCrafting"},
    { 2662.41,3468.25,55.95,"ilegalCrafting" },
    { -216.43,-1318.9,30.9,"fueltechCrafting" }, -- Los Santos Ilegal
	{ 94.43,-1294.03,29.27,"boateCrafting" },
    { 1275.74,-1710.31,54.76,"mafiaCrafting" },
	{ 429.61,-2051.68,18.74,"vagosCrafting" },
	{ 103.76,-1994.97,14.89,"ballasCrafting" },
    { 839.74,-974.78,26.49,"mecanicoCrafting" }, -- 1
	{ -40.05,-1056.27,28.4,"mecanicoCrafting" }, -- 2
	{ 803.11,-961.21,25.98,"mecanicoCrafting" }, -- 3
	{ -345.41,-130.92,39.01,"mecanicoCrafting" }, -- 4
    { 1593.14,6455.61,26.02,"avalanchesCrafting" },
	{ 84.17,-1552.07,29.6,"lixeiroShop" },
	{ 713.89,-961.52,30.4,"dressMaker" },
	{ 169.56,-1634.05,29.28,"foodMarket" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(craftList) do
		table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E","Loja de Criação","Pressione para abrir" })
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

			for k,v in pairs(craftList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.25 then
					timeDistance = 4

					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]) })
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:MECHANICSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:mechanicCraft",function()
	if vSERVER.requestPerm("mechanicCraft") then
		SendNUIMessage({ action = "showNUI", name = tostring("mechanicCraft")})
		SetNuiFocus(true,true)
	end
end)