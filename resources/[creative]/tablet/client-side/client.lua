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
vSERVER = Tunnel.getInterface("tablet")

local antDump = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

function closeNui()
	vRP.removeObjects("one")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:openSystem")
AddEventHandler("tablet:openSystem",function()
	local ped = PlayerPedId()
	if not IsPauseMenuActive() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "openSystem" })

		if not IsPedInAnyVehicle(PlayerPedId()) and not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("tablet","Abrir o tablet","keyboard","f1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	vRP.removeObjects("one")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRANKING
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNUICallback("requestRanking",function(data,cb)
-- 	cb(vSERVER.requestRanking(data["id"]))
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAluguel",function(data,cb)
	local veiculos = vSERVER.Aluguel()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestServicos",function(data,cb)
	local veiculos = vSERVER.Servicos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	local veiculos = vSERVER.Possuidos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTax",function(data,cb)
	vSERVER.requestTax(data["name"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyDealer",function(data)
	if data.name ~= nil then
		vSERVER.buyDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellDealer",function(data)
	if data.name ~= nil then
		vSERVER.sellDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTABOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAbout",function(data,cb)
	local inventario,peso,maxpeso,infos = vSERVER.requestAbout()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTGAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inputGame",function(data,cb)
	closeNui()
	cb(vSERVER.beastGame(data.value,data.animal))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTPIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inputPix", function(data,cb)
	closeNui()
	cb(vSERVER.inputPix(data.value,data.target))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:updateMedia")
AddEventHandler("tablet:updateMedia",function(media,data,back)
	SendNUIMessage({ action = "messageMedia", media = media, data = data, back = back })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { -56.86,-1095.35,26.43 }
----------------------------------------------------------------------------------------------------------------------------------------- 
-- REQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestDrive",function(data, cb)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(benCoords[1],benCoords[2],benCoords[3]))
	if distance <= 3 then
		local driveIn = vSERVER.startDrive(data.name)
		if driveIn then
			TriggerEvent("races:insertList",true)
			local hash = GetHashKey(data["name"])
			lastPlayerCoords = GetEntityCoords(PlayerPedId())

			if testDriveEntity ~= nil then
				DeleteEntity(testDriveEntity)
			end

			testDriveEntity = vehCreate(data["name"],"55DTA141",-56.93,-1109.15,26.44,72.77)
			Citizen.Wait(3000)
			DoScreenFadeOut(1000)
			Citizen.Wait(3000)
			SetPedIntoVehicle(ped,vehDrive,-1)
			startCountDown = true

			DoScreenFadeIn(1000)
		end
	else
		TriggerEvent("Notify","amarelo","Dirija-se ate a <b>Benefactor</b> para efetuar o teste.",2000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate,x,y,z,h)
	local user_id = vRP.getUserId(source)
	TriggerServerEvent("setPlateEveryone",vehPlate)
	TriggerServerEvent("setPlatePlayers",vehPlate,user_id)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		vehDrive = CreateVehicle(mHash,x,y,z,h,true,false)

		SetEntityInvincible(vehDrive,true)
		SetVehicleOnGroundProperly(vehDrive)
		SetVehicleNumberPlateText(vehDrive,vehPlate)
		SetEntityAsMissionEntity(vehDrive,true,true)
		SetVehicleHasBeenOwnedByPlayer(vehDrive,true)
		SetVehicleNeedsToBeHotwired(vehDrive,false)

		SetModelAsNoLongerNeeded(mHash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        if startCountDown then
            timeDistance = 5
            DisableControlAction(1,69,false)

            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped) then
                Citizen.Wait(1000)

				vSERVER.removeDrive()
                startCountDown = false
                DeleteEntity(vehDrive)
                SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
				TriggerEvent("races:insertList",false)
            end
        end

        Citizen.Wait(timeDistance)
    end
end)