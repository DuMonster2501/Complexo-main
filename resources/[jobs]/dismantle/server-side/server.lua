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
Tunnel.bindInterface("dismantle",cRP)
vCLIENT = Tunnel.getInterface("dismantle")
vRPRAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeList = 0
local maxVehlist = 10
local vehListActived = {}
local userList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {
	[1] = "guardian",
	[2] = "stinger",
	[3] = "bullet",
	[4] = "mesa",
	[5] = "banshee2",
	[6] = "surfer",
	[7] = "regina",
	[8] = "bjxl",
	[9] = "sandking2",
	[10] = "picador",
	[11] = "radi",
	[12] = "hotknife",
	[13] = "hermes",
	[14] = "bobcatxl",
	[15] = "mixer",
	[16] = "mixer2",
	[17] = "t20",
	[18] = "zentorno",
	[19] = "ellie",
	[20] = "boxville",
	[21] = "sentinel3",
	[22] = "dominator",
	[23] = "adder",
	[24] = "cheetah",
	[25] = "pounder",
	[26] = "windsor",
	[27] = "windsor2",
	[28] = "osiris",
	[29] = "rapidgt3",
	[30] = "verlierer2",
	[31] = "baller2",
	[32] = "dominator2",
	[33] = "ztype",
	[34] = "btype",
	[35] = "raptor",
	[36] = "monroe",
	[37] = "dubsta",
	[38] = "serrano",
	[39] = "rebel2",
	[40] = "jester",
	[41] = "tornado",
	[42] = "tornado2",
	[43] = "tornado3",
	[44] = "sadler",
	[45] = "granger",
	[46] = "surfer2",
	[47] = "warrener",
	[48] = "sultanrs",
	[49] = "carbonizzare",
	[50] = "gauntlet2",
	[51] = "exemplar",
	[52] = "stockade",
	[53] = "italigtb",
	[54] = "gauntlet",
	[55] = "utillitruck",
	[56] = "bifta",
	[57] = "yosemite",
	[58] = "tropos",
	[59] = "kuruma",
	[60] = "dukes",
	[61] = "chino",
	[62] = "chino2",
	[63] = "voltic",
	[64] = "neon",
	[65] = "raiden",
	[66] = "scrap",
	[67] = "toros",
	[68] = "rhapsody",
	[69] = "zion",
	[70] = "zion2",
	[71] = "blade",
	[72] = "rebel",
	[73] = "sentinel",
	[74] = "deviant",
	[75] = "jackal",
	[76] = "romero",
	[77] = "clique",
	[78] = "flatbed",
	[79] = "faction",
	[80] = "faction2",
	[81] = "faction3",
	[82] = "contender",
	[83] = "nero",
	[84] = "primo2",
	[85] = "casco",
	[86] = "surano",
	[87] = "patriot",
	[88] = "ztype",
	[89] = "savestra",
	[90] = "infernus2",
	[91] = "comet3",
	[92] = "pfister811",
	[93] = "turismo2",
	[94] = "buffalo",
	[95] = "cavalcade",
	[96] = "asterope",
	[97] = "tampa2",
	[98] = "nightshade",
	[99] = "buccaneer",
	[100] = "buccaneer2",
	[101] = "schlagen",
	[102] = "prototipo",
	[103] = "cogcabrio",
	[104] = "swinger",
	[105] = "manana",
	[106] = "nero2",
	[107] = "torero",
	[108] = "seminole",
	[109] = "specter",
	[110] = "coquette2",
	[111] = "coquette3",
	[112] = "gburrito",
	[113] = "gburrito2",
	[114] = "felon",
	[115] = "felon2",
	[116] = "mamba",
	[117] = "tampa2",
	[118] = "patriot2",
	[119] = "emperor",
	[120] = "rancherxl",
	[121] = "taxi",
	[122] = "benson",
	[123] = "tiptruck2",
	[124] = "panto",
	[125] = "cog55",
	[126] = "peyote",
	[127] = "slamvan3",
	[128] = "cheetah2",
	[129] = "kalahari",
	[130] = "seven70",
	[131] = "autarch",
	[132] = "stanier",
	[133] = "tornado5"
}

local itensList = {
	[1] = "plastic",
	[2] = "glass",
	[3] = "copper",
	[4] = "rubber",
	[5] = "aluminum"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEVEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.generateVehlist()
	vehListActived = {}
	local amountVehs = 0
	local vehSelected = 0
	repeat
		Citizen.Wait(1)
		vehSelected = math.random(#vehList)
		if vehListActived[vehList[parseInt(vehSelected)]] == nil then
			amountVehs = amountVehs + 1
			vehListActived[vehList[parseInt(vehSelected)]] = true
		end
	until parseInt(amountVehs) == parseInt(maxVehlist)
	timeList = 60
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHGENERATE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	cRP.generateVehlist()

	while true do
		if timeList > 0 then
			timeList = timeList - 1
			if timeList <= 0 then
				cRP.generateVehlist()
			end
		end
		Citizen.Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkVehlist()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 then
			local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,11)
			if vehicle then
				local plateId = vRP.getVehiclePlate(vehPlate)
				if not plateId then
					if vehListActived[vehName] then
						vehListActived[vehName] = nil
						return true,vehicle
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Este veículo é protegido pela seguradora.",5000)
				end
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,25)
		local value = math.random(12000,24000)

		vRPRAGE.deleteVehicle(source,vehicle)
		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		vRP.giveInventoryItem(user_id,itensList[math.random(#itensList)],math.random(6,16),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.acessList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if userList[user_id] == nil then
			userList[user_id] = true
			TriggerClientEvent("Notify",source,"amarelo","Você pegou uma lista de veículos.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE:INVOKEDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dismantle:invokeDismantle")
AddEventHandler("dismantle:invokeDismantle",function(invokeDismantle)
	local user_id = vRP.getUserId(source)
	if user_id then
		if timeList > 0 and userList[user_id] then
			local vehListNames = ""
			for k,v in pairs(vehListActived) do
				vehListNames = vehListNames.."<b>"..vRP.vehicleName(k).."</b>, "
			end

			if vehListNames ~= "" then
				TriggerClientEvent("Notify",source,"azul",vehListNames.." a lista é atualizada em <b>"..parseInt(timeList).." minutos</b>, cada veículo entregue o mesmo é removido da lista atual.",15000)
			else
				TriggerClientEvent("Notify",source,"azul","Nenhum veículo encontrado na lista, aguarde <b>"..parseInt(timeList).." minutos</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if userList[user_id] then
		userList[user_id] = nil
	end
end)