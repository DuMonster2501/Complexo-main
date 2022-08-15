-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPremium(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		local consult = vRP.getInfos(identity.steam)
		if consult[1] and os.time() >= (consult[1].premium+24*consult[1].predays*60*60) then
			return false
		else
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPREMIUM2
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPremium2(steam)
	local consult = vRP.getInfos(steam)
	if consult[1] and os.time() >= (consult[1].premium+24*consult[1].predays*60*60) then
		return false
	else
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCARPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getCarPremium(car,user_id)
	local rows2 = vRP.query("vRP/get_vehicle",{ user_id = user_id })
    if #rows2 then 
		for k,v in pairs(rows2) do
			if v.vehicle == car then
            	if os.time() >= (v.premiumtime+24*30*60*60) then
					return true
				else
					return false
				end
			end
        end
    end
end