-- Author: Xinerki (https://forum.fivem.net/t/release-cellphone-camera/43599)

phone = false
phoneId = 0

RegisterNetEvent('camera:open')
AddEventHandler('camera:open', function()
    CreateMobilePhone(1)
	CellCamActivate(true, true)
	phone = true
    PhonePlayOut()
end)

frontCam = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end
