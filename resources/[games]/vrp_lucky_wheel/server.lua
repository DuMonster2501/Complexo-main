-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXAO
-----------------------------------------------------------------------------------------------------------------------------------------
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("vrp_lucky_wheel")
vPRISON = Tunnel.getInterface("vrp_prison")
vPLAYER = Tunnel.getInterface("vrp_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXAO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_lucky_wheel",cRP)

isRoll = false
amount = 1

function cRP.payment()
	local source = source
  local user_id = vRP.getUserId(source)
    if user_id then
      if vRP.tryGetInventoryItem(user_id,"dollars",1000,true) then
        return true
      else
        TriggerClientEvent("Notify",source,"negado","Você não tem um dinheiro para iniciara Roleta da Sorte.",5000)
        return false
      end
	end
end

RegisterServerEvent('casino:getLucky')
AddEventHandler('casino:getLucky', function()
  local source = source
  local user_id = vRP.getUserId(source)
  local player = vRP.getUserSource(user_id)
  local identity = vRP.getUserIdentity(user_id)
  TriggerClientEvent("invarte", player)
  if not isRoll then
    if user_id ~= nil then
      isRoll = true
      local _priceIndex = math.random(1,50)
      SetTimeout(12000, function()
        isRoll = false
        -- Give Price
        if _priceIndex == 32 or _priceIndex == 9 or _priceIndex == 20 or _priceIndex == 43 then
          vRP.giveInventoryItem(user_id, "dinheiro", 2500,true)
        elseif _priceIndex == 34 then
          vRP.giveInventoryItem(user_id, "dinheiro", 5000,true)
        elseif _priceIndex == 48 or _priceIndex == 25 or _priceIndex == 2 then
          vRP.giveInventoryItem(user_id, "dinheiro", 7500,true)
        elseif _priceIndex == 27 or _priceIndex == 10 or _priceIndex == 33 or _priceIndex == 50 or _priceIndex == 4 or _priceIndex == 44 then
          vRP.giveInventoryItem(user_id, "dinheiro", 10000,true)
        elseif _priceIndex == 35 or _priceIndex == 1 or _priceIndex == 18 or _priceIndex == 15 or _priceIndex == 41 or _priceIndex == 16 then
          vRP.giveInventoryItem(user_id, "dinheiro", 15000,true)
        elseif _priceIndex == 21 or _priceIndex == 37 or _priceIndex == 14 then
          vRP.giveInventoryItem(user_id, "dinheiro", 20000,true)
        elseif _priceIndex == 17 or _priceIndex == 40 or _priceIndex == 28 then
          vRP.giveInventoryItem(user_id, "dinheiro", 25000,true)
        elseif _priceIndex == 23 or _priceIndex == 46 or _priceIndex == 12 then
          vRP.giveInventoryItem(user_id, "dinheiro", 30000,true)
          TriggerClientEvent("chatMessage",-1,"",{102,178,255},identity.name.." "..identity.name2.." ganhou 30.000$!")
        elseif _priceIndex == 5 or _priceIndex == 39 then
          vRP.giveInventoryItem(user_id, "dinheiro", 40000,true)
          TriggerClientEvent("chatMessage",-1,"",{102,178,255},identity.name.." "..identity.name2.." ganhou 40.000$!")
        elseif _priceIndex == 42 or _priceIndex == 19 then
          vRP.giveInventoryItem(user_id, "dinheiro", 50000,true)
          TriggerClientEvent("chatMessage",-1,"",{102,178,255},identity.name.." "..identity.name2.." ganhou 50.000$!")
        elseif _priceIndex == 29 or _priceIndex == 47 or _priceIndex == 6 or _priceIndex == 13 or _priceIndex == 31 or _priceIndex == 38 or _priceIndex == 8 or _priceIndex == 24 or _priceIndex == 36 then
          -- água 
          vRP.giveInventoryItem(user_id, "agua", 1,true)
        elseif _priceIndex == 45 or _priceIndex == 22 or _priceIndex == 11 then
          -- xtudo
          vRP.giveInventoryItem(user_id, "xburguer", math.random(1,5),true)
        
        elseif _priceIndex == 49 or _priceIndex == 3 or _priceIndex == 26 then
        local player = vRP.getUserSource(parseInt(args[1]))
        if player then
          vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
          vRPclient.setHandcuffed(player,false)
          TriggerClientEvent('prisioneiro',player,true)
          vRPclient.teleport(player,1680.1,2513.0,45.5)
          prison_lock(parseInt(args[1]))
          TriggerClientEvent('removealgemas',player)
          TriggerClientEvent("vrp_sound:source",player,'jaildoor',0.7)
          TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)
          local identity = vRP.getUserIdentity(parseInt(args[1]))
          local nplayer = vRP.getUserSource(parseInt(args[1]))
          vPRISON.startPrison(nplayer)
          TriggerClientEvent("chatMessage",-1,"",{102,178,255},identity.name.." "..identity.name2.." ganhou 100 serviços na prisão!")
        end  
          -- prisão / mistério
           --[[if  _priceIndex == 26 then
            vRP.giveInventoryItem(user_id, "backpackg", 1,true)
         else
            local nplayer = vRP.getUserSource(parseInt(user_id))
            vRP.execute("vRP/set_prison",{ user_id = parseInt(user_id), prison = 100, locate = parseInt(2), desc = "Ganhou 100 serviços no Casino" })
            vPRISON.startPrison(nplayer)
            TriggerClientEvent("chatMessage",-1,"[NameCity]",{102,178,255},identity.name.." "..identity.name2.." ganhou 100 serviços na prisão!")
          end
        elseif _priceIndex == 30 or _priceIndex == 7 then]]
          -- vehicle
          if _priceIndex == 30 then
            local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = "akuma" })
            if vehicle[1] then
              TriggerClientEvent("Notify",source,"aviso","Você já possui um <b>"..vRP.vehicleName("akuma").."</b>.",3000)
            else
              vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = "akuma", plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(false) })
              TriggerClientEvent("chatMessage",-1,"",{102,178,255},identity.name.." "..identity.name2.." ganhou 1 Akuma!")
            end
          else
            vRP.giveInventoryItem(user_id, "pibwassen", math.random(1,5),true)
          end                    
        end
        TriggerClientEvent("casino:rollFinished", player)
      end)
      TriggerClientEvent("casino:doRoll", player, _priceIndex)
      TriggerClientEvent("Notify",source,"Sucesso","Você girou a roleta boa Sorte!!")
    end
  end
end)
