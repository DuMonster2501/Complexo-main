local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
cRP = Tunnel.getInterface("lscustoms")

local inside = false
local currentpos = nil
local currentgarage = 0

local garages = {
	[1] = { locked = false, drivein = { x = -1178.43, y = -2845.8, z = 13.6, heading = 149.91 }, outside = { x = -1178.43, y = -2845.8, z = 13.6, heading = 149.91 }, inside = { x = -1178.43, y = -2845.8, z = 13.6, heading = 149.91 }},
	[2] = { locked = false, drivein = { x = -221.48, y = -1330.06, z = 30.55, heading = 270.19 }, outside = { x = -221.48, y = -1330.06, z = 30.55, heading = 270.19 }, inside = { x = -221.48, y = -1330.06, z = 30.55, heading = 270.19 }},
	[3] = { locked = false, drivein = { x = -327.35, y = -137.75, z = 38.67, heading = 85.26 }, outside = { x = -327.35, y = -137.75, z = 38.67, heading = 85.26 }, inside = { x = -327.35, y = -137.75, z = 38.67, heading = 85.26 }},
	[4] = { locked = false, drivein = { x = 732.99, y = -1088.86, z = 21.82, heading = 89.63 }, outside = { x = 732.99, y = -1088.86, z = 21.82, heading = 89.63 }, inside = { x = 732.99, y = -1088.86, z = 21.82, heading = 89.63 }},
	[5] = { locked = false, drivein = { x = -1160.4, y = -2016.11, z = 12.84, heading = 339.95 }, outside = { x = -1160.4, y = -2016.11, z = 12.84, heading = 339.95 }, inside = { x = -1160.4, y = -2016.11, z = 12.84, heading = 339.95 }},
	[6] = { locked = false, drivein = { x = 1174.68, y = 2640.21, z = 37.42, heading = 359.89 }, outside = { x = 1174.68, y = 2640.21, z = 37.42, heading = 359.89 }, inside = { x = 1174.68, y = 2640.21, z = 37.42, heading = 359.89 }},
	[7] = { locked = false, drivein = { x = 110.9, y = 6626.94, z = 31.44, heading = 223.0 }, outside = { x = 110.9, y = 6626.94, z = 31.44, heading = 223.0 }, inside = { x = 110.9, y = 6626.94, z = 31.44, heading = 223.0 }},
	[8] = { locked = false, drivein = { x = -32.42, y = -1065.63, z = 28.08, heading = 161.97 }, outside = { x = -32.42, y = -1065.63, z = 28.08, heading = 161.97 }, inside = { x = -32.42, y = -1065.63, z = 28.08, heading = 161.97 } },
	[9] = { locked = false, drivein = { x = 834.88, y = -948.78, z = 26.54, heading = 89.63 }, outside = { x = 834.88, y = -948.78, z = 26.54, heading = 89.63 }, inside = { x = 834.88, y = -948.78, z = 26.54, heading = 89.63 }},
}

local Menu = SetMenu()
local myveh = {}

local function f(n)
	return (n+0.00001)
end

local function round(num,idp)
	if idp and idp > 0 then
		local mult = 10^idp
		return math.floor(num*mult+0.5)/mult
	end
	return math.floor(num+0.5)
end

local LSCMenu = Menu.new("Bennys","CATEGORIES",0.16,0.13,0.24,0.36,0,{255,255,255,255})
LSCMenu.config.pcontrol = false

local function AddMod(mod,parent,header,name,info,stock)
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	if (GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) > 0) or mod == 18 or mod == 22 then
		local m = parent:addSubMenu(header,name,info,true)
		if stock then
			local btn = m:addPurchase("Stock")
			btn.modtype = mod
			btn.mod = -1
			local price = 50000
		end
		if LSC_Config.prices.mods[mod].startprice then
			local price = LSC_Config.prices.mods[mod].startprice
			for i = 0, tonumber(GetNumVehicleMods(veh,mod)) -1 do
				local lbl = GetModTextLabel(veh,mod,i)
				if lbl ~= nil then
					local mname = tostring(GetLabelText(lbl))
					if mname ~= "NULL" then
						local btn = m:addPurchase(mname,price)
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					end
				end
			end
		else
			for n, v in pairs(LSC_Config.prices.mods[mod]) do
				btn = m:addPurchase(v.name,v.price)btn.modtype = mod
				btn.mod = v.mod
			end
		end
	end
end

