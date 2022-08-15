-----------------------------------------------------------------------------------------------------------------------------------------
-- GET WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getWeaponsId(user_id)
    local infos = vRP.query("vRP/get_weapon",{ user_id = user_id })
	return infos
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    local n = false
    if #data > 0 then        
	    for k, v in pairs(data) do            
	    	if v.weapon == weapon then
                local newammo = v.ammo + ammo                
                vRP.execute("vRP/update_weapon",{ user_id = user_id, weapon = weapon, ammo = newammo })                    
                n = true
                break
            end
        end
    end

    if not n then
        vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
    end

    -- if data and data[weapon] then
    --     local newammo = data[weapon].ammo + ammo                
    --     vRP.execute("vRP/update_weapon",{ user_id = user_id, weapon = weapon, ammo = newammo })
    -- else
    --     vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })        
    -- end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM AMMO ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remAmmoWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    if #data> 0 then
        local n = false
        for k, v in pairs(data) do
            if v.weapon == weapon then
                vRP.execute("vRP/update_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
                n = true
                break                
            end
        end

        if not n then
            vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
        end
    end
	return true
end

function tvRP.updateWeapons(weapons)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

        local sdata = vRP.getUserDataTable(user_id)
        if sdata then
            sdata.weaps = weapons
        end

	end
end