-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
vPRISON = Tunnel.getInterface("prison")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local prisonlog = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_prison","SELECT * FROM vrp_prison WHERE user_id = @user_id ")
vRP.prepare("vRP/tablet_prison","INSERT INTO vrp_prison(user_id,prison,multa,text,date,nuser_id) VALUES(@user_id,@prison,@multa,@text,@date,@nuser_id)")
vRP.prepare("vRP/update_port","UPDATE vrp_users SET porte = @porte WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(multas,passaporte,texto)
  local source = source
  local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent("Notify",source,"amarelo","Você multou o RG <b>" ..passaporte.. "</b> por <b>R$" ..multas.. "</b>.",3000)
        TriggerClientEvent("police:Update",source,"reloadFine")
        vRP.setFines(passaporte,multas,user_id,texto)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(passaporte,services,multas,texto)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then

			local nplayer = vRP.getUserSource(parseInt(passaporte))
			if nplayer then
				vPRISON.startPrison(nplayer,1)
				vRPclient.teleport(nplayer,1677.72,2509.68,45.57)
			end

			vRP.execute("vRP/set_prison",{ user_id = parseInt(passaporte), prison = parseInt(services), locate = 1 })
      vRP.execute("vRP/tablet_prison",{ user_id = passaporte, prison = parseInt(services), multa = parseInt(multas), text = texto, date = os.date("%d.%m.%Y").." ás "..os.date("%H:%M"), nuser_id = user_id })

      if parseInt(multas) <= 0 then
        vRP.setFines(passaporte,multas,user_id,texto)
      end

			local identity = vRP.getUserIdentity(parseInt(passaporte))
			local identity2 = vRP.getUserIdentity(parseInt(user_id))
			if identity then
				creativeLogs(records,"```PASSPORT: "..parseInt(nuser_id).."\nNAME: "..identity.name.." "..identity.name2.."\nSERVICES: "..parseInt(services).."\nCRIMES: "..texto.."\nBY: "..identity2.name.." "..identity2.name2.."```")
        TriggerClientEvent("police:Update",source,"reloadPrison")
				TriggerClientEvent("Notify",source,"verde","<b>"..identity.name.." "..identity.name2.."</b> enviado para a prisão <b>"..parseInt(services).." serviços</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(passaporte)
  local user_id = vRP.getUserId(source)
  local identity = vRP.getUserIdentity(parseInt(passaporte))
  local identity2 = vRP.getUserIdentity(parseInt(user_id))
  local rows = vRP.query("vRP/get_prison", { user_id = passaporte })
  local result = {}
  if identity then
    local fines = vRP.getFines(passaporte)
    local name = identity2.name.." "..identity2.name2
    local name2 = identity.name.." "..identity.name2
    local result2 = 0
      for k,v in pairs(fines) do
        result2 = result2 + v.price
    end
      result[1] = true
      result[2] = name
      result[3] = identity.phone
      result[4] = result2
      local porte = false
      if identity.porte == "sim" then
        porte = true
      end
      result[6] = porte
      result[5] = {}
      if rows then
        for k,v in pairs(rows) do
          local namepolice = vRP.getUserIdentity(v.nuser_id).name.." "..vRP.getUserIdentity(v.nuser_id).name2
          table.insert(result[5],{ police = namepolice, services = v.prison, fines = v.multa, date = v.date, text = v.text })
      end
    end
      if vRP.wantedReturn(passaporte) then
        result[7] = true
      else
        result[7] = false
      end
  else
    result[1] = false
  end
  return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(passaporte)
  local source = source
  local user_id = vRP.getUserId(source)
  if user_id then
    local identity = vRP.getUserIdentity(passaporte)
    if identity.porte == "não" then
      vRP.execute("vRP/update_port",{ user_id = passaporte, porte = "sim" })
    else
      vRP.execute("vRP/update_port",{ user_id = passaporte, porte = "não" })
    end
    TriggerClientEvent("police:Update",source,"reloadSearch",passaporte)
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATIVELOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function creativeLogs(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({ content = message }),{ ['Content-Type'] = "application/json" })
	end
end