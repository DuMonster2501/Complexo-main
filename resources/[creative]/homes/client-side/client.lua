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
Tunnel.bindInterface("homes",cRP)
vSERVER = Tunnel.getInterface("homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local houseOpen = ""
local homesList = {}
local homesTheft = {}
local homeObjects = {}
local houseNetwork = {}
local internHouses = {}
local theftOpen = false
local theftLocker = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(homesList) do
            local distance = #(coords - vector3(v[5],v[6],v[7]))
            if distance <= 1.5 then
                timeDistance = 5
                DrawText3Ds(v[5],v[6],v[7],"~w~/ENTRAR    |    /PORTA")
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	vSERVER.chestClose()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("homes:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("homes:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sumSlot",function(data,cb)
	TriggerServerEvent("homes:sumSlot",data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- homes:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Update")
AddEventHandler("homes:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVault",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos = vSERVER.openChest(tostring(houseOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PORTA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("porta",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.5 then
			vSERVER.tryUnlock(k)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("entrar",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.5 and vSERVER.checkPermissions(k) then
			removeObjectHomes()
			DoScreenFadeOut(1000)
			houseOpen = tostring(k)
			vSERVER.setNetwork(tostring(k))
			vSERVER.applyHouseOpen(tostring(k))
			TriggerEvent("sounds:source","enterhouse",0.7)
			Citizen.Wait(1000)

			if v[1] == "Hotel" then
				createHotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Middle" then
				createMiddle(ped,v[5],v[6],1500.0)
			end

			SetTimecycleModifier("AmbientPUSH")

			Citizen.Wait(1000)

			if v[1] == "Hotel" then
				SetEntityCoords(ped,v[5]-1.65,v[6]-4.02,1501.0)
				table.insert(internHouses,{ v[5]-1.65,v[6]-4.02,1501.0,"exit","SAIR" })
				table.insert(internHouses,{ v[5]-1.73,v[6]+0.96,1500.7,"vault","ABRIR" })
			end

			if v[1] == "Middle" then
				SetEntityCoords(ped,v[5]+3.63,v[6]-15.43,1502.0)
				table.insert(internHouses,{ v[5]+3.63,v[6]-15.43,1502.3,"exit","SAIR" })
				table.insert(internHouses,{ v[5]+9,v[6]-1.41,1502.0,"vault","ABRIR" })
			end

			TriggerEvent("homes:Hours",true)
			FreezeEntityPosition(ped,true)
			SetEntityInvincible(ped,true)
			Citizen.Wait(3000)
			FreezeEntityPosition(ped,false)
			SetEntityInvincible(ped,false)
			DoScreenFadeIn(1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if houseOpen ~= "" then
			for k,v in ipairs(GetActivePlayers()) do
				if PlayerId() ~= v and houseNetwork[GetPlayerServerId(v)] == nil then
					NetworkFadeOutEntity(GetPlayerPed(v),true)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATENETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if houseOpen ~= "" then
			houseNetwork = vSERVER.getNetwork(tostring(houseOpen))
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHomeStatistics()
	return tostring(houseOpen)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANUPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanupHomes()
	houseOpen = ""
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHomesRejoin()
	if houseOpen ~= "" and not theftOpen then
		vSERVER.removeNetwork(tostring(houseOpen))
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomes(status)
	homesList = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local casas = false
RegisterNetEvent("homes:togglePropertys")
AddEventHandler("homes:togglePropertys",function(source,args)
	casas = not casas

	if casas then
		TriggerEvent("Notify","amarelo","Marcações ativadas.",3000)
		
		for k,v in pairs(homesList) do
			blips[k] = AddBlipForRadius(v[5],v[6],v[7],5.0)
			SetBlipAlpha(blips[k],255)
			SetBlipColour(blips[k],82)
		end
	else
		TriggerEvent("Notify","amarelo","Marcações desativadas.",3000)
		
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		blips = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEHOTEL
-----------------------------------------------------------------------------------------------------------------------------------------
function createHotel(ped,x,y,z)
	homeObjects[1] = CreateObject(GetHashKey("creative_hotel"),x-0.7,y-0.4,z-1.42,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)

	Citizen.Wait(100)

	homeObjects[2] = CreateObject(GetHashKey("v_49_motelmp_stuff"),x,y,z,false,false,false)
	homeObjects[3] = CreateObject(GetHashKey("v_49_motelmp_bed"),x+1.4,y-0.55,z,false,false,false)
	homeObjects[4] = CreateObject(GetHashKey("v_49_motelmp_clothes"),x-2.0,y+2.0,z+0.15,false,false,false)
	homeObjects[5] = CreateObject(GetHashKey("v_49_motelmp_curtains"),x+0.74,y-4.15,z+0.9,false,false,false)
	homeObjects[6] = CreateObject(GetHashKey("v_49_motelmp_screen"),x-2.21,y-0.6,z+0.79,false,false,false)
	homeObjects[7] = CreateObject(GetHashKey("v_res_fa_trainer02r"),x-1.9,y+3.0,z+0.38,false,false,false)
	homeObjects[8] = CreateObject(GetHashKey("v_res_fa_trainer02l"),x-2.1,y+2.95,z+0.38,false,false,false)
	homeObjects[9] = CreateObject(GetHashKey("prop_sink_06"),x+1.1,y+4.0,z,false,false,false)
	homeObjects[10] = CreateObject(GetHashKey("prop_chair_04a"),x+2.1,y-2.4,z,false,false,false)
	homeObjects[11] = CreateObject(GetHashKey("prop_chair_04a"),x+0.7,y-3.5,z,false,false,false)
	homeObjects[12] = CreateObject(GetHashKey("prop_kettle"),x-2.3,y+0.6,z+0.9,false,false,false)
	homeObjects[13] = CreateObject(GetHashKey("Prop_TV_Cabinet_03"),x-2.3,y-0.6,z,false,false,false)
	homeObjects[14] = CreateObject(GetHashKey("prop_tv_06"),x-2.3,y-0.6,z+0.7,false,false,false)
	homeObjects[15] = CreateObject(GetHashKey("Prop_LD_Toilet_01"),x+2.1,y+2.9,z,false,false,false)
	homeObjects[16] = CreateObject(GetHashKey("Prop_Game_Clock_02"),x-2.55,y-0.6,z+2.0,false,false,false)
	homeObjects[17] = CreateObject(GetHashKey("v_res_j_phone"),x+2.4,y-1.9,z+0.64,false,false,false)
	homeObjects[18] = CreateObject(GetHashKey("v_ret_fh_ironbrd"),x-1.7,y+3.5,z+0.15,false,false,false)
	homeObjects[19] = CreateObject(GetHashKey("prop_iron_01"),x-1.9,y+2.85,z+0.63,false,false,false)
	homeObjects[20] = CreateObject(GetHashKey("V_Ret_TA_Mug"),x-2.3,y+0.95,z+0.9,false,false,false)
	homeObjects[21] = CreateObject(GetHashKey("V_Ret_TA_Mug"),x-2.2,y+0.9,z+0.9,false,false,false)
	homeObjects[22] = CreateObject(GetHashKey("v_res_binder"),x-2.2,y+1.3,z+0.87,false,false,false)

	FreezeEntityPosition(homeObjects[9],true)
	FreezeEntityPosition(homeObjects[10],true)
	FreezeEntityPosition(homeObjects[11],true)
	FreezeEntityPosition(homeObjects[13],true)
	FreezeEntityPosition(homeObjects[14],true)
	SetEntityHeading(homeObjects[10],GetEntityHeading(homeObjects[10])+270)
	SetEntityHeading(homeObjects[11],GetEntityHeading(homeObjects[11])+180)
	SetEntityHeading(homeObjects[12],GetEntityHeading(homeObjects[12])+90)
	SetEntityHeading(homeObjects[13],GetEntityHeading(homeObjects[13])+90)
	SetEntityHeading(homeObjects[14],GetEntityHeading(homeObjects[14])+90)
	SetEntityHeading(homeObjects[15],GetEntityHeading(homeObjects[15])+270)
	SetEntityHeading(homeObjects[16],GetEntityHeading(homeObjects[16])+90)
	SetEntityHeading(homeObjects[17],GetEntityHeading(homeObjects[17])+220)
	SetEntityHeading(homeObjects[18],GetEntityHeading(homeObjects[18])+90)
	SetEntityHeading(homeObjects[19],GetEntityHeading(homeObjects[19])+230)
	SetEntityHeading(homeObjects[20],GetEntityHeading(homeObjects[20])+20)
	SetEntityHeading(homeObjects[21],GetEntityHeading(homeObjects[21])+230)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function getRotation(input)
	return 360 / (10*input)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMIDDLE
-----------------------------------------------------------------------------------------------------------------------------------------
function createMiddle(ped,x,y,z)
	homeObjects[1] = CreateObject(GetHashKey("creative_middle"),x,y,z,false,false,false)

	FreezeEntityPosition(homeObjects[1],true)

	Citizen.Wait(100)

	homeObjects[2] = CreateObject(GetHashKey("V_16_DT"),x-1.21854400,y-1.04389600,z+1.39068600,false,false,false)
	homeObjects[3] = CreateObject(GetHashKey("V_16_mpmidapart01"),x+0.52447510,y-5.04953700,z+1.32,false,false,false)
	homeObjects[4] = CreateObject(GetHashKey("V_16_mpmidapart09"),x+0.82202150,y+2.29612000,z+1.88,false,false,false)
	homeObjects[5] = CreateObject(GetHashKey("V_16_mpmidapart07"),x-1.91445900,y-6.61911300,z+1.45,false,false,false)
	homeObjects[6] = CreateObject(GetHashKey("V_16_mpmidapart03"),x-4.82565300,y-6.86803900,z+1.14,false,false,false)
	homeObjects[7] = CreateObject(GetHashKey("V_16_midapartdeta"),x+2.28558400,y-1.94082100,z+1.288628,false,false,false)
	homeObjects[8] = CreateObject(GetHashKey("V_16_treeglow"),x-1.37408500,y-0.95420070,z+1.135,false,false,false)
	homeObjects[9] = CreateObject(GetHashKey("V_16_midapt_curts"),x-1.96423300,y-0.95958710,z+1.280,false,false,false)
	homeObjects[10] = CreateObject(GetHashKey("V_16_mpmidapart13"),x-4.65580700,y-6.61684000,z+1.259,false,false,false)
	homeObjects[11] = CreateObject(GetHashKey("V_16_midapt_cabinet"),x-1.16177400,y-0.97333810,z+1.27,false,false,false)
	homeObjects[12] = CreateObject(GetHashKey("V_16_midapt_deca"),x+2.311386000,y-2.05385900,z+1.297,false,false,false)
	homeObjects[13] = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"),x+3.69693000,y-5.80020100,z+1.293,false,false,false)
	homeObjects[14] = CreateObject(GetHashKey("V_16_mid_bed_delta"),x+7.95187400,y+1.04246500,z+1.28402300,false,false,false)
	homeObjects[15] = CreateObject(GetHashKey("apa_mp_h_bed_double_08"),x+5.56576900,y+1.15651200,z+1.36589100,false,false,false)
	homeObjects[17] = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"),x+4.45460500,y+3.21322800,z+1.21116100,false,false,false)
	homeObjects[18] = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"),x+3.57740800,y+3.25032000,z+1.48871300,false,false,false)

	homeObjects[19] = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"),x+1.73134600,y-4.88520200,z+1.91083000,false,false,false)
	homeObjects[20] = CreateObject(GetHashKey("v_res_mp_sofa"),x-1.48765600,y+1.68100600,z+1.21640500,false,false,false)
	homeObjects[21] = CreateObject(GetHashKey("v_res_mp_stripchair"),x-4.44770800,y-1.78048800,z+1.21640500,false,false,false)
	homeObjects[23] = CreateObject(GetHashKey("Prop_Plant_Int_04a"),x+2.78941300,y-4.39133900,z+2.12746400,false,false,false)
	homeObjects[24] = CreateObject(GetHashKey("v_res_d_lampa"),x-3.61473100,y-6.61465100,z+2.08382800,false,false,false)
	homeObjects[25] = CreateObject(GetHashKey("v_res_fridgemodsml"),x+1.90339700,y-3.80026800,z+1.29917900,false,false,false)
	homeObjects[26] = CreateObject(GetHashKey("prop_micro_01"),x+2.03442400,y-4.61585100,z+2.30395600,false,false,false)
	homeObjects[27] = CreateObject(GetHashKey("V_Res_Tre_SideBoard"),x+2.84053000,y-4.30947100,z+1.24577300,false,false,false)
	homeObjects[28] = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"),x-3.50363200,y-6.55289400,z+1.30625800,false,false,false)
	homeObjects[29] = CreateObject(GetHashKey("v_res_d_lampa"),x+2.69674700,y-3.83123500,z+2.09373700,false,false,false)
	homeObjects[30] = CreateObject(GetHashKey("v_res_tre_tree"),x-4.96064800,y-6.09898500,z+1.31631400,false,false,false)
	homeObjects[31] = CreateObject(GetHashKey("V_Res_M_DineTble_replace"),x-3.50712600,y-4.13621600,z+1.29625800,false,false,false)
	homeObjects[32] = CreateObject(GetHashKey("Prop_TV_Flat_01"),x-5.53120400,y+0.76299670,z+2.17236000,false,false,false)
	homeObjects[33] = CreateObject(GetHashKey("v_res_tre_plant"),x-5.14112800,y-2.78951000,z+1.25950800,false,false,false)
	homeObjects[34] = CreateObject(GetHashKey("v_res_m_dinechair"),x-3.04652400,y-4.95971200,z+1.19625800,false,false,false)
	homeObjects[35] = CreateObject(GetHashKey("v_res_m_lampstand"),x+1.26588400,y+3.68883900,z+1.30556700,false,false,false)
	homeObjects[36] = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"),x-3.23216300,y+2.06159000,z+1.20556700,false,false,false)
	homeObjects[37] = CreateObject(GetHashKey("v_res_m_dinechair"),x-2.82237200,y-3.59831300,z+1.25950800,false,false,false)
	homeObjects[38] = CreateObject(GetHashKey("v_res_m_dinechair"),x-4.14955100,y-4.71316600,z+1.19625800,false,false,false)
	homeObjects[39] = CreateObject(GetHashKey("v_res_m_dinechair"),x-3.80622900,y-3.37648300,z+1.19625800,false,false,false)

	homeObjects[40] = CreateObject(GetHashKey("v_res_fa_plant01"),x+2.97859200,y+2.55307400,z+1.85796300,false,false,false)
	homeObjects[41] = CreateObject(GetHashKey("v_res_tre_storageunit"),x+8.47819500,y-2.50979300,z+1.19712300,false,false,false)
	homeObjects[42] = CreateObject(GetHashKey("v_res_tre_storagebox"),x+9.75982700,y-1.35874100,z+1.29625800,false,false,false)
	homeObjects[43] = CreateObject(GetHashKey("v_res_tre_basketmess"),x+8.70730600,y-2.55503600,z+1.94059590,false,false,false)
	homeObjects[44] = CreateObject(GetHashKey("v_res_m_lampstand"),x+9.54306000,y-2.50427700,z+1.30556700,false,false,false)
	homeObjects[45] = CreateObject(GetHashKey("Prop_Plant_Int_03a"),x+9.87521400,y+3.90917400,z+1.20829700,false,false,false)

	homeObjects[46] = CreateObject(GetHashKey("v_res_tre_washbasket"),x+9.39091500,y+4.49676300,z+1.19625800,false,false,false)
	homeObjects[47] = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"),x+8.46626300,y+4.53223600,z+1.19425800,false,false,false)
	homeObjects[48] = CreateObject(GetHashKey("v_res_tre_flatbasket"),x+8.51593000,y+4.55647300,z+3.46737300,false,false,false)
	homeObjects[49] = CreateObject(GetHashKey("v_res_tre_basketmess"),x+7.57797200,y+4.55198800,z+3.46737300,false,false,false)
	homeObjects[50] = CreateObject(GetHashKey("v_res_tre_flatbasket"),x+7.12286400,y+4.54689200,z+3.46737300,false,false,false)
	homeObjects[51] = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"),x+7.24382000,y+4.53423500,z+1.19625800,false,false,false)
	homeObjects[52] = CreateObject(GetHashKey("v_res_tre_flatbasket"),x+8.03364600,y+4.54835500,z+3.46737300,false,false,false)

	homeObjects[53] = CreateObject(GetHashKey("v_serv_switch_2"),x+6.28086900,y-0.68169880,z+2.30326000,false,false,false)

	homeObjects[54] = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"),x+5.84416200,y+2.57377400,z+1.22089100,false,false,false)
	homeObjects[55] = CreateObject(GetHashKey("v_res_d_lampa"),x+5.84912100,y+2.58001100,z+1.95311890,false,false,false)
	homeObjects[56] = CreateObject(GetHashKey("v_res_mlaundry"),x+5.77729800,y+4.60211400,z+1.19674400,false,false,false)

	homeObjects[57] = CreateObject(GetHashKey("Prop_ashtray_01"),x-1.24716200,y+1.07820500,z+1.89089300,false,false,false)

	homeObjects[58] = CreateObject(GetHashKey("v_res_fa_candle03"),x-2.89289900,y-4.35329700,z+2.02881310,false,false,false)
	homeObjects[59] = CreateObject(GetHashKey("v_res_fa_candle02"),x-3.99865700,y-4.06048500,z+2.02530190,false,false,false)
	homeObjects[60] = CreateObject(GetHashKey("v_res_fa_candle01"),x-3.37733400,y-3.66639800,z+2.02526200,false,false,false)
	homeObjects[61] = CreateObject(GetHashKey("v_res_m_woodbowl"),x-3.50787400,y-4.11983000,z+2.02589900,false,false,false)
	homeObjects[62] = CreateObject(GetHashKey("V_Res_TabloidsA"),x-0.80513000,y+0.51389600,z+1.18418800,false,false,false)

	homeObjects[64] = CreateObject(GetHashKey("v_res_tre_fruitbowl"),x+2.77764900,y-4.138297000,z+2.10340100,false,false,false)
	homeObjects[65] = CreateObject(GetHashKey("v_res_sculpt_dec"),x+3.03932200,y+1.62726400,z+3.58363900,false,false,false)
	homeObjects[66] = CreateObject(GetHashKey("v_res_jewelbox"),x+3.04164100,y+0.31671810,z+3.58363900,false,false,false)

	homeObjects[67] = CreateObject(GetHashKey("v_res_tre_basketmess"),x-1.64906300,y+1.62675900,z+1.39038500,false,false,false)
	homeObjects[68] = CreateObject(GetHashKey("v_res_tre_flatbasket"),x-1.63938900,y+0.91133310,z+1.39038500,false,false,false)

	homeObjects[69] = CreateObject(GetHashKey("v_res_tre_flatbasket"),x-1.19923400,y+1.69598600,z+1.39038500,false,false,false)
	homeObjects[70] = CreateObject(GetHashKey("v_res_tre_basketmess"),x-1.18293800,y+0.91436380,z+1.39038500,false,false,false)
	homeObjects[71] = CreateObject(GetHashKey("v_res_r_sugarbowl"),x-0.26029210,y-6.66716800,z+3.77324900,false,false,false)
	homeObjects[72] = CreateObject(GetHashKey("Prop_Breadbin_01"),x+2.09788500,y-6.57634000,z+2.24041900,false,false,false)
	homeObjects[73] = CreateObject(GetHashKey("v_res_mknifeblock"),x+1.82084700,y-6.58438500,z+2.27399500,false,false,false)

	homeObjects[74] = CreateObject(GetHashKey("prop_toaster_01"),x-1.05790700,y-6.59017400,z+2.26793200,false,false,false)
	homeObjects[76] = CreateObject(GetHashKey("Prop_Plant_Int_03a"),x+2.55015600,y+4.60183900,z+1.20829700,false,false,false)

	homeObjects[78] = CreateObject(GetHashKey("v_res_tissues"),x+7.95889300,y-2.54847100,z+1.94013400,false,false,false)
	homeObjects[79] = CreateObject(GetHashKey("v_club_vuhairdryer"),x+8.12616000,y-2.50562000,z+1.96009390,false,false,false)
	homeObjects[80] = CreateObject(GetHashKey("prop_watercooler"),x-0.605,y-3.10562000,z+1.36009390,false,false,false)

	FreezeEntityPosition(homeObjects[2],true)
	FreezeEntityPosition(homeObjects[3],true)
	FreezeEntityPosition(homeObjects[4],true)
	FreezeEntityPosition(homeObjects[4],true)
	FreezeEntityPosition(homeObjects[6],true)
	FreezeEntityPosition(homeObjects[7],true)
	FreezeEntityPosition(homeObjects[8],true)
	FreezeEntityPosition(homeObjects[9],true)
	FreezeEntityPosition(homeObjects[10],true)
	FreezeEntityPosition(homeObjects[11],true)
	FreezeEntityPosition(homeObjects[12],true)
	FreezeEntityPosition(homeObjects[13],true)
	FreezeEntityPosition(homeObjects[20],true)
	FreezeEntityPosition(homeObjects[21],true)
	FreezeEntityPosition(homeObjects[23],true)
	FreezeEntityPosition(homeObjects[24],true)
	FreezeEntityPosition(homeObjects[25],true)
	FreezeEntityPosition(homeObjects[26],true)
	FreezeEntityPosition(homeObjects[27],true)
	FreezeEntityPosition(homeObjects[28],true)
	FreezeEntityPosition(homeObjects[30],true)
	FreezeEntityPosition(homeObjects[31],true)
	FreezeEntityPosition(homeObjects[32],true)
	FreezeEntityPosition(homeObjects[33],true)
	FreezeEntityPosition(homeObjects[34],true)
	FreezeEntityPosition(homeObjects[35],true)
	FreezeEntityPosition(homeObjects[37],true)
	FreezeEntityPosition(homeObjects[38],true)
	FreezeEntityPosition(homeObjects[39],true)
	FreezeEntityPosition(homeObjects[40],true)
	FreezeEntityPosition(homeObjects[41],true)
	FreezeEntityPosition(homeObjects[42],true)
	FreezeEntityPosition(homeObjects[46],true)
	FreezeEntityPosition(homeObjects[47],true)
	FreezeEntityPosition(homeObjects[51],true)
	FreezeEntityPosition(homeObjects[54],true)
	FreezeEntityPosition(homeObjects[55],true)
	FreezeEntityPosition(homeObjects[56],true)
	FreezeEntityPosition(homeObjects[14],true)
	FreezeEntityPosition(homeObjects[15],true)
	FreezeEntityPosition(homeObjects[68],true)
	FreezeEntityPosition(homeObjects[67],true)
	FreezeEntityPosition(homeObjects[69],true)
	FreezeEntityPosition(homeObjects[71],true)
	FreezeEntityPosition(homeObjects[80],true)

	SetEntityHeading(homeObjects[15],GetEntityHeading(homeObjects[15])+90)
	SetEntityHeading(homeObjects[19],GetEntityHeading(homeObjects[19])+90)
	SetEntityHeading(homeObjects[20],GetEntityHeading(homeObjects[20])-90)
	SetEntityHeading(homeObjects[21],GetEntityHeading(homeObjects[21])+getRotation(0.28045480))
	SetEntityHeading(homeObjects[25],GetEntityHeading(homeObjects[25])-90)
	SetEntityHeading(homeObjects[26],GetEntityHeading(homeObjects[26])-80)
	SetEntityHeading(homeObjects[27],GetEntityHeading(homeObjects[27])+90)
	SetEntityHeading(homeObjects[28],GetEntityHeading(homeObjects[28])+180)
	SetEntityHeading(homeObjects[32],GetEntityHeading(homeObjects[32])+90)
	SetEntityHeading(homeObjects[33],GetEntityHeading(homeObjects[33])+90)
	SetEntityHeading(homeObjects[34],GetEntityHeading(homeObjects[34])+200)
	SetEntityHeading(homeObjects[37],GetEntityHeading(homeObjects[34])+100)
	SetEntityHeading(homeObjects[38],GetEntityHeading(homeObjects[38])+135)
	SetEntityHeading(homeObjects[39],GetEntityHeading(homeObjects[39])+10)
	SetEntityHeading(homeObjects[41],GetEntityHeading(homeObjects[41])+180)
	SetEntityHeading(homeObjects[42],GetEntityHeading(homeObjects[42])-90)
	SetEntityHeading(homeObjects[54],GetEntityHeading(homeObjects[54])+90)
	SetEntityHeading(homeObjects[73],GetEntityHeading(homeObjects[73])+180)
	SetEntityHeading(homeObjects[80],GetEntityHeading(homeObjects[80])+90)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEOBJECTHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function removeObjectHomes()
	if homeObjects ~= nil then
		for k,v in pairs(homeObjects) do
			SetEntityAsMissionEntity(homeObjects[k],false,false)
			DeleteEntity(homeObjects[k])
			homeObjects[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomesTheft(status)
	homesTheft = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
local theftHomesX = 0.0
local theftHomesY = 0.0
local theftPlayers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTLOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
local theftLocal = {
	["MOBILE01"] = { 3.26,-4.29,0.1 },
	["MOBILE02"] = { 1.27,-3.78,0.4 },
	["MOBILE03"] = { 1.35,-5.46,0.3 },
	["MOBILE04"] = { -1.95,-6.21,0.2 },
	["MOBILE05"] = { -3.56,-6.0,0.1 },
	["MOBILE06"] = { -4.67,0.85,-0.1 },
	["MOBILE07"] = { -2.14,1.22,-0.1 },
	["MOBILE08"] = { 2.59,1.66,0.5 },
	["MOBILE09"] = { 8.39,-1.86,0.0 },
	["MOBILE10"] = { 9.16,-1.43,-0.1 },
	["MOBILE11"] = { 6.38,2.64,0.0 },
	["MOBILE12"] = { 4.43,3.32,0.1 },
	["MOBILE13"] = { 8.48,3.93,0.4 },
	["LOCKER"] = { 7.16,-1.89,0.1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkHomesTheft()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesTheft) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1.5 and vSERVER.checkHomeTheft(k) then
			theftPlayers = {}
			theftHomesX = v[1]
			theftHomesY = v[2]
			return true,tostring(k)
		end
	end
	return false,nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERHOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enterHomesTheft(homeName)
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		theftOpen = true
		removeObjectHomes()
		DoScreenFadeOut(1000)
		houseOpen = tostring(homeName)
		vSERVER.setNetwork(tostring(homeName))
		vSERVER.applyHouseOpen(tostring(homeName))
		TriggerEvent("sounds:source","enterhouse",0.7)

		Citizen.Wait(1000)

		createMiddle(ped,theftHomesX,theftHomesY,1500.0)
		SetTimecycleModifier("AmbientPUSH")

		if math.random(100) >= 80 then
			if DoesEntityExist(theftLocker) then
				DeleteEntity(theftLocker)
				theftLocker = nil
			end

			local mHash = GetHashKey("prop_ld_int_safe_01")

			RequestModel(mHash)
			while not HasModelLoaded(mHash) do
				RequestModel(mHash)
				Citizen.Wait(10)
			end

			theftLocker = CreateObjectNoOffset(mHash,theftHomesX+7.17,theftHomesY-2.52,1501.8,false,false,false)
			SetEntityHeading(theftLocker,GetEntityHeading(homeObjects[41]))
			FreezeEntityPosition(theftLocker,true)
			SetModelAsNoLongerNeeded(mHash)
		else
			theftPlayers["LOCKER"] = true
		end

		Citizen.Wait(1000)

		SetEntityCoords(ped,theftHomesX+3.63,theftHomesY-15.43,1502.0)
		table.insert(internHouses,{ theftHomesX+3.63,theftHomesY-15.43,1502.3,"exit","SAIR" })

		TriggerEvent("homes:Hours",true)
		FreezeEntityPosition(ped,true)

		Citizen.Wait(3000)

		FreezeEntityPosition(ped,false)
		DoScreenFadeIn(1000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTERHOMETHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if theftOpen then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)
				for k,v in pairs(theftLocal) do
					if not theftPlayers[k] then
						local distance = #(coords - vector3(theftHomesX+v[1],theftHomesY+v[2],1502.0))
						if distance <= 1.5 then
							timeDistance = 1
							DrawText3Ds(theftHomesX+v[1],theftHomesY+v[2],1502.0+v[3],"~g~E~w~  VASCULHAR")
							if distance <= 0.8 and IsControlJustPressed(1,38) then
								TriggerEvent("cancelando",true)

								if k == "LOCKER" then
									local homeLocker = exports["safelocker"]:createSafe({ math.random(0,99),math.random(0,99) })
									if homeLocker then
										vSERVER.paymentTheft(k)
									end
									theftPlayers[k] = true
								else
									local taskBar = exports["taskbar"]:taskThree()
									if taskBar then
										vSERVER.paymentTheft(k)
										theftPlayers[k] = true
									end
								end

								TriggerEvent("cancelando",false)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and houseOpen ~= "" then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(internHouses) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 1
					DrawText3Ds(v[1],v[2],v[3],"~g~E~w~  "..v[5])

					if IsControlJustPressed(1,38) then
						if v[4] == "exit" then
							vSERVER.removeNetwork(tostring(houseOpen))
							TriggerEvent("sounds:source","outhouse",0.5)
							DoScreenFadeOut(1000)
							Citizen.Wait(1000)

							SetEntityCoords(ped,homesList[houseOpen][5],homesList[houseOpen][6],homesList[houseOpen][7]+0.1)
							TriggerEvent("homes:Hours",false)
							FreezeEntityPosition(ped,true)

							Citizen.Wait(3000)
							FreezeEntityPosition(ped,false)
							removeObjectHomes()
							DoScreenFadeIn(1000)
							ClearTimecycleModifier()
							vSERVER.removeHouseOpen()
							theftOpen = false
							internHouses = {}
							houseOpen = ""

							if DoesEntityExist(theftLocker) then
								DeleteEntity(theftLocker)
								theftLocker = nil
							end
						elseif v[4] == "vault" then
							if vSERVER.checkIntPermissions(tostring(houseOpen)) then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu" })
								TriggerEvent("sounds:source","chest",0.7)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end