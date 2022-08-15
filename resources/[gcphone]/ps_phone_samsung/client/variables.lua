-----------------------------------------------------------------------------------------------------------------------------------------
-- PostNewImage
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PostNewImage', function(data, cb)
    SetNuiFocus(false, false)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    Citizen.Wait(0)

	while takePhoto do
        Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
        elseif IsControlJustPressed(1, 177) then -- CANCEL
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(nil)
            takePhoto = false
            break
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(Config.Webhook, Config.Field, function(data)
                local resp = json.decode(data)
                cb(resp.attachments[1].proxy_url)
                DestroyMobilePhone()
                CellCamActivate(false, false)
            end)
            takePhoto = false
		end

		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
    end

    OpenPhone()
    Citizen.Wait(1000)
    PhonePlayAnim('text', false, true)
end)