local function DriveInGarage()
	TriggerServerEvent('lockGarage',true,currentgarage)
	SetPlayerControl(PlayerId(),false,256)

	local pos = currentpos
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	LSCMenu.buttons = {}

	if DoesEntityExist(veh) then
		LSCMenu:setTitle("Benny's Motorworks")
		LSCMenu.title_sprite = "shopui_title_supermod"

		LSCMenu.config.controls = LSC_Config.menu.controls
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back,0),"Voltar"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select,0),"Selecionar"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up,0),"Cima"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down,0),"Baixo"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left,0),"Esquerda"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right,0),"Direita"}
		},0)

		LSCMenu:setMaxButtons(LSC_Config.menu.maxbuttons)
		LSCMenu.config.size.width = f(LSC_Config.menu.width) or 0.24;
		LSCMenu.config.size.height = f(LSC_Config.menu.height) or 0.36;

		if type(LSC_Config.menu.position) == 'table' then
			LSCMenu.config.position = { x = LSC_Config.menu.position.x, y = LSC_Config.menu.position.y }
		elseif type(LSC_Config.menu.position) == 'string' then
			if LSC_Config.menu.position == "left" then
				LSCMenu.config.position = { x = 0.16, y = 0.13 }
			elseif  LSC_Config.menu.position == "right" then
				LSCMenu.config.position = { x = 1-0.16, y = 0.13 }
			end
		end

		if type(LSC_Config.menu.theme) == "table" then
			LSCMenu:setColors(LSC_Config.menu.theme.text_color,LSC_Config.menu.theme.stext_color,LSC_Config.menu.theme.bg_color,LSC_Config.menu.theme.sbg_color)
		elseif	type(LSC_Config.menu.theme) == "string" then
			if LSC_Config.menu.theme == "light" then
				LSCMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 155 },{ r = 255, g = 255, b = 255, a = 255 })
			elseif LSC_Config.menu.theme == "darkred" then
				LSCMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 155 },{ r = 200, g = 15, b = 15, a = 200 })
			elseif LSC_Config.menu.theme == "bluish" then	
				LSCMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 100 },{ r = 0, g = 100, b = 255, a = 200 })
			elseif LSC_Config.menu.theme == "greenish" then	
				LSCMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 100 },{ r = 0, g = 200, b = 0, a = 200 })
			end
		end

		LSCMenu:addSubMenu("CATEGORIES","categories",nil,false)
		LSCMenu.categories.buttons = {}
		LSCMenu:addPurchase("Reparar",500,nil)

		SetVehicleModKit(veh,0)
		myveh.vehicle = veh
		myveh.color =  table.pack(GetVehicleColours(veh))
		myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
		myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
		myveh.xenoncolor = GetVehicleXenonLightsColour(veh)
		myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
		myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
		myveh.mods = {}

		for i = 0,48 do
			myveh.mods[i] = { mod = nil }
		end

		for i,t in pairs(myveh.mods) do 
			if i == 22 or i == 18 then
				if IsToggleModOn(veh,i) then
					t.mod = 1
				else
					t.mod = 0
				end
			elseif i == 23 or i == 24 then
				t.mod = GetVehicleMod(veh,i)
				t.variation = GetVehicleModVariation(veh,i)
			else
				t.mod = GetVehicleMod(veh,i)
			end
		end

		if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
			myveh.windowtint = false
		else
			myveh.windowtint = GetVehicleWindowTint(veh)
		end

		if myveh.xenoncolor > 12 or myveh.xenoncolor < -1 then
			myveh.xenoncolor = -1
		end

		myveh.wheeltype = GetVehicleWheelType(veh)
		local chassis,interior,bumper,fbumper,rbumper = false,false,false,false
		
		for i = 0,48 do
			if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
				if i == 1 then
					bumper = true
					fbumper = true
				elseif i == 2 then
					bumper = true
					rbumper = true
				elseif (i >= 42 and i <= 46) or i == 5 then
					chassis = true
				elseif i >= 27 and i <= 37 then
					interior = true
				end
			end
		end

		AddMod(0,LSCMenu.categories,"SPOILER","Spoiler",nil,true)
		AddMod(3,LSCMenu.categories,"SKIRTS","Skirts",nil,true)
		AddMod(4,LSCMenu.categories,"EXHAUST","Exhausts",nil,true)
		AddMod(6,LSCMenu.categories,"GRILLE","Grille",nil,true)
		AddMod(7,LSCMenu.categories,"HOOD","Hood",nil,true)
		AddMod(8,LSCMenu.categories,"FENDERS","Fenders",nil,true)
		AddMod(10,LSCMenu.categories,"ROOF","Roof",nil,true)
		AddMod(12,LSCMenu.categories,"BRAKES","Brakes",nil,false)
		AddMod(13,LSCMenu.categories,"TRANSMISSION","Transmission",nil,false)
		AddMod(14,LSCMenu.categories,"HORN", "Horn",nil,true)
		AddMod(15,LSCMenu.categories,"SUSPENSION","Suspension",nil,false)
		AddMod(16,LSCMenu.categories,"ARMOR","Armor",nil,false)
		AddMod(18,LSCMenu.categories,"TURBO","Turbo",nil,false)

		if chassis then
			LSCMenu.categories:addSubMenu("CHASSIS","Chassis",nil,true)
			AddMod(42,LSCMenu.categories.Chassis,"ARCH COVER","Arch cover",nil,true)
			AddMod(43,LSCMenu.categories.Chassis,"AERIALS","Aerials",nil,true)
			AddMod(44,LSCMenu.categories.Chassis,"ROOF SCOOPS","Roof Scoops",nil,true)
			AddMod(45,LSCMenu.categories.Chassis,"Tank","Tank",nil,true)
			AddMod(46,LSCMenu.categories.Chassis,"DOORS","Doors",nil,true)
			AddMod(5,LSCMenu.categories.Chassis,"ROLL CAGE","Roll cage",nil,true)
		end

		LSCMenu.categories:addSubMenu("ENGINE","Engine",nil,true)
		AddMod(39,LSCMenu.categories.Engine,"ENGINE BLOCK","Engine Block",nil,true)
		AddMod(40,LSCMenu.categories.Engine,"CAM COVER","Cam Cover",nil,true)
		AddMod(41,LSCMenu.categories.Engine,"STRUT BRACE","Strut Brace",nil,true)
		AddMod(11,LSCMenu.categories.Engine,"ENGINE TUNES","Engine Tunes",nil,false)

		if interior then
			LSCMenu.categories:addSubMenu("INTERIOR","Interior",nil,true)
			AddMod(27,LSCMenu.categories.Interior,"TRIM DESIGN","Trim Design",nil,true)
			AddMod(28,LSCMenu.categories.Interior,"ORNAMENTS","Ornaments",nil,true)
			AddMod(29,LSCMenu.categories.Interior,"DASHBOARD","Dashboard",nil,true)
			AddMod(30,LSCMenu.categories.Interior,"DIAL DESIGN","Dials",nil,true)
			AddMod(31,LSCMenu.categories.Interior,"DOORS","Doors",nil,true)
			AddMod(32,LSCMenu.categories.Interior,"SEATS","Seats",nil,true)
			AddMod(33,LSCMenu.categories.Interior,"STEERING WHEELS","Steering Wheels",nil,true)
			AddMod(34,LSCMenu.categories.Interior,"Shifter leavers","Shifter leavers",nil,true)
			AddMod(35,LSCMenu.categories.Interior,"Plaques","Plaques",nil,true)
			AddMod(36,LSCMenu.categories.Interior,"Speakers","Speakers",nil,true)
			AddMod(37,LSCMenu.categories.Interior,"Trunk","Trunk",nil,true)
		end

		LSCMenu.categories:addSubMenu("PLATES","Plates",nil,true)
		LSCMenu.categories.Plates:addSubMenu("LICENSE","License",nil,true)
		for n,mod in pairs(LSC_Config.prices.plates) do
			local btn = LSCMenu.categories.Plates.License:addPurchase(mod.name,mod.price)btn.plateindex = mod.plateindex
		end

		AddMod(25,LSCMenu.categories.Plates,"Plate holder","Plate holder",nil,true)
		AddMod(26,LSCMenu.categories.Plates,"Vanity plates","Vanity plates",nil,true)
		AddMod(38,LSCMenu.categories,"HYDRAULICS","Hydraulics",nil,true)
		AddMod(48,LSCMenu.categories,"Liveries","Liveries",nil,true)

		if bumper then
			LSCMenu.categories:addSubMenu("BUMPERS","Bumpers",nil,true)
			if fbumper then
				AddMod(1,LSCMenu.categories.Bumpers,"FRONT BUMPERS","Front bumpers",nil,true)
			end
			if rbumper then
				AddMod(2,LSCMenu.categories.Bumpers,"REAR BUMPERS","Rear bumpers",nil,true)
			end
		end

		local m = LSCMenu.categories:addSubMenu("LIGHTS","Lights",nil,true)
		AddMod(22,LSCMenu.categories.Lights,"HEADLIGHTS","Headlights",nil,false)
		if not IsThisModelABike(GetEntityModel(veh)) then
			neon = m:addSubMenu("NEON KITS","Neon kits",nil,true)
			neon:addSubMenu("NEON LAYOUT","Neon layout",nil,true)
			local btn = neon["Neon layout"]:addPurchase("None")
			for n,mod in pairs(LSC_Config.prices.neonlayout) do
				btn = neon["Neon layout"]:addPurchase(mod.name,mod.price)
			end

			neon = neon:addSubMenu("NEON COLOR","Neon color",nil,true)
			for n,mod in pairs(LSC_Config.prices.neoncolor) do
				local btn = neon:addPurchase(mod.name,mod.price)
				btn.neon = mod.neon
			end

			m = m:addSubMenu("XENON COLOR","Xenon color",nil,true)
			local btn = m:addPurchase("Stock")
			btn.xenon = -1
			for n,mod in pairs(LSC_Config.prices.xenoncolor) do
				btn = m:addPurchase(mod.name,mod.price)
				btn.xenon = mod.xenon
			end
		end

		respray = LSCMenu.categories:addSubMenu("RESPRAY","Respray",nil,true)
		pcol = respray:addSubMenu("PRIMARY COLORS","Primary color",nil,true)
		pcol:addSubMenu("CHROME","Chrome",nil,true)
		for n,c in pairs(LSC_Config.prices.chrome.colors) do
			local btn = pcol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end

		pcol:addSubMenu("CLASSIC","Classic",nil,true)
		for n,c in pairs(LSC_Config.prices.classic.colors) do
			local btn = pcol.Classic:addPurchase(c.name,LSC_Config.prices.classic.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end

		pcol:addSubMenu("MATTE","Matte",nil,true)
		for n,c in pairs(LSC_Config.prices.matte.colors) do
			local btn = pcol.Matte:addPurchase(c.name,LSC_Config.prices.matte.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end

		pcol:addSubMenu("METALLIC","Metallic",nil,true)
		for n,c in pairs(LSC_Config.prices.metallic.colors) do
			local btn = pcol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
				btn.purchased = true
			end
		end

		pcol:addSubMenu("METALS","Metals",nil,true)
		for n,c in pairs(LSC_Config.prices.metal.colors) do
			local btn = pcol.Metals:addPurchase(c.name,LSC_Config.prices.metal.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end

		scol = respray:addSubMenu("SECONDARY COLORS","Secondary color",nil,true)
		scol:addSubMenu("CHROME","Chrome",nil,true)
		for n,c in pairs(LSC_Config.prices.chrome2.colors) do
			local btn = scol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome2.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end

		scol:addSubMenu("CLASSIC","Classic",nil,true)
		for n,c in pairs(LSC_Config.prices.classic2.colors) do
			local btn = scol.Classic:addPurchase(c.name,LSC_Config.prices.classic2.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end

		scol:addSubMenu("MATTE","Matte",nil,true)
		for n,c in pairs(LSC_Config.prices.chrome2.colors) do
			local btn = scol.Matte:addPurchase(c.name,LSC_Config.prices.matte2.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end

		scol:addSubMenu("METALLIC","Metallic",nil,true)
		for n,c in pairs(LSC_Config.prices.metallic2.colors) do
			local btn = scol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic2.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] and myveh.extracolor[1] == btn.colorindex then
				btn.purchased = true
			end
		end

		scol:addSubMenu("METALS","Metals",nil,true)
		for n,c in pairs(LSC_Config.prices.metal2.colors) do
			local btn = scol.Metals:addPurchase(c.name,LSC_Config.prices.metal2.price)
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end

		LSCMenu.categories:addSubMenu("WHEELS","Wheels",nil,true)
		wtype = LSCMenu.categories.Wheels:addSubMenu("WHEEL TYPE","Wheel type",nil,true)
		if IsThisModelABike(GetEntityModel(veh)) then
			fwheels = wtype:addSubMenu("FRONT WHEEL","Front wheel",nil,true)
			for n,w in pairs(LSC_Config.prices.frontwheel) do
				btn = fwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			bwheels = wtype:addSubMenu("BACK WHEEL","Back wheel",nil,true)
			for n,w in pairs(LSC_Config.prices.backwheel) do
				btn = bwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 24 btn.mod = w.mod
			end
		else
			sportw = wtype:addSubMenu("SPORT WHEELS","Sport",nil,true)
			for n,w in pairs(LSC_Config.prices.sportwheels) do
				local btn = sportw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			musclew = wtype:addSubMenu("MUSCLE WHEELS","Muscle",nil,true)
			for n,w in pairs(LSC_Config.prices.musclewheels) do
				local btn = musclew:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			lowriderw = wtype:addSubMenu("LOWRIDER WHEELS","Lowrider",nil,true)
			for n,w in pairs(LSC_Config.prices.lowriderwheels) do
				local btn = lowriderw:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			suvw = wtype:addSubMenu("SUV WHEELS","Suv",nil,true)
			for n,w in pairs(LSC_Config.prices.suvwheels) do
				local btn = suvw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			offroadw = wtype:addSubMenu("OFFROAD WHEELS","Offroad",nil,true)
			for n,w in pairs(LSC_Config.prices.offroadwheels) do
				local btn = offroadw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			tunerw = wtype:addSubMenu("TUNER WHEELS","Tuner",nil,true)
			for n,w in pairs(LSC_Config.prices.tunerwheels) do
				local btn = tunerw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			hughendw = wtype:addSubMenu("HIGHEND WHEELS","Highend",nil,true)
			for n,w in pairs(LSC_Config.prices.highendwheels) do
				local btn = hughendw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
			importw = wtype:addSubMenu("IMPORT WHEELS","Import",nil,true)
			for n,w in pairs(LSC_Config.prices.importwheels) do
				local btn = importw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
			end
		end

		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL COLOR","Wheel color",nil,true)
		for n,c in pairs(LSC_Config.prices.wheelcolor.colors) do
			local btn = m:addPurchase(c.name,LSC_Config.prices.wheelcolor.price)btn.colorindex = c.colorindex
		end
		
		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL ACCESSORIES","Wheel accessories",nil,true)
		for n,mod in pairs(LSC_Config.prices.wheelaccessories) do
			local btn = m:addPurchase(mod.name,mod.price)btn.smokecolor = mod.smokecolor
		end

		m = LSCMenu.categories:addSubMenu("WINDOWS","Windows",nil,true)
		btn = m:addPurchase("None") btn.tint = false
		for n,tint in pairs(LSC_Config.prices.windowtint) do
			btn = m:addPurchase(tint.name,tint.price)btn.tint = tint.tint
		end

		Citizen.CreateThread(function()
			SetEntityCoordsNoOffset(veh,pos.inside.x,pos.inside.y,pos.inside.z)
			SetEntityHeading(veh,pos.inside.heading)
			SetVehicleOnGroundProperly(veh)
			SetVehicleLights(veh,2)
			SetVehicleInteriorlight(veh,true)
			SetVehicleDoorsLocked(veh,4)
			SetPlayerInvincible(GetPlayerIndex(),true)
			SetEntityInvincible(veh,true)
			SetVehRadioStation(veh,255)

			Citizen.Wait(50)

			TaskVehicleDriveToCoordLongrange(ped,veh,pos.inside.x,pos.inside.y,pos.inside.z,7.0,16777216,1.0)
			Citizen.Wait(3000)

			local c = 0
			while not IsVehicleStopped(veh) do
				Citizen.Wait(10)
				c = c + 1
				if c > 5000 then
					ClearPedTasks(ped)
					break
				end
			end

			Citizen.Wait(100)

			if (GetVehicleBodyHealth(veh) <= 999 or GetVehicleEngineHealth(veh) <= 999) then
				LSCMenu:Open("main")
			else
				LSCMenu:Open("categories")
			end

			SetEntityInvincible(veh,true)
			FreezeEntityPosition(veh,true)

			SetPlayerControl(PlayerId(),true)
		end)
	end
end

local function DriveOutOfGarage(pos)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsUsing(ped)
		TriggerServerEvent("LSC:finished",myveh)
		FreezeEntityPosition(veh,false)
		SetVehicleDoorsLocked(veh,0)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,false)
		SetVehicleLights(veh,0)
		inside = false
		TriggerServerEvent('lockGarage',false,currentgarage)
		SetPlayerControl(PlayerId(),true)
		currentgarage = 0
	end)
end

local function tableContains(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if not inside then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				if DoesEntityExist(veh) and GetPedInVehicleSeat(veh,-1) == ped then
					local coords = GetEntityCoords(ped)

					for k,v in pairs(garages) do
						outside = v.inside
						local distance = #(coords - vector3(outside.x,outside.y,outside.z))
						if distance <= 15 then
							timeDistance = 4
							
							DrawMarker(23,outside["x"],outside["y"],outside["z"] - 0.55,0.0,0.0,0.0,0.0,0.0,0.0,5.0,5.0,0.0,42,137,255,100,0,0,0,0)
							
							if not v.locked then
								if distance <= 2.5 and IsControlJustPressed(1,38) then
									if cRP.checkPermission() then
										inside = true
										currentpos = v
										currentgarage = k
										DriveInGarage()
									end
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

function LSCMenu:OnMenuClose(m)
	DriveOutOfGarage(currentpos.outside)
end

function LSCMenu:onSelectedIndexChanged(name,button)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	p = m.parent or self.name
	if m == "main" then
		m = self
	end
	CheckPurchases(m)
	m = m.name:lower()
	p = p:lower()
	if m == "chrome" or m ==  "classic" or m ==  "matte" or m ==  "metals" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)	
		end
	elseif m == "metallic" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
			SetVehicleExtraColours(veh,myveh.color[2],myveh.extracolor[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)
			SetVehicleExtraColours(veh,button.colorindex,myveh.extracolor[2])				
		end
	elseif m == "wheel color" then
		SetVehicleExtraColours(veh,myveh.extracolor[1],button.colorindex)
	elseif button.modtype and button.mod then
		if button.modtype ~= 18 and button.modtype ~= 22 then
			if button.wtype then
				SetVehicleWheelType(veh,button.wtype)
			end
			SetVehicleMod(veh,button.modtype,button.mod)	
		elseif button.modtype == 22 then
			ToggleVehicleMod(veh,button.modtype,button.mod)
		elseif button.modtype == 18 then
		end
	elseif m == "license" then
		SetVehicleNumberPlateTextIndex(veh,button.plateindex)
	elseif m == "neon color" then
		if myveh.neon then
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif m == "xenon color" then
		if myveh.mods[22].mod == 1 then
			SetVehicleXenonLightsColour(veh,button.xenon)
		end
	elseif m == "windows" then
		SetVehicleWindowTint(veh,button.tint)
	else
	end
	if m == "horn" then
		OverrideVehHorn(veh,false,0)
		if IsHornActive(veh) or IsControlPressed(1,86) then
			StartVehicleHorn(veh,10000,"HELDDOWN",1)
		end
	end
end

function LSCMenu:OnMenuOpen(menu)

end

function LSCMenu:onButtonSelected(name,button)
	local m = LSCMenu.currentmenu
	if m == "main" then
		m = LSCMenu
	end
	local mname = m.name:lower()
	if mname == "neon color" then
		if not myveh.neon then
			return
		end
	elseif mname == "xenon color" then
		if myveh.mods[22].mod ~= 1 then
			return
		end
	end
	TriggerServerEvent("LSC:buttonSelected",name,button)
end

RegisterNetEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected",function(name,button,canpurchase)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	if m == "main" then
		m = LSCMenu
	end
	mname = m.name:lower()
	if mname == "chrome" or mname ==  "classic" or mname == "matte" or mname == "metals" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase) then
				myveh.color[1] = button.colorindex
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase) then
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "metallic" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
				myveh.color[1] = button.colorindex
				myveh.extracolor[1] = myveh.color[2]
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
				myveh.extracolor[1] = button.colorindex
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "liveries" or mname == "hydraulics" or mname == "horn" or mname == "tank" or mname == "ornaments" or  mname == "arch cover" or mname == "aerials" or mname == "roof scoops" or mname == "doors" or mname == "roll cage" or mname == "engine block" or mname == "cam cover" or mname == "strut brace" or mname == "trim design" or mname == "ormnametns" or mname == "dashboard" or mname == "dials" or mname == "seats" or mname == "steering wheels" or mname == "plate holder" or mname == "vanity plates" or mname == "shifter leavers" or mname == "plaques" or mname == "speakers" or mname == "trunk" or mname == "armor" or mname == "suspension" or mname == "transmission" or mname == "brakes" or mname == "engine tunes" or mname == "roof" or mname == "hood" or mname == "grille" or mname == "roll cage" or mname == "exhausts" or mname == "skirts" or mname == "rear bumpers" or mname == "front bumpers" or mname == "spoiler" then
		if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "fenders" then
		if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
			if button.name == "Stock" then
				myveh.mods[8].mod = button.mod
				myveh.mods[9].mod = button.mod
				SetVehicleMod(veh,9,button.mod)
				SetVehicleMod(veh,8,button.mod)
			else
				myveh.mods[button.modtype].mod = button.mod
				SetVehicleMod(veh,button.modtype,button.mod)
			end
		end
	elseif mname == "turbo" or mname == "headlights" then
		if button.name == "None" or button.name == "Stock Lights" or button.purchased or CanPurchase(price,canpurchase) then
			myveh.mods[button.modtype].mod = button.mod
			ToggleVehicleMod(veh,button.modtype,button.mod)
			if mname == "headlights" then
				myveh.xenoncolor = -1
			end
		end
	elseif mname == "neon layout" then
		if button.name == "None" then
			SetVehicleNeonLightEnabled(veh,0,false)
			SetVehicleNeonLightEnabled(veh,1,false)
			SetVehicleNeonLightEnabled(veh,2,false)
			SetVehicleNeonLightEnabled(veh,3,false)
			myveh.neoncolor[1] = 255
			myveh.neoncolor[2] = 255
			myveh.neoncolor[3] = 255
			myveh.neon = 0
		elseif button.purchased or CanPurchase(price,canpurchase) then
			if not myveh.neoncolor[1] then
				myveh.neoncolor[1] = 255
				myveh.neoncolor[2] = 255
				myveh.neoncolor[3] = 255
			end
			SetVehicleNeonLightEnabled(veh,0,true)
			SetVehicleNeonLightEnabled(veh,1,true)
			SetVehicleNeonLightEnabled(veh,2,true)
			SetVehicleNeonLightEnabled(veh,3,true)
			SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
			myveh.neon = 1
		end
	elseif mname == "neon color" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.neoncolor[1] = button.neon[1]
			myveh.neoncolor[2] = button.neon[2]
			myveh.neoncolor[3] = button.neon[3]
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif mname == "xenon color" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.xenoncolor = button.xenon
			SetVehicleXenonLightsColour(veh,button.xenon)
		end
	elseif mname == "windows" then
		if button.name == "None" or button.purchased or CanPurchase(price,canpurchase) then
			myveh.windowtint = button.tint
			SetVehicleWindowTint(veh, button.tint)
		end
	elseif mname == "sport" or mname == "muscle" or mname == "lowrider" or mname == "back wheel" or mname == "front wheel" or mname == "highend" or mname == "import" or mname == "suv" or mname == "offroad" or mname == "tuner" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.wheeltype = button.wtype
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleWheelType(veh,button.wtype)
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "wheel color" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.extracolor[2] = button.colorindex
			SetVehicleExtraColours(veh,myveh.extracolor[1],button.colorindex)
		end
	elseif mname == "wheel accessories" then
		if button.name == "Stock Tires" then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,false)
			myveh.mods[23].variation = false
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,false)
				myveh.mods[24].variation = false
			end
		elseif button.name == "Custom Tires" and (button.purchased or CanPurchase(price,canpurchase)) then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,true)
			myveh.mods[23].variation = true
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,true)
				myveh.mods[24].variation = true
			end
		elseif button.smokecolor ~= nil and (button.purchased or CanPurchase(price,canpurchase)) then
			SetVehicleModKit(veh,0)
			myveh.mods[20].mod = true
			ToggleVehicleMod(veh,20,true)
			myveh.smokecolor = button.smokecolor
			SetVehicleTyreSmokeColor(veh,button.smokecolor[1],button.smokecolor[2],button.smokecolor[3])
		end
	elseif mname == "license" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.plateindex = button.plateindex
			SetVehicleNumberPlateTextIndex(veh,button.plateindex)
		end
	elseif mname == "main" then
		if name == "reparar" then
			if CanPurchase(price,canpurchase) then
				local fuel = GetVehicleFuelLevel(myveh.vehicle)

				SetVehicleFixed(myveh.vehicle)
				SetVehicleDeformationFixed(myveh.vehicle)
				SetVehicleBodyHealth(myveh.vehicle,1000.0)
				SetVehicleEngineHealth(myveh.vehicle,1000.0)
				SetVehiclePetrolTankHealth(myveh.vehicle,1000.0)
				SetVehicleFuelLevel(myveh.vehicle,fuel)
				LSCMenu:ChangeMenu("categories")
			end
		end
	end
	CheckPurchases(m)
