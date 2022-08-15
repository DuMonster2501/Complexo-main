-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.addBlips(x,y,z,sprite,color,text,scale,route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,sprite)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,color)
	SetBlipScale(blip,scale)

	if route then
		SetBlipRoute(blip,true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end

	return blip
end
function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBLIPSALPHA
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.addBlipsAlpha(x,y,z,color)
	local blip = AddBlipForRadius(x,y,z,100.0)
	SetBlipHighDetail(blip,true)
	SetBlipColour(blip,color)
	SetBlipAlpha(blip,150)
	SetBlipAsShortRange(blip,true)

	return blip
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.removeBlips(id)
	if DoesBlipExist(id) then
		RemoveBlip(id)
	end
end