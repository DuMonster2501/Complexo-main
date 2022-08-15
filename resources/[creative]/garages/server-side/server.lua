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
cnVRP = {}
Tunnel.bindInterface("garages",cnVRP)
vCLIENT = Tunnel.getInterface("garages")
vHUD = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehlist = {}
local trydoors = {}
local stealVehs = {}
local spanwedVehs = {}
local vehChest = {}
local deleteVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("setPlateEveryone")
AddEventHandler("setPlateEveryone",function(plate)
	trydoors[plate] = true
	TriggerClientEvent("garages:syncTrydoors",-1,trydoors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("setPlatePlayers")
AddEventHandler("setPlatePlayers",function(vehPlate,user_id)
	local plateId = vRP.getVehiclePlate(vehPlate)
	if not plateId then
		stealVehs[vehPlate] = parseInt(user_id)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("garages:syncTrydoors",source,trydoors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local garages = {
	[1] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[2] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[3] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[4] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[5] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[6] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[7] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[8] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[9] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[10] = { ["name"] = "Garage", ["payment"] = false, ["public"] = true },
	[11] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[12] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[13] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[14] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[15] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[16] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[17] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[18] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[19] = { ["name"] = "Paramedic", ["payment"] = true, ["perm"] = "Paramedic" },
	[20] = { ["name"] = "Heliparamedic", ["payment"] = true, ["perm"] = "Paramedic" },
	[21] = { ["name"] = "Police", ["payment"] = true, ["perm"] = "Police" },
	[22] = { ["name"] = "Police2", ["payment"] = true, ["perm"] = "Police" },
	[23] = { ["name"] = "Police2", ["payment"] = true, ["perm"] = "Police" },
	[24] = { ["name"] = "Helipolice", ["payment"] = true, ["perm"] = "Police" },
	[25] = { ["name"] = "Helipolice", ["payment"] = true, ["perm"] = "Police" },
	[26] = { ["name"] = "Helipolice", ["payment"] = true, ["perm"] = "Police" },
	[27] = { ["name"] = "Driver", ["payment"] = true, ["public"] = true },
	[28] = { ["name"] = "Boats", ["payment"] = true, ["public"] = true },
	[29] = { ["name"] = "Boats", ["payment"] = true, ["public"] = true },
	[30] = { ["name"] = "Boats", ["payment"] = true, ["public"] = true },
	[32] = { ["name"] = "Transporter", ["payment"] = true, ["public"] = true },
	[33] = { ["name"] = "Lumberman", ["payment"] = true, ["public"] = true },
	[34] = { ["name"] = "Fisherman", ["payment"] = true, ["public"] = true },
	[35] = { ["name"] = "Boats", ["payment"] = true, ["public"] = true },
	[36] = { ["name"] = "Garbageman", ["payment"] = true, ["public"] = true },
--	[37] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[38] = { ["name"] = "Prison", ["payment"] = true, ["perm"] = "Police" },
	[40] = { ["name"] = "Tow", ["payment"] = true, ["public"] = true },
	[41] = { ["name"] = "Tow", ["payment"] = true, ["public"] = true },
	[42] = { ["name"] = "Taxi", ["payment"] = true, ["public"] = true },
	[43] = { ["name"] = "TheLost", ["payment"] = true, ["perm"] = "TheLost" },
--	[44] = { ["name"] = "PostOp", ["payment"] = true, ["public"] = true },
--	[46] = { ["name"] = "Ilegal", ["payment"] = true, ["public"] = true },
	[501] = { ["name"] = "Middle001", ["payment"] = false, ["perm"] = false },
	[502] = { ["name"] = "Middle002", ["payment"] = false, ["perm"] = false },
	[503] = { ["name"] = "Middle003", ["payment"] = false, ["perm"] = false },
	[504] = { ["name"] = "Middle004", ["payment"] = false, ["perm"] = false },
	[505] = { ["name"] = "Middle005", ["payment"] = false, ["perm"] = false },
	[506] = { ["name"] = "Middle006", ["payment"] = false, ["perm"] = false },
	[507] = { ["name"] = "Middle007", ["payment"] = false, ["perm"] = false },
	[508] = { ["name"] = "Middle008", ["payment"] = false, ["perm"] = false },
	[509] = { ["name"] = "Middle009", ["payment"] = false, ["perm"] = false },
	[510] = { ["name"] = "Middle010", ["payment"] = false, ["perm"] = false },
	[511] = { ["name"] = "Middle011", ["payment"] = false, ["perm"] = false },
	[512] = { ["name"] = "Middle012", ["payment"] = false, ["perm"] = false },
	[513] = { ["name"] = "Middle013", ["payment"] = false, ["perm"] = false },
	[514] = { ["name"] = "Middle014", ["payment"] = false, ["perm"] = false },
	[515] = { ["name"] = "Middle015", ["payment"] = false, ["perm"] = false },
	[516] = { ["name"] = "Middle016", ["payment"] = false, ["perm"] = false },
	[517] = { ["name"] = "Middle017", ["payment"] = false, ["perm"] = false },
	[518] = { ["name"] = "Middle018", ["payment"] = false, ["perm"] = false },
	[519] = { ["name"] = "Middle019", ["payment"] = false, ["perm"] = false },
	[520] = { ["name"] = "Middle020", ["payment"] = false, ["perm"] = false },
	[521] = { ["name"] = "Middle021", ["payment"] = false, ["perm"] = false },
	[522] = { ["name"] = "Middle022", ["payment"] = false, ["perm"] = false },
	[523] = { ["name"] = "Middle023", ["payment"] = false, ["perm"] = false },
	[524] = { ["name"] = "Middle024", ["payment"] = false, ["perm"] = false },
	[525] = { ["name"] = "Middle025", ["payment"] = false, ["perm"] = false },
	[526] = { ["name"] = "Middle026", ["payment"] = false, ["perm"] = false },
	[527] = { ["name"] = "Middle027", ["payment"] = false, ["perm"] = false },
	[528] = { ["name"] = "Middle028", ["payment"] = false, ["perm"] = false },
	[529] = { ["name"] = "Middle029", ["payment"] = false, ["perm"] = false },
	[530] = { ["name"] = "Middle030", ["payment"] = false, ["perm"] = false },
	[531] = { ["name"] = "Middle031", ["payment"] = false, ["perm"] = false },
	[532] = { ["name"] = "Middle032", ["payment"] = false, ["perm"] = false },
	[533] = { ["name"] = "Middle033", ["payment"] = false, ["perm"] = false },
	[534] = { ["name"] = "Middle034", ["payment"] = false, ["perm"] = false },
	[535] = { ["name"] = "Middle035", ["payment"] = false, ["perm"] = false },
	[536] = { ["name"] = "Middle036", ["payment"] = false, ["perm"] = false },
	[537] = { ["name"] = "Middle037", ["payment"] = false, ["perm"] = false },
	[538] = { ["name"] = "Middle038", ["payment"] = false, ["perm"] = false },
	[539] = { ["name"] = "Middle039", ["payment"] = false, ["perm"] = false },
	[540] = { ["name"] = "Middle040", ["payment"] = false, ["perm"] = false },
	[541] = { ["name"] = "Middle041", ["payment"] = false, ["perm"] = false },
	[542] = { ["name"] = "Middle042", ["payment"] = false, ["perm"] = false },
	[543] = { ["name"] = "Middle043", ["payment"] = false, ["perm"] = false },
	[544] = { ["name"] = "Middle044", ["payment"] = false, ["perm"] = false },
	[545] = { ["name"] = "Middle045", ["payment"] = false, ["perm"] = false },
	[546] = { ["name"] = "Middle046", ["payment"] = false, ["perm"] = false },
	[547] = { ["name"] = "Middle047", ["payment"] = false, ["perm"] = false },
	[548] = { ["name"] = "Middle048", ["payment"] = false, ["perm"] = false },
	[549] = { ["name"] = "Middle049", ["payment"] = false, ["perm"] = false },
	[550] = { ["name"] = "Middle050", ["payment"] = false, ["perm"] = false },
	[551] = { ["name"] = "Middle051", ["payment"] = false, ["perm"] = false },
	[552] = { ["name"] = "Middle052", ["payment"] = false, ["perm"] = false },
	[553] = { ["name"] = "Middle053", ["payment"] = false, ["perm"] = false },
	[554] = { ["name"] = "Middle054", ["payment"] = false, ["perm"] = false },
	[555] = { ["name"] = "Middle055", ["payment"] = false, ["perm"] = false },
	[556] = { ["name"] = "Middle056", ["payment"] = false, ["perm"] = false },
	[557] = { ["name"] = "Middle057", ["payment"] = false, ["perm"] = false },
	[558] = { ["name"] = "Middle058", ["payment"] = false, ["perm"] = false },
	[559] = { ["name"] = "Middle059", ["payment"] = false, ["perm"] = false },
	[560] = { ["name"] = "Middle060", ["payment"] = false, ["perm"] = false },
	[561] = { ["name"] = "Middle061", ["payment"] = false, ["perm"] = false },
	[562] = { ["name"] = "Middle062", ["payment"] = false, ["perm"] = false },
	[563] = { ["name"] = "Middle063", ["payment"] = false, ["perm"] = false },
	[564] = { ["name"] = "Middle064", ["payment"] = false, ["perm"] = false },
	[565] = { ["name"] = "Middle065", ["payment"] = false, ["perm"] = false },
	[566] = { ["name"] = "Middle066", ["payment"] = false, ["perm"] = false },
	[567] = { ["name"] = "Middle067", ["payment"] = false, ["perm"] = false },
	[568] = { ["name"] = "Middle068", ["payment"] = false, ["perm"] = false },
	[569] = { ["name"] = "Middle069", ["payment"] = false, ["perm"] = false },
	[570] = { ["name"] = "Middle070", ["payment"] = false, ["perm"] = false },
	[571] = { ["name"] = "Middle071", ["payment"] = false, ["perm"] = false },
	[572] = { ["name"] = "Middle072", ["payment"] = false, ["perm"] = false },
	[573] = { ["name"] = "Middle073", ["payment"] = false, ["perm"] = false },
	[574] = { ["name"] = "Middle074", ["payment"] = false, ["perm"] = false },
	[575] = { ["name"] = "Middle075", ["payment"] = false, ["perm"] = false },
	[576] = { ["name"] = "Middle076", ["payment"] = false, ["perm"] = false },
	[577] = { ["name"] = "Middle077", ["payment"] = false, ["perm"] = false },
	[578] = { ["name"] = "Middle078", ["payment"] = false, ["perm"] = false },
	[579] = { ["name"] = "Middle079", ["payment"] = false, ["perm"] = false },
	[580] = { ["name"] = "Middle080", ["payment"] = false, ["perm"] = false },
	[581] = { ["name"] = "Middle081", ["payment"] = false, ["perm"] = false },
	[582] = { ["name"] = "Middle082", ["payment"] = false, ["perm"] = false },
	[583] = { ["name"] = "Middle083", ["payment"] = false, ["perm"] = false },
	[584] = { ["name"] = "Middle084", ["payment"] = false, ["perm"] = false },
	[585] = { ["name"] = "Middle085", ["payment"] = false, ["perm"] = false },
	[586] = { ["name"] = "Middle086", ["payment"] = false, ["perm"] = false },
	[587] = { ["name"] = "Middle087", ["payment"] = false, ["perm"] = false },
	[588] = { ["name"] = "Middle088", ["payment"] = false, ["perm"] = false },
	[589] = { ["name"] = "Middle089", ["payment"] = false, ["perm"] = false },
	[590] = { ["name"] = "Middle090", ["payment"] = false, ["perm"] = false },
	[591] = { ["name"] = "Middle091", ["payment"] = false, ["perm"] = false },
	[592] = { ["name"] = "Middle092", ["payment"] = false, ["perm"] = false },
	[593] = { ["name"] = "Middle093", ["payment"] = false, ["perm"] = false },
	[594] = { ["name"] = "Middle094", ["payment"] = false, ["perm"] = false },
	[595] = { ["name"] = "Middle095", ["payment"] = false, ["perm"] = false },
	[596] = { ["name"] = "Middle096", ["payment"] = false, ["perm"] = false },
	[597] = { ["name"] = "Middle097", ["payment"] = false, ["perm"] = false },
	[598] = { ["name"] = "Middle098", ["payment"] = false, ["perm"] = false },
	[599] = { ["name"] = "Middle099", ["payment"] = false, ["perm"] = false },
	[600] = { ["name"] = "Middle100", ["payment"] = false, ["perm"] = false },
	[601] = { ["name"] = "Middle101", ["payment"] = false, ["perm"] = false },
	[602] = { ["name"] = "Middle102", ["payment"] = false, ["perm"] = false },
	[603] = { ["name"] = "Middle103", ["payment"] = false, ["perm"] = false },
	[604] = { ["name"] = "Middle104", ["payment"] = false, ["perm"] = false },
	[605] = { ["name"] = "Middle105", ["payment"] = false, ["perm"] = false },
	[606] = { ["name"] = "Middle106", ["payment"] = false, ["perm"] = false },
	[607] = { ["name"] = "Middle107", ["payment"] = false, ["perm"] = false },
	[608] = { ["name"] = "Middle108", ["payment"] = false, ["perm"] = false },
	[609] = { ["name"] = "Middle109", ["payment"] = false, ["perm"] = false },
	[610] = { ["name"] = "Middle110", ["payment"] = false, ["perm"] = false },
	[611] = { ["name"] = "Middle111", ["payment"] = false, ["perm"] = false },
	[612] = { ["name"] = "Middle112", ["payment"] = false, ["perm"] = false },
	[613] = { ["name"] = "Middle113", ["payment"] = false, ["perm"] = false },
	[614] = { ["name"] = "Middle114", ["payment"] = false, ["perm"] = false },
	[615] = { ["name"] = "Middle115", ["payment"] = false, ["perm"] = false },
	[616] = { ["name"] = "Middle116", ["payment"] = false, ["perm"] = false },
	[617] = { ["name"] = "Middle117", ["payment"] = false, ["perm"] = false },
	[618] = { ["name"] = "Middle118", ["payment"] = false, ["perm"] = false },
	[619] = { ["name"] = "Middle119", ["payment"] = false, ["perm"] = false },
	[620] = { ["name"] = "Middle120", ["payment"] = false, ["perm"] = false },
	[621] = { ["name"] = "Middle121", ["payment"] = false, ["perm"] = false },
	[622] = { ["name"] = "Middle122", ["payment"] = false, ["perm"] = false },
	[623] = { ["name"] = "Middle123", ["payment"] = false, ["perm"] = false },
	[624] = { ["name"] = "Middle124", ["payment"] = false, ["perm"] = false },
	[625] = { ["name"] = "Middle125", ["payment"] = false, ["perm"] = false },
	[626] = { ["name"] = "Middle126", ["payment"] = false, ["perm"] = false },
	[627] = { ["name"] = "Middle127", ["payment"] = false, ["perm"] = false },
	[628] = { ["name"] = "Middle128", ["payment"] = false, ["perm"] = false },
	[629] = { ["name"] = "Middle129", ["payment"] = false, ["perm"] = false },
	[630] = { ["name"] = "Middle130", ["payment"] = false, ["perm"] = false },
	[631] = { ["name"] = "Middle131", ["payment"] = false, ["perm"] = false },
	[632] = { ["name"] = "Middle132", ["payment"] = false, ["perm"] = false },
	[633] = { ["name"] = "Middle133", ["payment"] = false, ["perm"] = false },
	[634] = { ["name"] = "Middle134", ["payment"] = false, ["perm"] = false },
	[635] = { ["name"] = "Middle135", ["payment"] = false, ["perm"] = false },
	[636] = { ["name"] = "Middle136", ["payment"] = false, ["perm"] = false },
	[637] = { ["name"] = "Middle137", ["payment"] = false, ["perm"] = false },
	[638] = { ["name"] = "Middle138", ["payment"] = false, ["perm"] = false },
	[639] = { ["name"] = "Middle139", ["payment"] = false, ["perm"] = false },
	[640] = { ["name"] = "Middle140", ["payment"] = false, ["perm"] = false },
	[641] = { ["name"] = "Middle141", ["payment"] = false, ["perm"] = false },
	[642] = { ["name"] = "Middle142", ["payment"] = false, ["perm"] = false },
	[643] = { ["name"] = "Middle143", ["payment"] = false, ["perm"] = false },
	[644] = { ["name"] = "Middle144", ["payment"] = false, ["perm"] = false },
	[645] = { ["name"] = "Middle145", ["payment"] = false, ["perm"] = false },
	[646] = { ["name"] = "Middle146", ["payment"] = false, ["perm"] = false },
	[647] = { ["name"] = "Middle147", ["payment"] = false, ["perm"] = false },
	[648] = { ["name"] = "Middle148", ["payment"] = false, ["perm"] = false },
	[649] = { ["name"] = "Middle149", ["payment"] = false, ["perm"] = false },
	[650] = { ["name"] = "Middle150", ["payment"] = false, ["perm"] = false },
	[651] = { ["name"] = "Middle151", ["payment"] = false, ["perm"] = false },
	[652] = { ["name"] = "Middle152", ["payment"] = false, ["perm"] = false },
	[653] = { ["name"] = "Middle153", ["payment"] = false, ["perm"] = false },
	[654] = { ["name"] = "Middle154", ["payment"] = false, ["perm"] = false },
	[655] = { ["name"] = "Middle155", ["payment"] = false, ["perm"] = false },
	[656] = { ["name"] = "Middle156", ["payment"] = false, ["perm"] = false },
	[657] = { ["name"] = "Middle157", ["payment"] = false, ["perm"] = false },
	[658] = { ["name"] = "Middle158", ["payment"] = false, ["perm"] = false },
	[659] = { ["name"] = "Middle159", ["payment"] = false, ["perm"] = false },
	[660] = { ["name"] = "Middle160", ["payment"] = false, ["perm"] = false },
	[661] = { ["name"] = "Middle161", ["payment"] = false, ["perm"] = false },
	[662] = { ["name"] = "Middle162", ["payment"] = false, ["perm"] = false },
	[663] = { ["name"] = "Middle163", ["payment"] = false, ["perm"] = false },
	[664] = { ["name"] = "Middle164", ["payment"] = false, ["perm"] = false },
	[665] = { ["name"] = "Middle165", ["payment"] = false, ["perm"] = false },
	[666] = { ["name"] = "Middle166", ["payment"] = false, ["perm"] = false },
	[667] = { ["name"] = "Middle167", ["payment"] = false, ["perm"] = false },
	[668] = { ["name"] = "Middle168", ["payment"] = false, ["perm"] = false },
	[669] = { ["name"] = "Middle169", ["payment"] = false, ["perm"] = false },
	[670] = { ["name"] = "Middle170", ["payment"] = false, ["perm"] = false },
	[671] = { ["name"] = "Middle171", ["payment"] = false, ["perm"] = false },
	[672] = { ["name"] = "Middle172", ["payment"] = false, ["perm"] = false },
	[673] = { ["name"] = "Middle173", ["payment"] = false, ["perm"] = false },
	[674] = { ["name"] = "Middle174", ["payment"] = false, ["perm"] = false },
	[675] = { ["name"] = "Middle175", ["payment"] = false, ["perm"] = false },
	[676] = { ["name"] = "Middle176", ["payment"] = false, ["perm"] = false },
	[677] = { ["name"] = "Middle177", ["payment"] = false, ["perm"] = false },
	[678] = { ["name"] = "Middle178", ["payment"] = false, ["perm"] = false },
	[679] = { ["name"] = "Middle179", ["payment"] = false, ["perm"] = false },
	[680] = { ["name"] = "Middle180", ["payment"] = false, ["perm"] = false },
	[681] = { ["name"] = "Middle181", ["payment"] = false, ["perm"] = false },
	[682] = { ["name"] = "Middle182", ["payment"] = false, ["perm"] = false },
	[683] = { ["name"] = "Middle183", ["payment"] = false, ["perm"] = false },
	[684] = { ["name"] = "Middle184", ["payment"] = false, ["perm"] = false },
	[685] = { ["name"] = "Middle185", ["payment"] = false, ["perm"] = false },
	[686] = { ["name"] = "Middle186", ["payment"] = false, ["perm"] = false },
	[687] = { ["name"] = "Middle187", ["payment"] = false, ["perm"] = false },
	[688] = { ["name"] = "Middle188", ["payment"] = false, ["perm"] = false },
	[689] = { ["name"] = "Middle189", ["payment"] = false, ["perm"] = false },
	[690] = { ["name"] = "Middle190", ["payment"] = false, ["perm"] = false },
	[691] = { ["name"] = "Middle191", ["payment"] = false, ["perm"] = false },
	[692] = { ["name"] = "Middle192", ["payment"] = false, ["perm"] = false },
	[693] = { ["name"] = "Middle193", ["payment"] = false, ["perm"] = false },
	[694] = { ["name"] = "Middle194", ["payment"] = false, ["perm"] = false },
	[695] = { ["name"] = "Middle195", ["payment"] = false, ["perm"] = false },
	[696] = { ["name"] = "Middle196", ["payment"] = false, ["perm"] = false },
	[697] = { ["name"] = "Middle197", ["payment"] = false, ["perm"] = false },
	[698] = { ["name"] = "Middle198", ["payment"] = false, ["perm"] = false },
	[699] = { ["name"] = "Middle199", ["payment"] = false, ["perm"] = false },
	[700] = { ["name"] = "Middle200", ["payment"] = false, ["perm"] = false },
	[701] = { ["name"] = "Middle201", ["payment"] = false, ["perm"] = false },
	[702] = { ["name"] = "Middle202", ["payment"] = false, ["perm"] = false },
	[703] = { ["name"] = "Middle203", ["payment"] = false, ["perm"] = false },
	[704] = { ["name"] = "Middle204", ["payment"] = false, ["perm"] = false },
	[705] = { ["name"] = "Middle205", ["payment"] = false, ["perm"] = false },
	[706] = { ["name"] = "Middle206", ["payment"] = false, ["perm"] = false },
	[707] = { ["name"] = "Middle207", ["payment"] = false, ["perm"] = false },
	[708] = { ["name"] = "Middle208", ["payment"] = false, ["perm"] = false },
	[709] = { ["name"] = "Middle209", ["payment"] = false, ["perm"] = false },
	[710] = { ["name"] = "Middle210", ["payment"] = false, ["perm"] = false },
	[711] = { ["name"] = "Middle211", ["payment"] = false, ["perm"] = false },
	[712] = { ["name"] = "Middle212", ["payment"] = false, ["perm"] = false },
	[713] = { ["name"] = "Middle213", ["payment"] = false, ["perm"] = false },
	[714] = { ["name"] = "Middle214", ["payment"] = false, ["perm"] = false },
	[715] = { ["name"] = "Middle215", ["payment"] = false, ["perm"] = false },
	[716] = { ["name"] = "Middle216", ["payment"] = false, ["perm"] = false },
	[717] = { ["name"] = "Middle217", ["payment"] = false, ["perm"] = false },
	[718] = { ["name"] = "Middle218", ["payment"] = false, ["perm"] = false },
	[719] = { ["name"] = "Middle219", ["payment"] = false, ["perm"] = false },
	[720] = { ["name"] = "Middle220", ["payment"] = false, ["perm"] = false },
	[721] = { ["name"] = "Middle221", ["payment"] = false, ["perm"] = false },
	[722] = { ["name"] = "Middle222", ["payment"] = false, ["perm"] = false },
	[723] = { ["name"] = "Middle223", ["payment"] = false, ["perm"] = false },
	[724] = { ["name"] = "Middle224", ["payment"] = false, ["perm"] = false },
	[725] = { ["name"] = "Middle225", ["payment"] = false, ["perm"] = false },
	[726] = { ["name"] = "Middle226", ["payment"] = false, ["perm"] = false },
	[727] = { ["name"] = "Middle227", ["payment"] = false, ["perm"] = false },
	[728] = { ["name"] = "Middle228", ["payment"] = false, ["perm"] = false },
	[729] = { ["name"] = "Middle229", ["payment"] = false, ["perm"] = false },
	[730] = { ["name"] = "Middle230", ["payment"] = false, ["perm"] = false },
	[731] = { ["name"] = "Middle231", ["payment"] = false, ["perm"] = false },
	[732] = { ["name"] = "Middle232", ["payment"] = false, ["perm"] = false },
	[733] = { ["name"] = "Middle233", ["payment"] = false, ["perm"] = false },
	[734] = { ["name"] = "Middle234", ["payment"] = false, ["perm"] = false },
	[735] = { ["name"] = "Middle235", ["payment"] = false, ["perm"] = false },
	[736] = { ["name"] = "Middle236", ["payment"] = false, ["perm"] = false },
	[737] = { ["name"] = "Middle237", ["payment"] = false, ["perm"] = false },
	[738] = { ["name"] = "Middle238", ["payment"] = false, ["perm"] = false },
	[739] = { ["name"] = "Middle239", ["payment"] = false, ["perm"] = false },
	[740] = { ["name"] = "Middle240", ["payment"] = false, ["perm"] = false },
	[741] = { ["name"] = "Middle241", ["payment"] = false, ["perm"] = false },
	[742] = { ["name"] = "Middle242", ["payment"] = false, ["perm"] = false },
	[743] = { ["name"] = "Middle243", ["payment"] = false, ["perm"] = false },
	[744] = { ["name"] = "Middle244", ["payment"] = false, ["perm"] = false },
	[745] = { ["name"] = "Middle245", ["payment"] = false, ["perm"] = false },
	[746] = { ["name"] = "Middle246", ["payment"] = false, ["perm"] = false },
	[747] = { ["name"] = "Middle247", ["payment"] = false, ["perm"] = false },
	[748] = { ["name"] = "Middle248", ["payment"] = false, ["perm"] = false },
	[749] = { ["name"] = "Middle249", ["payment"] = false, ["perm"] = false },
	[750] = { ["name"] = "Middle250", ["payment"] = false, ["perm"] = false },
	[751] = { ["name"] = "Middle251", ["payment"] = false, ["perm"] = false },
	[752] = { ["name"] = "Middle252", ["payment"] = false, ["perm"] = false },
	[753] = { ["name"] = "Middle253", ["payment"] = false, ["perm"] = false },
	[754] = { ["name"] = "Middle254", ["payment"] = false, ["perm"] = false },
	[755] = { ["name"] = "Middle255", ["payment"] = false, ["perm"] = false },
	[756] = { ["name"] = "Middle256", ["payment"] = false, ["perm"] = false },
	[757] = { ["name"] = "Middle257", ["payment"] = false, ["perm"] = false },
	[758] = { ["name"] = "Middle258", ["payment"] = false, ["perm"] = false },
	[759] = { ["name"] = "Police", ["payment"] = true, ["perm"] = "Police" },
--	[760] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
--	[761] = { ["name"] = "Garage", ["payment"] = true, ["public"] = true },
	[762] = { ["name"] = "Goldminer", ["payment"] = true, ["public"] = true },
	[763] = { ["name"] = "Avalanches", ["payment"] = true, ["perm"] = "Avalanches" },
	[764] = { ["name"] = "Kart", ["payment"] = true, ["perm"] = false },
	[765] = { ["name"] = "Taxi Aereo", ["payment"] = false, ["public"] = true },
	[766] = { ["name"] = "Transporte de Presidiario", ["payment"] = false, ["public"] = true },
	[767] = { ["name"] = "Mecanica", ["payment"] = false, ["perm"] = "Mechanic" },
	[768] = { ["name"] = "Mecanica", ["payment"] = false, ["perm"] = "Mechanic" },
	[769] = { ["name"] = "Mecanica", ["payment"] = false, ["perm"] = "Mechanic" },
	[770] = { ["name"] = "Mecanica", ["payment"] = false, ["perm"] = "Mechanic" },
	[771] = { ["name"] = "Paramedic", ["payment"] = false, ["perm"] = "Paramedic" },
	[772] = { ["name"] = "Paramedic", ["payment"] = false, ["perm"] = "Paramedic" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local workgarage = {
	["Paramedic"] = {
		"ambulance"
	},
	["Heliparamedic"] = {
		"maverick2"
	},
	["Police"] = {
	    "fordraptor",
		"tahoe",
		"audia3",
		"audia4",
		"audiq8",
		"audirs5",
        "audirs6avant",
		"audirs62",
		"ducati1200",
		"nspeedo"

	},
	["Police2"] = {
	    "fordraptor",
		"tahoe",
		"audia3",
		"audia4",
		"audiq8",
		"audirs5",
        "audirs6avant",
		"audirs62",
		"nspeedo",
		"sanchez3",
		"polmesa"

	},
	["Helipolice"] = {
		"maverick2"
	},
	["Prison"] = {
		"pbus"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"marquis",
		"seashark",
		"predator",
		"dinghy"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["Fisherman"] = {
		"mule"
	},
	["Garbageman"] = {
		"trash"
	},
	["Tow"] = {
		"flatbed"
	},
	["Mecanica"] = {
		"towtruck"
	},
	["Taxi"] = {
		"taxi"
	},
	["Taxi Aereo"] = {
		"frogger"
	},
	["Transporte de Presidiario"] = {
		"pbus"
	},
	["Ilegal"] = {
		"gburrito2"
	},
	["PostOp"] = {
		"boxville4"
	},
	["Goldminer"] = {
		"tiptruck"
	},
	["Avalanches"] = {
		"burrito2"
	},
	["Kart"] = {
		"veto",
		"veto2"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.myVehicles(work)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myvehicles = {}
		local vehicle = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
		if workgarage[work] then
			for k,v in pairs(workgarage[work]) do
				local veh = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(v) })
				if veh[1] then
					table.insert(myvehicles,{ name = veh[1].vehicle, name2 = vRP.vehicleName(veh[1].vehicle), engine = parseInt(veh[1].engine*0.1), body = parseInt(veh[1].body*0.1), fuel = parseInt(veh[1].fuel), engine2 = "DESATIVADO", freio = "DESATIVADO", transm = "DESATIVADO", susp = "DESATIVADO", blind = "DESATIVADO", turbo = "DESATIVADO" })
				else
					table.insert(myvehicles,{ name = v, name2 = vRP.vehicleName(v), engine = 100, body = 100, fuel = 100, engine2 = "DESATIVADO", freio = "DESATIVADO", transm = "DESATIVADO", susp = "DESATIVADO", blind = "DESATIVADO", turbo = "DESATIVADO" })
				end
			end
		else
			for k,v in ipairs(vehicle) do
				if v.work == "false" then
					local tuning = json.decode(vRP.getSData("custom:"..user_id..":"..vehicle[k].vehicle))
					local nVehicle = { name = vehicle[k].vehicle, name2 = vRP.vehicleName(vehicle[k].vehicle), engine = parseInt(vehicle[k].engine*0.1), body = parseInt(vehicle[k].body*0.1), fuel = parseInt(vehicle[k].fuel), engine2 = "DESATIVADO", freio = "DESATIVADO", transm = "DESATIVADO", susp = "DESATIVADO", blind = "DESATIVADO", turbo = "DESATIVADO" }
					if tuning then
						nVehicle.engine2 = tuning.engine
						nVehicle.freio = tuning.brakes
						nVehicle.transm = tuning.transmission
						nVehicle.susp = tuning.suspension
						nVehicle.blind = tuning.armor
						nVehicle.turbo = tuning.turbo

						if nVehicle.engine2 == -1 then
							nVehicle.engine2 = "DESATIVADO"
						elseif nVehicle.engine2 == 0 then
							nVehicle.engine2 = "Nível 1 / 5"
						elseif nVehicle.engine2 == 1 then
							nVehicle.engine2 = "Nível 2 / 5"
						elseif nVehicle.engine2 == 2 then
							nVehicle.engine2 = "Nível 3 / 5"
						elseif nVehicle.engine2 == 3 then
							nVehicle.engine2 = "Nível 4 / 5"
						elseif nVehicle.engine2 == 4 then
							nVehicle.engine2 = "Nível 5 / 5"
						end
				
						if nVehicle.freio == -1 then
							nVehicle.freio = "DESATIVADO"
						elseif nVehicle.freio == 0 then
							nVehicle.freio = "Nível 1 / 3"
						elseif nVehicle.freio == 1 then
							nVehicle.freio = "Nível 2 / 3"
						elseif nVehicle.freio == 2 then
							nVehicle.freio = "Nível 3 / 3"
						end
				
						if nVehicle.transm == -1 then
							nVehicle.transm = "DESATIVADO"
						elseif nVehicle.transm == 0 then
							nVehicle.transm = "Nível 1 / 4"
						elseif nVehicle.transm == 1 then
							nVehicle.transm = "Nível 2 / 4"
						elseif nVehicle.transm == 2 then
							nVehicle.transm = "Nível 3 / 4"
						elseif nVehicle.transm == 3 then
							nVehicle.transm = "Nível 4 / 4"
						end

						if nVehicle.susp == -1 then
							nVehicle.susp = "DESATIVADO"
						elseif nVehicle.susp == 0 then
							nVehicle.susp = "Nível 1 / 5"
						elseif nVehicle.susp == 1 then
							nVehicle.susp = "Nível 2 / 5"
						elseif nVehicle.susp == 2 then
							nVehicle.susp = "Nível 3 / 5"
						elseif nVehicle.susp == 3 then
							nVehicle.susp = "Nível 4 / 5"
						elseif nVehicle.susp == 4 then
							nVehicle.susp = "Nível 5 / 5"
						end
					
						if nVehicle.blind == -1 then
							nVehicle.blind = "DESATIVADO"
						elseif nVehicle.blind == 0 then
							nVehicle.blind = "Nível 1 / 5"
						elseif nVehicle.blind == 1 then
							nVehicle.blind = "Nível 2 / 5"
						elseif nVehicle.blind == 2 then
							nVehicle.blind = "Nível 3 / 5"
						elseif nVehicle.blind == 3 then
							nVehicle.blind = "Nível 4 / 5"
						elseif nVehicle.blind == 4 then
							nVehicle.blind = "Nível 5 / 5"
						end
					end
					nVehicle.detido = parseInt(os.time()) <= parseInt(vehicle[k].time+24*60*60)

					vehChest[parseInt(user_id)] = "chest:"..parseInt(user_id)..":"..vehicle[k].vehicle
					local inv = vRP.getInventory(parseInt(user_id))
					local data = vRP.getSData(vehChest[parseInt(user_id)])
					local sdata = json.decode(data) or {}
					nVehicle.pmalas = vRP.computeChestWeight(sdata)
					nVehicle.pmalas2 = vRP.vehicleChest(vehicle[k].vehicle)
					if nVehicle.detido == false then
						nVehicle.detido = "Nao"
					elseif nVehicle.detido == true then
						nVehicle.detido = "Sim"
					end
					table.insert(myvehicles, nVehicle)				
		
				end
			end
		end
		return myvehicles
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.spawnVehicles(name,use)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and name then
        if not vCLIENT.returnVehicle(source,name) then
            local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })

			if vehicle[1] == nil then
				vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), work = tostring(true) })
				vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
			end

			if parseInt(os.time()) <= parseInt(vehicle[1].time+24*60*60) then
				local status = vRP.request(source,"Veículo detido, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.5)).."</b> dólares?",60)
				if status then
					if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(name)*0.5)) then
						vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
					end
				end
			elseif parseInt(vehicle[1].arrest) >= 1 then
				local status = vRP.request(source,"Veículo detido, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares?",60)
				if status then
					if vRP.paymentBank(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
						vRP.execute("vRP/set_arrest",{ user_id = parseInt(user_id), vehicle = name, arrest = 0, time = 0 })
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
					end
				end
			elseif vRP.vehicleType(tostring(name)) == "donate" and vRP.getCarPremium(name,user_id)then
				local status = vRP.request(source,"Veículo esta atrasado, deseja renovar este veiculo donate pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name))).."</b> coins?",60)
				if status then
					if vRP.remGmsId(user_id,parseInt(vRP.vehiclePrice(name))) then
						vRP.execute("vRP/set_rental_time",{ user_id = parseInt(user_id), vehicle = name, premiumtime = parseInt(os.time()) })
					else
						TriggerClientEvent("Notify",source,"vermelho","Coins insuficiente.",5000)
					end
				end
			else
				local tuning = vRP.getSData("custom:"..user_id..":"..name) or {}
				local custom = json.decode(tuning) or {}

				if vehicle[1].plate == nil then
					vehicle[1].plate = vRP.generatePlateNumber()
					vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(user_id), vehicle = name, plate = vehicle[1].plate })
				end

				if garages[use].payment and not vRP.getPremium(parseInt(user_id)) then
					if vRP.getBank(parseInt(user_id)) >= parseInt(vRP.vehiclePrice(name)*0.05) then
						local status,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].plate,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom,vehicle[1].windows,vehicle[1].doors,vehicle[1].tyres)
						if status and vRP.paymentBank(parseInt(user_id),parseInt(vRP.vehiclePrice(name)*0.05)) then
							vehlist[vehid] = { parseInt(user_id),name }
							spanwedVehs[name..user_id] = true

							TriggerEvent("setPlateEveryone",vehicle[1].plate)
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
					end
				else
					local status,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].plate,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom,vehicle[1].windows,vehicle[1].doors,vehicle[1].tyres)
					if status then
						vehlist[vehid] = { parseInt(user_id),name }
						spanwedVehs[name..user_id] = true
					
						TriggerEvent("setPlateEveryone",vehicle[1].plate)
					end
				end

				if name == "stockade" then
					TriggerEvent("vrp_stockade:inputVehicle",vehicle[1].plate)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você já tem um veículo deste modelo fora da garagem.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.deleteVehicles()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRPclient.getNearVehicle(source,15)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		local vehicle = vRPclient.getNearVehicle(source,15)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FGARAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rgarage",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		spanwedVehs[args[1]..args[2]] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.vehicleLock()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
		if vehicle and vehPlate then
			local plateUserId = vRP.getVehiclePlate(vehPlate)
			if user_id == plateUserId or stealVehs[vehPlate] == user_id then
				TriggerClientEvent("garages:vehicleClientLock",-1,vehNet,vehLock)

				if vehLock == 1 then
					TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
					TriggerClientEvent("sound:source",source,"unlock",0.5)
				else
					TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
					TriggerClientEvent("sound:source",source,"lock",0.5)
				end

				if not vRPclient.inVehicle(source) then
					vRPclient.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
					Citizen.Wait(500)
					vRPclient.stopAnim(source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.tryDelete(vehid,vehengine,vehbody,vehfuel,vehDoors,vehWindows,vehTyres,vehPlate)
	local source = source
	if vehlist[vehid] and vehid ~= 0 then
		local user_id = vehlist[vehid][1]
		local vehname = vehlist[vehid][2]

		local player = vRP.getUserSource(user_id)
		if player then
			vCLIENT.syncNameDelete(player,vehname)
		end

		if parseInt(vehengine) <= 100 then
			vehengine = 100
		end

		if parseInt(vehbody) <= 100 then
			vehbody = 100
		end

		if parseInt(vehfuel) >= 100 then
			vehfuel = 100
		end

		if parseInt(vehfuel) <= 5 then
			vehfuel = 5
		end

		local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehname) })
		if vehicle[1] ~= nil then
			spanwedVehs[vehname..user_id] = nil
			vRP.execute("vRP/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehname), engine = parseInt(vehengine), body = parseInt(vehbody), fuel = parseInt(vehfuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end

		if vehlist[vehid] then
			vehlist[vehid] = nil
		end
	end

	TriggerClientEvent("garages:syncVehicle",-1,vehid,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- garages:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:DeleteVehicle")
AddEventHandler("garages:DeleteVehicle",function(vehid,vehPlate)
	TriggerClientEvent("garages:syncVehicle",-1,vehid,vehPlate)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNHOUSES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.returnHouses(nome,garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) then
			if string.sub(nome,0,6) == "Middle" then
				local myHomes = vRP.query("vRP/get_homeuser",{ user_id = parseInt(user_id), home = tostring(nome) })
				if myHomes[1] == nil then
					return false
				end
			end

			if garages[garage].perm then
				if vRP.hasPermission(user_id,garages[garage].perm) then
					return vCLIENT.openGarage(source,nome,garage)
				end
			else
				local getFines = vRP.getFines(user_id)
				if getFines[1] then
					TriggerClientEvent("Notify",source,"amarelo","Você tem multas pendentes.",5000)
					return false
				end

				return vCLIENT.openGarage(source,nome,garage)
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
 	if user_id then
		if vRP.hasPermission(user_id,"Admin") and args[1] then
			local plate = "1A3B5C7D"
			TriggerClientEvent("adminVehicle",source,args[1],plate)
      		TriggerEvent("setPlateEveryone",plate)
			TriggerEvent("setPlatePlayers",plate,user_id)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vehs",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "transfer" and parseInt(args[3]) > 0 then
			local myvehicles = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(args[2]) })
			if myvehicles[1] then
				local maxVehs = vRP.query("vRP/con_maxvehs",{ user_id = parseInt(args[3]) })
				local myGarages = vRP.getInformation(args[3])
				if vRP.getPremium(parseInt(args[3])) then
					if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) + 2 then
						TriggerClientEvent("Notify",source,"amarelo","Você atingiu o número máximo de veículos na garagem.",5000)
						return
					end
				else
					if parseInt(maxVehs[1].qtd) >= parseInt(myGarages[1].garage) then
						TriggerClientEvent("Notify",source,"amarelo","Você atingiu o número máximo de veículos na garagem.",5000)
						return
					end
				end

				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if vRP.request(source,"Deseja transferir o veículo <b>"..vRP.vehicleName(tostring(args[2])).."</b> para <b>"..identity.name.."</b>?",30) then
					local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(args[3]), vehicle = tostring(args[2]) })
					if vehicle[1] then
						TriggerClientEvent("Notify",source,"vermelho","<b>"..identity.name.."</b> já possui este veículo.",5000)
					else
						vRP.execute("vRP/move_vehicle",{ user_id = parseInt(user_id), nuser_id = parseInt(args[3]), vehicle = tostring(args[2]) })

						local custom = vRP.getSData("custom:"..parseInt(user_id)..":"..tostring(args[2]))
						local custom2 = json.decode(custom) or {}
						if custom and custom2 ~= nil then
							vRP.setSData("custom:"..parseInt(args[3])..":"..tostring(args[2]),json.encode(custom2))
							vRP.execute("vRP/rem_srv_data",{ dkey = "custom:"..parseInt(user_id)..":"..tostring(args[2]) })
						end

						local chest = vRP.getSData("chest:"..parseInt(user_id)..":"..tostring(args[2]))
						local chest2 = json.decode(chest) or {}
						if chest and chest2 ~= nil then
							vRP.setSData("chest:"..parseInt(args[3])..":"..tostring(args[2]),json.encode(chest2))
							vRP.execute("vRP/rem_srv_data",{ dkey = "chest:"..parseInt(user_id)..":"..tostring(args[2]) })
						end

						TriggerClientEvent("Notify",source,"verde","Transferência concluída com sucesso.",5000)
					end
				end
			end
		else
			local vehicle = vRP.query("vRP/get_vehicle",{ user_id = parseInt(user_id) })
			for k,v in ipairs(vehicle) do
				TriggerClientEvent("Notify",source,"default","<b>Modelo:</b> "..vRP.vehicleName(v.vehicle).." ( "..v.vehicle.." )",10000)
				Citizen.Wait(1)
			end
		end
	end
end)