end)

function LSCMenu:OnMenuChange(last,current)
	UnfakeVeh()
	if last == "main" then
		last = self
	end
	if last.name == "categories" and current.name == "main" then
		LSCMenu:Close()
	end	
	c = current.name:lower()
	if c == "front bumpers" then
	elseif  c == "rear bumpers" then
	elseif c == "Engine Tunes" then
	elseif c == "exhausts" then
	elseif c == "hood" then
	elseif c == "headlights" then
	elseif c == "license" or c == "plate holder" then
	elseif c == "vanity plates" then
	elseif c == "roof" then
	elseif c == "fenders" then
	elseif c == "grille" then
	elseif c == "skirts" then
	elseif c == "spoiler" then
	elseif c == "back wheel" then
	elseif c == "front wheel" or c == "wheel accessories" or  c == "wheel color" or c == "sport" or c == "muscle" or c == "lowrider" or c == "highend" or c == "import" or c == "suv" or c == "offroad" or c == "tuner" then
	elseif c == "neon color" then
	elseif c == "shifter leavers" or c == "trim design" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="steering wheels" then
		SetFollowVehicleCamViewMode(4)
	elseif c == "doors" and last.name:lower() == "interior" then
		SetVehicleDoorOpen(myveh.vehicle,0,0,0)
		SetVehicleDoorOpen(myveh.vehicle,1,0,0)
	elseif c == "trunk" then
		SetVehicleDoorOpen(myveh.vehicle,5,0,0)
	elseif c == "speakers" or  c == "engine block" or c == "air filter" or c == "strut brace" or c == "cam cover" then
		SetVehicleDoorOpen(myveh.vehicle,5,0,0)
		SetVehicleDoorOpen(myveh.vehicle,4,0,0)
	else
		SetVehicleDoorShut(myveh.vehicle,0,0)
		SetVehicleDoorShut(myveh.vehicle,1,0)
		SetVehicleDoorShut(myveh.vehicle,4,0)
		SetVehicleDoorShut(myveh.vehicle,5,0)
		SetFollowVehicleCamViewMode(0)
	end
