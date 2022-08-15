-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_types = {
	"WEAPON_KNIFE",
	"WEAPON_HATCHET",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_RPG",
	"WEAPON_MUSKET",
	"WEAPON_RAYPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_COMBATPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_SMG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG",
	"WEAPON_PETROLCAN",
	"GADGET_PARACHUTE",
	"WEAPON_STUNGUN",
	"WEAPON_FIREEXTINGUISHER"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getWeapons()
	local ped = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = GetPedAmmoTypeFromWeapon(ped,hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(ped,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	return weapons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPLACEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.replaceWeapons()
	local old_weapons = tvRP.getWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
	return old_weapons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clearWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.giveWeapons(weapons,clear_before)
	local ped = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(ped,true)
	end

	for k,v in pairs(weapons) do
		GiveWeaponToPed(ped,GetHashKey(k),v.ammo or 0,false)
	end
end