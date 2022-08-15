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
Tunnel.bindInterface("chat",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local isRDR = not TerraingridActivate and true or false
local chatInputActive = false
local chatInputActivating = false
local chatLoaded = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERNALEVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:addMode')
RegisterNetEvent('chat:removeMode')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')
-----------------------------------------------------------------------------------------------------------------------------------------
-- chatMessage
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chatMessage",function(author,color,text)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		local args = { text }
		if author ~= "" then
			table.insert(args,1,author)
		end

		SendNUIMessage({ type = "ON_MESSAGE", message = { color = color, multiline = true, args = args } })
		SendNUIMessage({ type = "ON_SCREEN_STATE_CHANGE", shouldHide = false })
	end
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	SendNUIMessage({type = 'ON_MESSAGE',message = {templateId = 'print', multiline = true, args = { msg } }})
end)

-- addMessage
local addMessage = function(message)
  if type(message) == 'string' then
    message = {args = { message }}
  end

  SendNUIMessage({ type = "ON_MESSAGE", message = message })
end

exports('addMessage', addMessage)
AddEventHandler('chat:addMessage', addMessage)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local addSuggestion = function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports('addSuggestion', addSuggestion)
AddEventHandler('chat:addSuggestion', addSuggestion)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMODE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('chat:addMode', function(mode)
  SendNUIMessage({
    type = 'ON_MODE_ADD',
    mode = mode
  })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('chat:removeMode', function(name)
  SendNUIMessage({
    type = 'ON_MODE_REMOVE',
    name = name
  })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTEMPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('chat:clear', function(name)
  SendNUIMessage({ type = "ON_CLEAR" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message, data.mode)
    end
  end

  cb('ok')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REFRESHCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) and command.name ~= 'toggleChat' then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REFRESHTHEMES
-----------------------------------------------------------------------------------------------------------------------------------------
local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(resName)
	if (GetCurrentResourceName() ~= resName) then
		return
	end

	local mHash = GetHashKey("mp_m_freemode_01")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		SetPlayerModel(PlayerId(),mHash)
		SetModelAsNoLongerNeeded(mHash)
		FreezeEntityPosition(PlayerPedId(),false)
	end
	
	refreshCommands()
	refreshThemes()

	TriggerEvent("spawn:generateJoin")
	TriggerServerEvent("Queue:playerConnect")

	ShutdownLoadingScreen()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStop", function(resName)
  Citizen.Wait(1)

  refreshCommands()
  refreshThemes()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init')

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
local CHAT_HIDE_STATES = {
  SHOW_WHEN_ACTIVE = 0,
  ALWAYS_SHOW = 1,
  ALWAYS_HIDE = 2
}
-----------------------------------------------------------------------------------------------------------------------------------------
local kvpEntry = GetResourceKvpString('hideState')
local chatHideState = kvpEntry ~= nil and tonumber(kvpEntry) or CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
local isFirstHide = true
-----------------------------------------------------------------------------------------------------------------------------------------
if not isRDR then
   RegisterCommand('chat', function()
    if chatHideState == CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE then
      chatHideState = CHAT_HIDE_STATES.ALWAYS_SHOW
    elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_SHOW then
      chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
    elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_HIDE then
      chatHideState = CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
    end

    isFirstHide = false

    SetResourceKvp('hideState', tostring(chatHideState))
  end, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)
  local lastChatHideState = -1
  local origChatHideState = -1

  while true do
    local splyphe = 500

    if not chatInputActive then
      splyphe = 0
      if IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      splyphe = 0
      if not IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      splyphe = 0
      local forceHide = false --IsScreenFadedOut() or IsPauseMenuActive()

      if forceHide then
        origChatHideState = chatHideState
        chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
      elseif origChatHideState ~= -1 then
        chatHideState = origChatHideState
        origChatHideState = -1
      end

      if chatHideState ~= lastChatHideState then
        lastChatHideState = chatHideState

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          hideState = chatHideState,
          fromUserInteraction = not forceHide and not isFirstHide
        })

        isFirstHide = false
      end
    end
    Wait(splyphe)
  end
end)