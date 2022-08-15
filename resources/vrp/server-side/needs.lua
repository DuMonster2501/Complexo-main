-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updateHealth(health)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.health = health
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updateArmour(armour)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.armour = armour
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD THIRST/
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(80000)
		for k,v in pairs(vRP.users) do
			vRP.downgradeThirst(v,2)
			vRP.downgradeHunger(v,1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDAGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeThirst(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.thirst == nil then
			data.thirst = 100
		else
			data.thirst = data.thirst + amount
			if data.thirst >= 100 then
				data.thirst = 100
			end
		end

		TriggerClientEvent("statusThirst",source,data.thirst)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeHunger(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.hunger == nil then
			data.hunger = 100
		else
			data.hunger = data.hunger + amount
			if data.hunger >= 100 then
				data.hunger = 100
			end
		end

		TriggerClientEvent("statusHunger",source,data.hunger)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeThirst(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.thirst == nil then
			data.thirst = 100
		else
			data.thirst = data.thirst - amount
			if data.thirst <= 0 then
				data.thirst = 0
			end
		end

		TriggerClientEvent("statusThirst",source,data.thirst)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeHunger(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.hunger == nil then
			data.hunger = 100
		else
			data.hunger = data.hunger - amount
			if data.hunger <= 0 then
				data.hunger = 0
			end
		end

		TriggerClientEvent("statusHunger",source,data.hunger)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeStress(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.stress == nil then
			data.stress = amount
		else
			data.stress = data.stress + amount
			if data.stress >= 100 then
				data.stress = 100
			end
		end

		TriggerClientEvent("statusStress",source,data.stress)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeStress(user_id,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.stress == nil then
			data.stress = amount
		else
			data.stress = data.stress - amount
			if data.stress <= 0 then
				data.stress = 0
			end
		end

		TriggerClientEvent("statusStress",source,data.stress)
	end
end