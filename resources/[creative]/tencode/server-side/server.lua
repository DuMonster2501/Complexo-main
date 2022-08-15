-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("tencode",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	[10] = "Confronto em andamento",
	[13] = "Oficial ferido",
	[20] = "Localização",
	[32] = "Homem armado",
	[38] = "Parando veículo suspeito",
	[50] = "Acidente de trânsito",
	[78] = "Reforço solicitado"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sendCode(code)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)
		local copAmount = vRP.numPermission("Police")
		for k,v in pairs(copAmount) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = code, title = codes[parseInt(code)], x = x, y = y, z = z, name = identity.name.." "..identity.name2, rgba = {140,35,35} })
			end)
		end
	end
end