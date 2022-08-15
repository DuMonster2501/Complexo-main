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
Tunnel.bindInterface("vrp_lucky_wheel",cRP)
vSERVER = Tunnel.getInterface("vrp_lucky_wheel")

local spawned = true
local _wheel = nil
local _base = nil
local _lambo = nil
local _isShowCar = false
local _wheelPos = vector3(1111.07,228.05,-49.63)
local _baseWheelPos = vector3(1111.05,229.33,-49.63)
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
local _isRolling = false

Citizen.CreateThread(function()
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')
    local baseWheelModel = GetHashKey('vw_prop_vw_luckywheel_01a')
    
    _wheel = CreateObject(model, 1111.05,229.78,-46.5 - 3.88, false, false, true)
    --_base = CreateObject (baseWheelModel, 949.41,44.59,71.64 -316.63, false, false, true)
    -- local carmodel = GetHashKey('sian2')

    Citizen.CreateThread(function()
        -- Base wheel
        RequestModel(baseWheelModel)
        while not HasModelLoaded(baseWheelModel) do
            Citizen.Wait(0)
        end
        RequestModel(model)

        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetEntityHeading(bundle, 50)
        SetEntityHeading(_wheel, 0)
        SetEntityHeading(_base, 0)
        SetModelAsNoLongerNeeded(model)
        SetModelAsNoLongerNeeded(baseWheelModel)

        --[[Citizen.CreateThread(function()
            -- Base wheel
            RequestModel(baseWheelModel)
            while not HasModelLoaded(baseWheelModel) do
                Citizen.Wait(0)
            end
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            SetEntityHeading(bundle, 50)
            SetEntityHeading(_wheel, 0)
			SetEntityHeading(_base, 0)
			SetEntityHeading(_base1, 0)
            SetModelAsNoLongerNeeded(model)
			SetModelAsNoLongerNeeded(baseWheelModel)
			SetModelAsNoLongerNeeded(baseWheelModel1)]]

        -- Car
        RequestModel(carmodel)
        while not HasModelLoaded(carmodel) do
            Citizen.Wait(0)
        end
    end)
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

-- Citizen.CreateThread(function()
    -- while true do
        -- if _lambo ~= nil then
            -- local _heading = GetEntityHeading(_lambo)
            -- local _z = _heading - 0.3
            -- SetEntityHeading(_lambo, _z)
        -- end
        -- Citizen.Wait(5)
    -- end
-- end)

RegisterNetEvent("casino:doRoll")
AddEventHandler("casino:doRoll", function(_priceIndex)   
    SetEntityHeading(_wheel, 0)
    -- notifi
    _isRolling = true
    local headdd = GetEntityHeading(_wheel)
    SetEntityRotation(_wheel, 0.0, 0.0,0.0, 1, true)
    Citizen.CreateThread(function()
        local speedIntCnt = 15
        local rollspeed = 1.96
        local _winAngle = (_priceIndex) * 42
        local _rollAngle = _winAngle + (360 * 3)
        local _midLength = (_rollAngle / 4)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(_wheel, 1)
            if _rollAngle > _midLength then
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
            SetEntityHeading(_wheel, 0)
            SetEntityRotation(_wheel, 0.0, _y, _wheel, 2, true)
            Citizen.Wait(5)
        end

        if _priceIndex == 32 or _priceIndex == 9 or _priceIndex == 20 or _priceIndex == 43 then --2500
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 2.500$!",5000)
        elseif _priceIndex == 34 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 5.000$!",5000)
        elseif _priceIndex == 48 or _priceIndex == 25 or _priceIndex == 2 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 7.500$!",5000)
        elseif _priceIndex == 27 or _priceIndex == 10 or _priceIndex == 33 or _priceIndex == 50 or _priceIndex == 4 or _priceIndex == 44 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 10.000$!",5000)
        elseif _priceIndex == 35 or _priceIndex == 1 or _priceIndex == 18 or _priceIndex == 15 or _priceIndex == 41 or _priceIndex == 16 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 15.000$!",5000)
        elseif _priceIndex == 21 or _priceIndex == 37 or _priceIndex == 14 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 20.000$!",5000)
        elseif _priceIndex == 17 or _priceIndex == 40 or _priceIndex == 28 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 25.000$!",5000)
        elseif _priceIndex == 23 or _priceIndex == 46 or _priceIndex == 12 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 30.000$!",5000)
        elseif _priceIndex == 5 or _priceIndex == 39 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 40.000$!",5000)
        elseif _priceIndex == 42 or _priceIndex == 19 then
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 50.000$!",5000)
        elseif _priceIndex == 29 or _priceIndex == 47 or _priceIndex == 6 or _priceIndex == 13 or _priceIndex == 31 or _priceIndex == 38 or _priceIndex == 8 or _priceIndex == 24 or _priceIndex == 36 then
            -- água
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 1 Água!",5000)
        elseif _priceIndex == 45 or _priceIndex == 22 or _priceIndex == 11 then
            -- xtudo
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 1 xburguer",5000)
        elseif _priceIndex == 49 or _priceIndex == 3 or _priceIndex == 26 then
            -- prisão / mistério
            TriggerEvent("Notify","sucesso","<b></b>: Mistério!",5000)
        --elseif _priceIndex == 30 or _priceIndex == 7 then
            -- vehicle
            TriggerEvent("Notify","sucesso","<b></b>: Você ganhou 1 de alguma coisa!",5000)
        end
    end)
end)

RegisterNetEvent("casino:rollFinished")
AddEventHandler("casino:rollFinished", function()
    _isRolling = false
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function doRoll()
    if not _isRolling then
        if vSERVER.payment() then
            _isRolling = true
            local playerPed = PlayerPedId()
            loadAnimDict("anim_casino_a@amb@casino@games@lucky7wheel@male")
            local _movePos = vector3(1109.98,229.24,-49.63)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  -1,  0.84,  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(PlayerPedId())
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_to_armraisedidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TriggerServerEvent("casino:getLucky")
            TaskPlayAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        end
    end
end

-- Menu Controls
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())

        if (GetDistanceBetweenCoords(coords, _wheelPos.x, _wheelPos.y, _wheelPos.z, true) < 1.2) and not _isRolling then
            drawTxt("PRESSIONE  ~r~E~w~  PARA RODAR A ~y~ROLETA",4,0.5,0.93,0.50,255,255,255,120)
            if IsControlJustReleased(0, Keys['E']) then
                TriggerEvent("invarte")
            end
        end
	end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

RegisterNetEvent("invarte")
AddEventHandler("invarte", function()
    doRoll()
end)

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end
