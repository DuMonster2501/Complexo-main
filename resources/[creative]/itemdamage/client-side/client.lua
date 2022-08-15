local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
damage = Tunnel.getInterface("itemdamage")

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		
		if IsEntityInWater(ped) then
			idle = 100
			if IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
				damage.damageItem()
			end
			if IsPedSwimming(ped) and IsPedSwimmingUnderWater(ped) then
				damage.damageItem()
			end
		end
		Citizen.Wait(idle)
	end
end)