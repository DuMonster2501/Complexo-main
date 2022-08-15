local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')


AddEventHandler('_chat:messageEntered',function(author,color,message)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if not message or not author or not identity then
		return
	end

	if not WasEventCanceled() then
		TriggerClientEvent("chatMessage",source,identity.name.." "..identity.name2,{131,174,0},message)

		local players = vRPclient.nearestPlayers(source,10)
		for k,v in pairs(players) do
			TriggerClientEvent("chatMessage",k,identity.name.." "..identity.name2,{131,174,0},message)
		end
	end
end)

AddEventHandler('__cfx_internal:commandFallback',function(command)
	local name = GetPlayerName(source)
	if not command or not name then
		return
	end

	if not WasEventCanceled() then
		TriggerEvent("chatMessage",source,name,'/'..command)
	end
	CancelEvent()
end)

local commandos = {
	["e"] = { help = "teste" },
}

  -- SUGESTÃO DE COMANDOS
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = '' -- COLOCAR DESC DE COMANDOS
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Citizen.Wait(1)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)