end

function CheckPurchases(m)
	name = m.name:lower()
	if name == "chrome" or name ==  "classic" or name ==  "matte" or name == "metals" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[1] or myveh.extracolor[1] ~= myveh.color[2]) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "metallic" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[2] or myveh.extracolor[1] ~= b.colorindex) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[2] and myveh.extracolor[1] == b.colorindex then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "armor" or name == "suspension" or name == "transmission" or name == "brakes" or name == "engine tunes" or name == "roof" or name == "fenders" or name == "hood" or name == "grille" or name == "roll cage" or name == "exhausts" or name == "skirts" or name == "rear bumpers" or name == "front bumpers" or name == "spoiler" then
		for i,b in pairs(m.buttons) do
			if b.mod == -1  then
				if myveh.mods[b.modtype].mod == -1 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			elseif b.mod == 0 or b.mod == false then
				if myveh.mods[b.modtype].mod == false or myveh.mods[b.modtype].mod == 0 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			else
				if myveh.mods[b.modtype].mod == b.mod then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			end
		end
	elseif name == "neon layout" then
		for i,b in pairs(m.buttons) do
			if b.name == "None" then
				if IsVehicleNeonLightEnabled(myveh.vehicle,0) == false and IsVehicleNeonLightEnabled(myveh.vehicle,1) == false and IsVehicleNeonLightEnabled(myveh.vehicle,2) == false and IsVehicleNeonLightEnabled(myveh.vehicle,3) == false then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			elseif b.name == "Front,Back and Sides" then
				if IsVehicleNeonLightEnabled(myveh.vehicle,0)  and IsVehicleNeonLightEnabled(myveh.vehicle,1)  and IsVehicleNeonLightEnabled(myveh.vehicle,2)  and IsVehicleNeonLightEnabled(myveh.vehicle,3)  then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			end		
		end
	elseif name == "neon color" then
		for i,b in pairs(m.buttons) do
			if b.neon[1] == myveh.neoncolor[1] and b.neon[2] == myveh.neoncolor[2] and b.neon[3] == myveh.neoncolor[3] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "xenon color" then
		for i,b in pairs(m.buttons) do
			if myveh.xenoncolor ~= nil then
				if b.xenon == myveh.xenoncolor then
					b.purchased = true
					b.sprite = "garage"
				else
					b.purchased = false
					b.sprite = nil
				end
			end
		end
	elseif name == "windows" then
		for i,b in pairs(m.buttons) do
			if myveh.windowtint == b.tint then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "sport" or name == "muscle" or name == "lowrider" or name == "back wheel" or name == "front wheel" or name == "highend" or name == "import" or name == "suv" or name == "offroad" or name == "tuner" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod and myveh.wheeltype == b.wtype then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel color" then
		for i,b in pairs(m.buttons) do
			if b.colorindex == myveh.extracolor[2] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel accessories" then
		for i,b in pairs(m.buttons) do
			if b.name == "Stock Tires" then
				if not GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Custom Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.smokecolor ~= nil then
				local col = table.pack(GetVehicleTyreSmokeColor(myveh.vehicle))
				if col[1] == b.smokecolor[1] and col[2] == b.smokecolor[2] and col[3] == b.smokecolor[3] then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			end
		end
	elseif name == "license" then
		for i,b in pairs(m.buttons) do
			if myveh.plateindex == b.plateindex then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "tank" or name == "ornaments" or name == "arch cover" or name == "aerials" or name == "roof scoops" or name == "doors" or name == "roll cage" or name == "engine block" or name == "cam cover" or name == "strut brace" or name == "trim design" or name == "ornametns" or name == "dashboard" or name == "dials" or name == "seats" or name == "steering wheels" or name == "plate holder" or name == "vanity plates" or name == "shifter leavers" or name == "plaques" or name == "speakers" or name == "trunk" or name == "headlights" or name == "turbo" or  name == "hydraulics" or name == "liveries" or name == "horn" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	end
