-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserIdentity(user_id)
	local rows = vRP.getInformation(user_id)
	return rows[1]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERREGISTRATION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserRegistration(user_id)
	local rows = vRP.getInformation(user_id)
	return rows[1].registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERIDREGISTRATION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserIdRegistration(registration)
	local rows = vRP.query("vRP/get_vrp_registration",{ registration = registration })
	if rows[1] then
		return rows[1].id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEHICLEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getVehiclePlate(plate)
	local rows = vRP.query("vRP/get_vehicle_plate",{ plate = plate })
	if rows[1] then
		return rows[1].user_id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERBYPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserByPhone(phone)
	local rows = vRP.query("vRP/get_vrp_phone",{ phone = phone })
	if rows[1] then
		return rows[1].id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPhone(id)
	local rows = vRP.query("vRP/get_vrp_users",{ id = id })
	if rows[1] then
		return rows[1].phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRINGNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then
			number = number..string.char(abyte+math.random(0,25))
		else
			number = number..char
		end
	end
	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEREGISTRATIONNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateRegistrationNumber()
	local user_id = nil
	local registration = ""
	repeat
		Citizen.Wait(0)
		registration = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.getUserIdRegistration(registration)
	until not user_id

	return registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePlateNumber()
	local user_id = nil
	local registration = ""
	repeat
		Citizen.Wait(0)
		registration = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.getVehiclePlate(registration)
	until not user_id

	return registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.genPlate()
	return vRP.generateStringNumber("LLDDDLLL")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePhoneNumber()
	local user_id = nil
	local phone = ""

	repeat
		Citizen.Wait(0)
		phone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.getUserByPhone(phone)
	until not user_id

	return phone
end