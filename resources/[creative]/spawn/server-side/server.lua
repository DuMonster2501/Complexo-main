-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("spawn",cRP)
vCLIENT = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userlogin = {}
local spawnLogin = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initSystem()
	local source = source
	local steam = vRP.getSteam(source)

	Citizen.Wait(1000)

	return cRP.getPlayerCharacters(steam)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.characterChosen(id)
	local source = source
	vCLIENT.closeNew(source)
	TriggerClientEvent("hudActived",source,true)
	TriggerEvent("baseModule:idLoaded",source,id,nil)
	TriggerEvent("CharacterSpawn",source,id)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.newCharacter(name,name2,nationality,sex)
	local source = source
	local steam = vRP.getSteam(source)
	local persons = cRP.getPlayerCharacters(steam)
	local infos = vRP.query("vRP/get_vrp_infos",{ steam = steam })

	

	if infos[1].chars == 1 then
		if parseInt(#persons) >= 1 then
			TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
			TriggerClientEvent("spawn:maxChars",source)
			return
		end
	end

	if infos[1].chars == 2 then
		if parseInt(#persons) >= 2 then
			TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
			TriggerClientEvent("spawn:maxChars",source)
			return
		end
	end

	if infos[1].chars == 3 then
		if parseInt(#persons) >= 3 then
			TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
			TriggerClientEvent("spawn:maxChars",source)
			return
		end
	end

	if infos[1].chars == 4 then
		if parseInt(#persons) >= 4 then
			TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de personagens.",5000)
			TriggerClientEvent("spawn:maxChars",source)
			return
		end
	end

	vCLIENT.closeNew(source)

	vRP.execute("vRP/create_characters",{ steam = steam, name = name, name2 = name2, nationality = nationality, sex = sex })

	local newId = 0
	local chars = cRP.getPlayerCharacters(steam)
	for k,v in pairs(chars) do
		if v.id > newId then
			newId = tonumber(v.id)
		end
	end

	Citizen.Wait(1000)

	spawnLogin[parseInt(newId)] = true

	if sex == "Masculino" then
		sex = "mp_m_freemode_01"
	else
		sex = "mp_f_freemode_01"
	end

	TriggerClientEvent("hudActived",source,true)
	TriggerEvent("baseModule:idLoaded",source,newId,sex)
	Citizen.Wait(1000)
	TriggerClientEvent("spawn:justSpawn",source,true)
	TriggerClientEvent("ENTROU",source,true)
	cRP.deCode(newId,sex)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECODER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deCode(user_id,sex)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(sex))
		vRP.setUData(user_id,"spawnController",json.encode(2))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("CharacterSpawn")
AddEventHandler("CharacterSpawn", function(source,user_id)
	if user_id then
		local data = vRP.getUData(user_id,"spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			Citizen.Wait(1000)
			cRP.processSpawnController(source,sdata,user_id)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESS SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			cRP.doSpawnPlayer(source,user_id,true)
		else
			cRP.doSpawnPlayer(source,user_id,false)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doSpawnPlayer(source,user_id,spawnType)
	local identity = vRP.getUserIdentity(user_id)
    local player = vRP.getUserSource(user_id)

	TriggerClientEvent("spawn:justSpawn",source,spawnType)
	TriggerClientEvent("vrp:playerActive",source,user_id,identity)
	TriggerEvent("barbershop:init",user_id)

    if player then
        local value = vRP.getUData(user_id, "currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            TriggerClientEvent("barbershop:apply",player,custom)
        end
    end
end
