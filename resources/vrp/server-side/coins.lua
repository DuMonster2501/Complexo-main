-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getGmsId(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
			local infos = vRP.query("vRP/get_vrp_infos",{ steam = identity.steam })																		if infos[1] then
			return infos[1].gems
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remGmsId(user_id,amount)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		local infos = vRP.query("vRP/get_vrp_infos",{ steam = identity.steam })						
        if infos[1].gems >= amount then
			vRP.execute("vRP/rem_vRP_gems",{ steam = identity.steam, gems = parseInt(amount) })
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addGmsId(user_id,amount)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vRP.execute("vRP/set_vRP_gems",{ steam = identity.steam, gems = parseInt(amount) })
		return true
	end
end