end

function CanPurchase(price,canpurchase)
	if canpurchase then
		if LSCMenu.currentmenu == "main" then
			LSCMenu:showNotification("Reparando.")
		else
			LSCMenu:showNotification("Modificação aplicada.")
		end
		return true
	else
--	TriggerEvent("Notify","vermelho","Você não tem <b>$"..price.."</b> Dólares no banco.",5000)
		return false
	end
end

function UnfakeVeh()
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	SetVehicleWheelType(veh,myveh.wheeltype)
	for i,m in pairs(myveh.mods) do
		if i == 22 or i == 18 then
			ToggleVehicleMod(veh,i,m.mod)
		elseif i == 23 or i == 24 then
			SetVehicleMod(veh,i,m.mod,m.variation)
		else
			SetVehicleMod(veh,i,m.mod)
		end
	end
	SetVehicleColours(veh,myveh.color[1],myveh.color[2])
	SetVehicleExtraColours(veh,myveh.extracolor[1],myveh.extracolor[2])
	SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
	SetVehicleXenonLightsColour(veh,myveh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,myveh.plateindex)
	SetVehicleWindowTint(veh,myveh.windowtint)
end

RegisterNetEvent('lockGarage')
AddEventHandler('lockGarage',function(tbl)
	for i,garage in ipairs(tbl) do
		garages[i].locked = garage.locked
	end
end)

local Ibuttons = nil
function SetIbuttons(buttons,layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(10)
			end
		else
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(10)
			end
		end
		local sf = Ibuttons
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"CLEAR_ALL")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.03)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.01)
		PushScaleformMovieFunctionParameterFloat(0.95)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()

		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
		end

		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end

		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons,0.5,0.5,1.0,1.0,255,255,255,255)
	end
end