-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["radio"] = {
		index = "radio",
		name = "Rádio",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 1.10
	},
	["chips"] = {
		index = "chips",
		name = "Ficha",
		desc = "",
		tipo = "Aposta",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.00
	},
	["radiodamaged"] = {
        index = "radiodamaged",
        name = "Rádio Queimado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
        type = "use",
        weight = 1.10
    },
	["vest"] = {
		index = "vest",
		name = "Colete",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "825",
		type = "use",
		weight = 2.45
	},
	["bandage"] = {
		index = "bandage",
		name = "Bandagem",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "225",
		type = "use",
		weight = 0.10
	},
	["warfarin"] = {
		index = "medkit",
		name = "Kit Médico",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "525",
		type = "use",
		weight = 0.45
	},
	["adrenaline"] = {
		index = "adrenaline",
		name = "Adrenalina",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 0.35
	},
	["credential"] = {
		index = "credential",
		name = "Credencial",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "325",
		type = "use",
		weight = 0.10
	},
	["pouch"] = {
		index = "pouch",
		name = "Malote",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.75
	},
	["woodlog"] = {
		index = "woodlog",
		name = "Tora de Madeira",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.75
	},
	["fishingrod"] = {
		index = "fishingrod",
		name = "Vara de Pescar",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "725",
		type = "use",
		weight = 2.75
	},
	["octopus"] = {
		index = "octopus",
		name = "Polvo",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18",
		type = "use",
		weight = 0.75
	},
	["shrimp"] = {
		index = "shrimp",
		name = "Camarão",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["carp"] = {
		index = "carp",
		name = "Carpa",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "16",
		type = "use",
		weight = 0.50
	},
	["codfish"] = {
		index = "codfish",
		name = "Bacalhau",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "16",
		type = "use",
		weight = 0.50
	},
	["catfish"] = {
		index = "catfish",
		name = "Bagre",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["goldenfish"] = {
		index = "goldenfish",
		name = "Dourado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.25
	},
	["horsefish"] = {
		index = "horsefish",
		name = "Cavala",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "18",
		type = "use",
		weight = 0.50
	},
	["tilapia"] = {
		index = "tilapia",
		name = "Tilápia",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "14",
		type = "use",
		weight = 0.25
	},
	["pacu"] = {
		index = "pacu",
		name = "Pacu",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "28",
		type = "use",
		weight = 0.50
	},
	["pirarucu"] = {
		index = "pirarucu",
		name = "Pirarucu",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "26",
		type = "use",
		weight = 0.25
	},
	["tambaqui"] = {
		index = "tambaqui",
		name = "Tambaqui",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "32",
		type = "use",
		weight = 0.75
	},
	["bait"] = {
		index = "bait",
		name = "Isca",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "4",
		type = "use",
		weight = 0.25
	},
	["meatA"] = {
		index = "meat",
		name = "Carne Animal",
		desc = "Corte nobre de classe A.",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.75
	},
	["meatB"] = {
		index = "meat2",
		name = "Carne Animal",
		desc = "Corte nobre de classe B.",
		tipo = "Comum",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.75
	},
	["meatC"] = {
		index = "meat3",
		name = "Carne Animal",
		desc = "Corte nobre de classe C.",
		tipo = "Comum",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.75
	},
	["meatS"] = {
		index = "meat4",
		name = "Carne Animal",
		desc = "Corte nobre de classe S.",
		tipo = "Comum",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["animalpelt"] = {
		index = "animalpelt",
		name = "Pele Animal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.10
	},
	["cannabisseed"] = {
		index = "cannabisseed",
		name = "Semente de Maconha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["bucket"] = {
		index = "bucket",
		name = "Balde",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["compost"] = {
		index = "compost",
		name = "Adubo",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["weed"] = {
		index = "weed",
		name = "Maconha",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["joint"] = {
		index = "joint",
		name = "Baseado",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["lean"] = {
		index = "lean",
		name = "Lean",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["ecstasy"] = {
		index = "ecstasy",
		name = "Ecstasy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["cocaine"] = {
		index = "cocaine",
		name = "Cocaína",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["meth"] = {
		index = "meth",
		name = "Metanfetamina",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "40",
		type = "use",
		weight = 0.50
	},
	["methliquid"] = {
		index = "methliquid",
		name = "Meta Líquida",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["silk"] = {
		index = "silk",
		name = "Seda",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["backpack"] = {
		index = "backpack",
		name = "Mochila",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "2225",
		type = "use",
		weight = 4.25
	},
	["premium01"] = {
		index = "premium01",
		name = "Premium 3 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "22500",
		type = "use",
		weight = 0.00
	},
	["premium02"] = {
		index = "premium02",
		name = "Premium 7 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "45000",
		type = "use",
		weight = 0.00
	},
	["premium03"] = {
		index = "premium03",
		name = "Premium 15 Dias",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "67500",
		type = "use",
		weight = 0.00
	},
	["premium04"] = {
		index = "premium04",
		name = "Premium 1 Mês",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "90000",
		type = "use",
		weight = 0.00
	},
	["namechange"] = {
		index = "namechange",
		name = "Troca de nome",
		desc = "Troca o nome do personagem.",
		tipo = "Usável",
		unity = "Não",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["newchars"] = {
		index = "newchars",
		name = "+1 Personagem",
		desc = "Limite de personagem em +1.",
		tipo = "Usável",
		unity = "Não",
		economy = "150000",
		type = "use",
		weight = 0.00
	},
	["newgarage"] = {
		index = "newgarage",
		name = "+1 Garagem",
		desc = "Limite de garagem em +1.",
		tipo = "Usável",
		unity = "Não",
		economy = "75000",
		type = "use",
		weight = 0.00
	},
	["premiumplate"] = {
		index = "platepremium",
		name = "Placa Premium",
		desc = "Troca a placa de registro do veículo.",
		tipo = "Usável",
		unity = "Não",
		economy = "45000",
		type = "use",
		weight = 0.50
	},
	-- PAREI AQUI
	["energetic"] = {
		index = "energetic",
		name = "Energético",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "315",
		type = "use",
		weight = 0.25
	},
	["delivery"] = { -- remover
		index = "delivery",
		name = "Caixa cheia",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["paperbag"] = { -- remover
		index = "paperbag",
		name = "Saco de Papel",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["battery"] = {
		index = "battery",
		name = "Pilhas",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["elastic"] = {
		index = "elastic",
		name = "Elástico",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "48",
		type = "use",
		weight = 0.10
	},
	["plasticbottle"] = {
		index = "plasticbottle",
		name = "Garrafa Plástica",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "48",
		type = "use",
		weight = 0.20
	},
	["glassbottle"] = {
		index = "glassbottle",
		name = "Garrafa de Vidro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "42",
		type = "use",
		weight = 0.50
	},
	["metalcan"] = {
		index = "metalcan",
		name = "Lata de Metal",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "60",
		type = "use",
		weight = 0.20
	},
	["alface"] = {
		index = "alface",
		name = "Alface",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
	["bacon"] = {
		index = "bacon",
		name = "Bacon",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
	["burguer"] = {
		index = "burguer",
		name = "Hamburguer",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.20
	},
	["milk"] = {
		index = "milk",
		name = "Leite",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.75
	},
	["onion"] = {
		index = "onion",
		name = "Cebola",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.20
	},
	["ovos"] = {
		index = "ovos",
		name = "Ovos",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["presunto"] = {
		index = "presunto",
		name = "Presunto",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
	["queijo"] = {
		index = "queijo",
		name = "Queijo",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.10
	},
	["tomate"] = {
		index = "tomate",
		name = "Tomate",
		desc = "Usado para fazer Hamburguer",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.25
	},
	["emptybottle"] = {
		index = "emptybottle",
		name = "Garrafa Vazia",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "650",
		type = "use",
		weight = 0.10
	},
	["water"] = {
		index = "water",
		name = "Água",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "850",
		type = "use",
		weight = 0.15
	},
	["dirtywater"] = {
		index = "dirtywater",
		name = "Água Suja",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "450",
		type = "use",
		weight = 0.15
	},
	["cellbattery"] = {
		index = "cellbattery",
		name = "Bateria de celular",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "35",
		type = "use",
		weight = 0.75
	},
	["cellphone"] = {
		index = "cellphone",
		name = "Celular",
		desc = "Celular funcionando",
		tipo = "Usável",
		unity = "Sim",
		economy = "575",
		type = "use",
		subtype = "comida",
		transform = "nbcellphone",
		durability = 100800,
		weight = 0.75
	},
	["coptablet"] = {
		index = "coptablet",
		name = "Tablet Policial",
		desc = "Tablet Policial funcionando",
		tipo = "Usável",
		unity = "Sim",
		economy = "575",
		type = "use",
		subtype = "comida",
		durability = 1000800,
		weight = 0.75
	},
	["tablet"] = {
		index = "tablet",
		name = "Tablet",
		desc = "Tablet funcionando",
		tipo = "Usável",
		unity = "Sim",
		economy = "575",
		type = "use",
		subtype = "comida",
		durability = 1000800,
		weight = 0.75
	},
	["nbcellphone"] = {
        index = "nbcellphone",
        name = "Celular",
		desc = "Celular sem bateria",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
        type = "use",
        weight = 0.75
    },
	["cellphonedamaged"] = {
        index = "cellphonedamaged",
        name = "Celular Queimado",
		desc = "Celular totalmente queimado",
		tipo = "Eletrônico",
		unity = "Não",
		economy = "S/E",
        type = "use",
        weight = 0.85
    },
-- SUBTYPE COMIDA
-- subtype = "comida",
-- transform = "comida-estragada",
-- durability = 1500,
    ["cola"] = {
		index = "cola",
		name = "Cola",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "515",
		type = "use",
		subtype = "comida",
		transform = "badcola",
		durability = 1500,
		weight = 0.15
	},
	["badcola"] = {
		index = "badcola",
		name = "Cola vencida",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 0.15
	},
    ["soda"] = {
		index = "soda",
		name = "Sprunk",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "515",
		type = "use",
		subtype = "comida",
		transform = "badsoda",
		durability = 1500,
		weight = 0.15
	},
	["badsoda"] = {
		index = "badsoda",
		name = "Sprunk vencida",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 0.15
	},
	["coffee"] = {
		index = "coffee",
		name = "Café",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "320",
		type = "use",
		subtype = "comida",
		transform = "badcoffee",
		durability = 1500,
		weight = 0.15
	},
	["badcoffee"] = {
		index = "badcoffee",
		name = "Café vencido",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "160",
		type = "use",
		weight = 0.15
	},
	["hamburger"] = {
		index = "hamburger",
		name = "Hambúrguer",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "900",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 1500,
		weight = 0.35
	},
	["badhamburger"] = {
		index = "badhamburger",
		name = "Hambúrguer vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "800",
		type = "use",
		weight = 0.35
	},
	["hotdog"] = {
		index = "hotdog",
		name = "Cachorro-Quente",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "900",
		type = "use",
		subtype = "comida",
		transform = "badhotdog",
		durability = 900,
		weight = 0.35
	},
	["badhotdog"] = {
		index = "badhotdog",
		name = "Cachorro-Quente vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "450",
		type = "use",
		weight = 0.35
	},
	["sandwich"] = {
		index = "sandwich",
		name = "Sanduiche",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "875",
		type = "use",
		subtype = "comida",
		transform = "badhamburger",
		durability = 1500,
		weight = 0.25
	},
	["badsandwich"] = {
		index = "badsandwich",
		name = "Sanduiche vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "650",
		type = "use",
		weight = 0.25
	},
	["chocolate"] = {
		index = "chocolate",
		name = "Chocolate",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "315",
		type = "use",
		subtype = "comida",
		transform = "badchocolate",
		durability = 1500,
		weight = 0.10
	},
	["badchocolate"] = {
		index = "badchocolate",
		name = "Chocolate vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "150",
		type = "use",
		weight = 0.10
	},
	["donut"] = {
		index = "donut",
		name = "Donut",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "",
		type = "use",
		subtype = "comida",
		transform = "baddonut",
		durability = 1500,
		weight = 0.20
	},
	["baddonut"] = {
		index = "baddonut",
		name = "Donut vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "",
		type = "use",
		weight = 0.20
	},
	["tacos"] = {
		index = "tacos",
		name = "Tacos",
		desc = "",
		tipo = "Usável",
		unity = "Sim",
		economy = "745",
		type = "use",
		subtype = "comida",
		transform = "badtacos",
		durability = 1500,
		weight = 0.25
	},
	["badtacos"] = {
		index = "badtacos",
		name = "Tacos vencido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "350",
		type = "use",
		weight = 0.25
	},
-- END SUBTYPE COMIDA
	["bread"] = {
		index = "bread",
		name = "Pão",
		desc = "Usado para fazer Hambúrguer",
		tipo = "Usável",
		unity = "Não",
		economy = "87",
		type = "use",
		weight = 0.25
	},
	["plate"] = {
		index = "plate",
		name = "Placa",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.50
	},
	["lockpick"] = {
		index = "lockpick",
		name = "Lockpick",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "400",
		type = "use",
		weight = 1.25
	},
	["lockpick2"] = {
		index = "lockpick2",
		name = "Lockpick Quebrado",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "65",
		type = "use",
		weight = 1.25
	},
	["toolbox"] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		desc = "",
		tipo = "Ferramentas",
		unity = "Não",
		economy = "500",
		type = "use",
		weight = 1.75
	},
	["notepad"] = {
		index = "notepad",
		name = "Bloco de Notas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["tires"] = {
		index = "tires",
		name = "Pneus",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "250",
		type = "use",
		weight = 1.50
	},
	["divingsuit"] = {
		index = "divingsuit",
		name = "Roupa de Mergulho",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "975",
		type = "use",
		weight = 4.75
	},
	["ametista"] = {
		index = "ametista",
		name = "Ametista",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "",
		type = "use",
		weight = 0.50
	},
	["diamante"] = {
		index = "diamante",
		name = "Diamante",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "26",
		type = "use",
		weight = 0.50
	},
	["esmeralda"] = {
		index = "esmeralda",
		name = "Esmeralda",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "30",
		type = "use",
		weight = 0.50
	},
	["rubi"] = {
		index = "rubi",
		name = "Rubi",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "22",
		type = "use",
		weight = 0.50
	},
	["safira"] = {
		index = "safira",
		name = "Safira",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["turquesa"] = {
		index = "turquesa",
		name = "Turquesa",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["ambar"] = {
		index = "ambar",
		name = "Âmbar",
		desc = "",
		tipo = "Minério",
		unity = "Não",
		economy = "20",
		type = "use",
		weight = 0.50
	},
	["gemstone"] = {
		index = "gemstone",
		name = "Gemstone",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "1500",
		type = "use",
		weight = 0.10
	},
	["handcuff"] = {
		index = "handcuff",
		name = "Algemas",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["rope"] = {
		index = "rope",
		name = "Cordas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "875",
		type = "use",
		weight = 1.50
	},
	["hood"] = {
		index = "hood",
		name = "Capuz",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.00
	},
	["pilhas"] = {
		index = "pilhas",
		name = "Pilhas",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.25
	},
	["key"] = {
		index = "key",
		name = "Chaves",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "45",
		type = "use",
		weight = 0.25
	},
	["fabric"] = {
		index = "fabric",
		name = "Tecido",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.050
	},
	["plastic"] = {
		index = "plastic",
		name = "Plástico",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "7",
		type = "use",
		weight = 0.07
	},
	["glass"] = {
		index = "glass",
		name = "Vidro",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "7",
		type = "use",
		weight = 0.07
	},
	["rubber"] = {
		index = "rubber",
		name = "Borracha",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "7",
		type = "use",
		weight = 0.05
	},
	["aluminum"] = {
		index = "aluminum",
		name = "Alúminio",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.07
	},
	["copper"] = {
		index = "copper",
		name = "Cobre",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "10",
		type = "use",
		weight = 0.07
	},
	["eletronics"] = {
		index = "eletronics",
		name = "Eletrônico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.80
	},
	["notebook"] = {
		index = "notebook",
		name = "Notebook",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.00
	},
	["keyboard"] = {
		index = "keyboard",
		name = "Teclado",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["mouse"] = {
		index = "mouse",
		name = "Mouse",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["ring"] = {
		index = "ring",
		name = "Anel",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.60
	},
	["watch"] = {
		index = "watch",
		name = "Relógio",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.20
	},
	["c4"] = {
		index = "c4",
		name = "C4",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 2.50
	},
	["ritmoneury"] = {
		index = "ritmoneury",
		name = "Ritmoneury",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "475",
		type = "use",
		weight = 0.25
	},
	["sinkalmy"] = {
		index = "sinkalmy",
		name = "Sinkalmy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "325",
		type = "use",
		weight = 0.25
	},
	["cigarette"] = {
		index = "cigarette",
		name = "Cigarro",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.05
	},
	["lighter"] = {
		index = "lighter",
		name = "Isqueiro",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "175",
		type = "use",
		weight = 0.25
	},
	["vape"] = {
		index = "vape",
		name = "Vape",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "4750",
		type = "use",
		weight = 0.75
	},
	["jornal"] = {
		index = "jornal",
		name = "Jornal",
		desc = "",
		tipo = "Material",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.38
	},
	["dollars"] = {
		index = "dollars",
		name = "Dólares",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.0001
	},
	["dollars2"] = {
		index = "dollarsz",
		name = "Dólares Marcados",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.0001
	},
	["card01"] = {
		index = "card01",
		name = "Cartão Classic",
		desc = "Hackear Lojas de Departamento.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card02"] = {
		index = "card02",
		name = "Cartão Gold",
		desc = "Hackear Lojas de Armas.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card03"] = {
		index = "card03",
		name = "Cartão Platinum",
		desc = "Hackear Bancos Fleeca.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card04"] = {
		index = "card04",
		name = "Cartão Standard",
		desc = "Hackear Barbearias.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["card05"] = {
		index = "card05",
		name = "Cartão Black",
		desc = "Hackear Bancos.",
		tipo = "Usável",
		unity = "",
		economy = "",
		type = "use",
		weight = 0.10
	},
	["hardness"] = {
		index = "hardness",
		name = "Cinto Reforçado",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "50000",
		type = "use",
		weight = 5.00
	},
	["rose"] = {
		index = "rose",
		name = "Rosa",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "25",
		type = "use",
		weight = 0.15
	},
	["teddy"] = {
		index = "teddy",
		name = "Teddy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "75",
		type = "use",
		weight = 0.75
	},
	["absolut"] = {
		index = "absolut",
		name = "Absolut",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["chandon"] = {
		index = "chandon",
		name = "Chandon",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.35
	},
	["dewars"] = {
		index = "dewars",
		name = "Dewars",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["hennessy"] = {
		index = "hennessy",
		name = "Hennessy",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "215",
		type = "use",
		weight = 0.25
	},
	["identity"] = {
		index = "identity",
		name = "Identidade",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["goldbar"] = {
		index = "goldbar",
		name = "Barra de Ouro",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "875",
		type = "use",
		weight = 0.25
	},
	["binoculars"] = {
		index = "binoculars",
		name = "Binóculos",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 0.75
	},
	["camera"] = {
		index = "camera",
		name = "Câmera",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "275",
		type = "use",
		weight = 2.25
	},
	["playstation"] = {
		index = "playstation",
		name = "Playstation",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.00
	},
	["xbox"] = {
		index = "xbox",
		name = "Xbox",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.00
	},
	["legos"] = {
		index = "legos",
		name = "Legos",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["ominitrix"] = {
		index = "ominitrix",
		name = "Ominitrix",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 2.50
	},
	["bracelet"] = {
		index = "bracelet",
		name = "Bracelete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["dildo"] = {
		index = "dildo",
		name = "Vibrador",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["WEAPON_KNIFE"] = {
		index = "knife",
		name = "Faca",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_HATCHET"] = {
		index = "hatchet",
		name = "Machado",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BAT"] = {
		index = "bat",
		name = "Bastão de Beisebol",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BATTLEAXE"] = {
		index = "battleaxe",
		name = "Machado de Batalha",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_BOTTLE"] = {
		index = "bottle",
		name = "Garrafa",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.50
	},
	["WEAPON_CROWBAR"] = {
		index = "crowbar",
		name = "Pé de Cabra",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_DAGGER"] = {
		index = "dagger",
		name = "Adaga",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.50
	},
	["WEAPON_GOLFCLUB"] = {
		index = "golfclub",
		name = "Taco de Golf",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_HAMMER"] = {
		index = "hammer",
		name = "Martelo",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_MACHETE"] = {
		index = "machete",
		name = "Facão",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_POOLCUE"] = {
		index = "poolcue",
		name = "Taco de Sinuca",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_STONE_HATCHET"] = {
		index = "stonehatchet",
		name = "Machado de Pedra",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_SWITCHBLADE"] = {
		index = "switchblade",
		name = "Canivete",
		desc = "Utilizada para remoção de carne.",
		tipo = "Usável",
		unity = "Não",
		economy = "525",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_WRENCH"] = {
		index = "wrench",
		name = "Chave Inglesa",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_KNUCKLE"] = {
		index = "knuckle",
		name = "Soco Inglês",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "975",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_FLASHLIGHT"] = {
		index = "flashlight",
		name = "Lanterna",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "675",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_NIGHTSTICK"] = {
		index = "nightstick",
		name = "Cassetete",
		desc = "",
		tipo = "Armamento",
		unity = "Não",
		economy = "725",
		type = "equip",
		weight = 0.75
	},
	["WEAPON_PETROLCAN"] = {
		index = "gallon",
		name = "Galão",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PETROLCAN_AMMO",
		weight = 2.50
	},
	["GADGET_PARACHUTE"] = {
		index = "parachute",
		name = "Paraquedas",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "500",
		type = "equip",
		weight = 2.25
	},
	["WEAPON_STUNGUN"] = {
		index = "stungun",
		name = "Tazer",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 2.00
	},
	["WEAPON_FIREEXTINGUISHER"] = {
		index = "extinguisher",
		name = "Extintor",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	
 -- START PISTOLS
    ["WEAPON_PISTOL"] = {
	    index = "m1911",
		name = "M1911",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL_AMMO",
		weight = 2.00
    },
	["WEAPON_PISTOL_MK2"] = {
		index = "fiveseven",
		name = "FN Five Seven",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_APPISTOL"] = {
	    index = "kochvp9",
	    name = "Koch Vp9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_APPISTOL_AMMO",
		weight = 2.00
	},
    ["WEAPON_HEAVYPISTOL"] = {
		index = "atifx45",
		name = "Ati FX45",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_HEAVYPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL"] = {
		index = "amt380",
		name = "AMT 380",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		index = "hkp7m10",
		name = "HK P7M10",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SNSPISTOL_MK2_AMMO",
		weight = 2.00
	},
	["WEAPON_VINTAGEPISTOL"] = {
		index = "m1922",
		name = "M1922",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_VINTAGEPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL50"] = {
		index = "desert",
		name = "Desert Eagle",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PISTOL50_AMMO",
		weight = 2.00
	},
	["WEAPON_REVOLVER"] = {
		index = "magnum",
		name = "Magnum 44",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_REVOLVER_AMMO",
		weight = 2.00
	},
	["WEAPON_COMBATPISTOL"] = {
		index = "glock",
		name = "Glock",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_COMBATPISTOL_AMMO",
		weight = 2.00
	},
	["WEAPON_PISTOL_AMMO"] = {
		index = "m1911ammo",
		name = "M. M1911",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL_MK2_AMMO"] = {
		index = "fivesevenammo",
		name = "M. Five Seven",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_APPISTOL_AMMO"] = {
		index = "kochvp9ammo",
		name = "M. Koch Vp9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_HEAVYPISTOL_AMMO"] = {
		index = "atifx45ammo",
		name = "M. Ati FX45",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_AMMO"] = {
		index = "amt380ammo",
		name = "M. AMT 380",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SNSPISTOL_MK2_AMMO"] = {
		index = "hkp7m10ammo",
		name = "M. HK P7M10",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_VINTAGEPISTOL_AMMO"] = {
		index = "m1922ammo",
		name = "M. M1922",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_PISTOL50_AMMO"] = {
		index = "desertammo",
		name = "M. Desert Eagle",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_REVOLVER_AMMO"] = {
		index = "magnumammo",
		name = "M. Magnum 44",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_COMBATPISTOL_AMMO"] = {
		index = "glockammo",
		name = "M. Glock",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END PISTOLS

 -- START SMG
    ["WEAPON_COMPACTRIFLE"] = {
		index = "akcompact",
		name = "AK Compact",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_COMPACTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_MICROSMG"] = {
		index = "uzi",
		name = "Uzi",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MICROSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_MINISMG"] = {
		index = "skorpionv61",
		name = "Skorpion V61",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MINISMG_AMMO",
		weight = 3.00
	},
	["WEAPON_SMG"] = {
		index = "mp5",
		name = "MP5",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SMG_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTSMG"] = {
		index = "mtar21",
		name = "MTAR-21",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTSMG_AMMO",
		weight = 3.00
	},
	["WEAPON_GUSENBERG"] = {
		index = "thompson",
		name = "Thompson",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_GUSENBERG_AMMO",
		weight = 3.00
	},
	["WEAPON_MACHINEPISTOL"] = {
		index = "tec9",
		name = "Tec-9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MACHINEPISTOL_AMMO",
		weight = 3.00
	},
	["WEAPON_COMPACTRIFLE_AMMO"] = {
		index = "akcompactammo",
		name = "M. AK Compact",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MICROSMG_AMMO"] = {
		index = "uziammo",
		name = "M. Uzi",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MINISMG_AMMO"] = {
		index = "skorpionv61ammo",
		name = "M. Skorpion V61",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SMG_AMMO"] = {
		index = "mp5ammo",
		name = "M. MP5",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTSMG_AMMO"] = {
		index = "mtar21ammo",
		name = "M. MTAR-21",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_GUSENBERG_AMMO"] = {
		index = "thompsonammo",
		name = "M. Thompson",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_MACHINEPISTOL_AMMO"] = {
		index = "tec9ammo",
		name = "M. Tec-9",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END SMG

 -- START RIFLE
    ["WEAPON_CARBINERIFLE"] = {
		index = "m4a1",
		name = "M4A1",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE"] = {
		index = "ak103",
		name = "AK-103",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_AMMO",
		weight = 3.00
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		index = "ak74",
		name = "AK-74",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_ASSAULTRIFLE_MK2_AMMO",
		weight = 3.00
	},
	["WEAPON_CARBINERIFLE_AMMO"] = {
		index = "m4a1ammo",
		name = "M. M4A1",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_AMMO"] = {
		index = "ak103ammo",
		name = "M. AK-103",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_ASSAULTRIFLE_MK2_AMMO"] = {
		index = "ak74ammo",
		name = "M. AK-74",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END RIFLE

 -- START SHOTGUN
	["WEAPON_PUMPSHOTGUN"] = {
		index = "remington",
		name = "Remington",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_PUMPSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		index = "mossberg590",
		name = "Mossberg 590",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_SAWNOFFSHOTGUN_AMMO",
		weight = 3.00
	},
	["WEAPON_PUMPSHOTGUN_AMMO"] = {
		index = "remingtonammo",
		name = "M. Remington",
		desc = "",
		tipo = "Munição",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_SAWNOFFSHOTGUN_AMMO"] = {
		index = "mossberg590ammo",
		name = "M. Mossberg 590",
		desc = "",
		tipo = "Munição",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
 -- END SHOTGUN

 -- START OTHERS
	["WEAPON_PETROLCAN_AMMO"] = {
		index = "fuel",
		name = "Combustível",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.10
	},
	["WEAPON_RAYPISTOL"] = {
		index = "raypistol",
		name = "Pistola de Raios",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 1.00
	},
	["WEAPON_RPG"] = {
		index = "rpg",
		name = "RPG-7",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		weight = 3.00
	},
	["WEAPON_RPG_AMMO"] = {
		index = "rpgammo",
		name = "M. RPG-7",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.50
	},
	["WEAPON_MUSKET"] = {
		index = "winchester",
		name = "Winchester 1892",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "equip",
		ammo = "WEAPON_MUSKET_AMMO",
		weight = 3.00
	},
	["WEAPON_MUSKET_AMMO"] = {
		index = "musketammo",
		name = "Munição de Mosquete",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "recharge",
		weight = 0.50
	},
 -- END OTHERS

	["pager"] = {
		index = "pager",
		name = "Pager",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 1.50
	},
	["firecracker"] = {
		index = "firecracker",
		name = "Fogos de Artificio",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "100",
		type = "use",
		weight = 2.25
	},
	["analgesic"] = {
		index = "analgesic",
		name = "Analgésico",
		desc = "",
		tipo = "Remédio",
		unity = "Não",
		economy = "105",
		type = "use",
		weight = 0.10
	},
	["gauze"] = {
		index = "gauze",
		name = "Gazes",
		desc = "",
		tipo = "Curativo",
		unity = "Não",
		economy = "175",
		type = "use",
		weight = 0.07
	},
	["gsrkit"] = {
		index = "gsrkit",
		name = "Kit Residual",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["gdtkit"] = {
		index = "gdtkit",
		name = "Kit Químico",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 6.50
	},
	["fueltech"] = {
		index = "fueltech",
		name = "Fueltech",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 3.50
	},
	["cpuchip"] = {
		index = "cpuchip",
		name = "Processador",
		desc = "",
		tipo = "",
		unity = "",
		economy = "",
		type = "use",
		weight = 5.50
	},
	["orange"] = {
		index = "orange",
		name = "Laranja",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.25
	},
	["strawberry"] = {
		index = "strawberry",
		name = "Morango",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["grape"] = {
		index = "grape",
		name = "Uva",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["tange"] = {
		index = "tange",
		name = "Tangerina",
		type = "use",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		weight = 0.25
	},
	["banana"] = {
		index = "banana",
		name = "Banana",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.25
	},
	["passion"] = {
		index = "passion",
		name = "Maracujá",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.25
	},
	["tomato"] = {
		index = "tomato",
		name = "Tomate",
		desc = "",
		tipo = "Usável",
		unity = "Não",
		economy = "S/E",
		type = "use",
		weight = 0.15
	},
	["ketchup"] = {
		index = "ketchup",
		name = "Ketchup",
		desc = "",
		tipo = "Comum",
		unity = "Não",
		economy = "15",
		type = "use",
		weight = 0.25
	},
	["orangejuice"] = {
		index = "orangejuice",
		name = "Suco de Laranja",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.75
	},
	["tangejuice"] = {
		index = "tangejuice",
		name = "Suco de Tangerina",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["grapejuice"] = {
		index = "grapejuice",
		name = "Suco de Uva",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["strawberryjuice"] = {
		index = "strawberryjuice",
		name = "Suco de Morango",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["bananajuice"] = {
		index = "bananajuice",
		name = "Suco de Banana",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "85",
		type = "use",
		weight = 0.45
	},
	["passionjuice"] = {
		index = "passionjuice",
		name = "Suco de Maracujá",
		desc = "Mata sede e cura estresse",
		tipo = "Usável",
		unity = "Não",
		economy = "90",
		type = "use",
		weight = 0.45
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE:ADVTOOLBOX
-----------------------------------------------------------------------------------------------------------------------------------------
for i = 1,99 do
	itemlist["toolboxes"..i] = {
		index = "toolbox",
		name = "Caixa de Ferramentas",
		desc = "",
		tipo = "Ferramentas",
		unity = "Não",
		economy = "500",
		type = "use",
		weight = 1.75
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemBodyList(item)
	if itemlist[item] then
		return itemlist[item]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemIndexList(item)
	if itemlist[item] then
		return itemlist[item].index
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAMELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemNameList(item)
	if itemlist[item] then
		return itemlist[item].name
	end
	return "REMOVIDO"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDescList(item)
    if itemlist[item] then
        return itemlist[item].desc or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTIPOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTipoList(item)
    if itemlist[item] then
        return itemlist[item].tipo or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMUNITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemUnityList(item)
    if itemlist[item] then
        return itemlist[item].unity or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemEconomyList(item)
    if itemlist[item] then
        return itemlist[item].economy or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSUBTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemSubTypeList(item)
    if itemlist[item] then
        return itemlist[item].subtype or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTRANSFORMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTransformList(item)
    if itemlist[item] then
        return itemlist[item].transform or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemDurabilityList(item)
    if itemlist[item] then
        return itemlist[item].durability or nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTypeList(item)
	if itemlist[item] then
		return itemlist[item].type
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemAmmoList(item)
	if itemlist[item] then
		return itemlist[item].ammo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemWeightList(item)
	if itemlist[item] then
		return itemlist[item].weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTEINVWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeInvWeight(user_id)
	local weight = 0
	local inventory = vRP.getInventory(user_id)
	if inventory then
		for k,v in pairs(inventory) do
			if vRP.itemBodyList(v.item) then
				weight = weight + vRP.itemWeightList(v.item) * parseInt(v.amount)
			end
		end
		return weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTECHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeChestWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		if vRP.itemBodyList(k) then
			weight = weight + vRP.itemWeightList(k) * parseInt(v.amount)
		end
	end
	return weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname then
				return parseInt(v.amount)
			end
		end
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.swapSlot(user_id,slot,target)
	local data = vRP.getInventory(user_id)
	if data then
		local temp = data[tostring(slot)]
		data[tostring(slot)] = data[tostring(target)]
		data[tostring(target)] = temp
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemDurability(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname and v.timestamp then
				return v.timestamp
			end
		end
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
	function vRP.giveInventoryItem(user_id,idname,amount,notify,slot,timestamp)
		local data = vRP.getInventory(user_id)
		if data and parseInt(amount) > 0 then
			if not slot then
				local initial = 0
				repeat
					initial = initial + 1
				until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
				initial = tostring(initial)
				

				if vRP.itemSubTypeList(idname) then
					if vRP.getInventoryItemAmount(user_id,idname) > 0 then
						return false
					else
						if data[initial] == nil then
							if timestamp then
								data[initial] = { item = idname, amount = parseInt(1), timestamp = timestamp }
							else
								data[initial] = { item = idname, amount = parseInt(1), timestamp = (os.time() + vRP.itemDurabilityList(idname)) }
							end
							
						elseif data[initial] and data[initial].item == idname then
							return false
						end
		
						if notify and vRP.itemBodyList(idname) then
							TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
						end
						return true
					end
				else
					if data[initial] == nil then
						data[initial] = { item = idname, amount = parseInt(amount) }
					elseif data[initial] and data[initial].item == idname then
						data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			else
				slot = tostring(slot)

				if vRP.itemSubTypeList(idname) then
					if data[slot] then
						return false
					else
						if timestamp then
							data[slot] = { item = idname, amount = parseInt(1), timestamp = timestamp }
						else
							data[slot] = { item = idname, amount = parseInt(1), timestamp = (os.time() + vRP.itemDurabilityList(idname)) }
						end
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(1)),vRP.itemNameList(idname) })
					end
					return true
				else
					if data[slot] then
						if data[slot].item == idname then
							local oldAmount = parseInt(data[slot].amount)
							data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
						end
					else
						data[slot] = { item = idname, amount = parseInt(amount) }
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "+",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			end
		end
	end

	-- function vRP.giveInventoryItem(user_id,idname,amount,notify,slot)
	-- 	local data = vRP.getInventory(user_id)
	-- 	if data and parseInt(amount) > 0 then
	-- 		if not slot then
	-- 			local initial = 0
	-- 			repeat
	-- 				initial = initial + 1
	-- 			until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
	-- 			initial = tostring(initial)
				
	-- 			if data[initial] == nil then
	-- 				data[initial] = { item = idname, amount = parseInt(amount) }
	-- 			elseif data[initial] and data[initial].item == idname then
	-- 				data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
	-- 			end

	-- 			if notify and vRP.itemBodyList(idname) then
	-- 				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
	-- 			end
	-- 		else
	-- 			slot = tostring(slot)

	-- 			if data[slot] then
	-- 				if data[slot].item == idname then
	-- 					local oldAmount = parseInt(data[slot].amount)
	-- 					data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
	-- 				end
	-- 			else
	-- 				data[slot] = { item = idname, amount = parseInt(amount) }
	-- 			end

	-- 			if notify and vRP.itemBodyList(idname) then
	-- 				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
	-- 			end
	-- 		end
	-- 	end
	-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYGETINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryGetInventoryItem(user_id,idname,amount,notify,slot)
	local data = vRP.getInventory(user_id)
	if data then
		if not slot then
			for k,v in pairs(data) do
				if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
					v.amount = parseInt(v.amount) - parseInt(amount)

					if parseInt(v.amount) <= 0 then
						data[k] = nil
					end

					if notify and vRP.itemBodyList(idname) then
						TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
					end
					return true
				end
			end
		else
			local slot  = tostring(slot)

			if data[slot] and data[slot].item == idname and parseInt(data[slot].amount) >= parseInt(amount) then
				data[slot].amount = parseInt(data[slot].amount) - parseInt(amount)

				if parseInt(data[slot].amount) <= 0 then
					data[slot] = nil
				end

				if notify and vRP.itemBodyList(idname) then
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
				end
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removeInventoryItem(user_id,idname,amount,notify)
	local data = vRP.getInventory(user_id)
	if data then
		for k,v in pairs(data) do
			if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
				v.amount = parseInt(v.amount) - parseInt(amount)

				if parseInt(v.amount) <= 0 then
					data[k] = nil
				end

				if notify and vRP.itemBodyList(idname) then
					TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "-",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
				end

				break
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.createDurability(itemName)
	local advFile = LoadResourceFile("logsystem","toolboxes.json")
	local advDecode = json.decode(advFile)

	if advDecode[itemName] then
		advDecode[itemName] = advDecode[itemName] - 1

		if advDecode[itemName] <= 0 then
			advDecode[itemName] = nil
			vRP.removeInventoryItem(user_id,itemName,1,true)
		end
	else
		advDecode[itemName] = 9
	end

	SaveResourceFile("logsystem","toolboxes.json",json.encode(advDecode),-1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		if actived then
			slyphe = 100 
			for k,v in pairs(actived) do
				if actived[k] > 0 then
					actived[k] = v - 1
					if actived[k] <= 0 then
						actived[k] = nil
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
local policeLogs = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryChestItem(user_id,chestData,itemName,amount,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					activedAmount[user_id] = parseInt(items[itemName].amount)
				end

				local new_weight = vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getBackpack(user_id) then
					vRP.giveInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot)

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if chestData == "chest:Police" then
						vRP.createWeebHook(policeLogs,"```PASSAPORTE: "..user_id.." ( RETIROU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					end

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local slot = tostring(slot)
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				local inv = vRP.getInventory(user_id)
				if inv[slot] then
					activedAmount[user_id] = parseInt(inv[slot].amount)
				end
			end

			local new_weight = vRP.computeChestWeight(items) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
			if new_weight <= chestWeight then
				if vRP.tryGetInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					if chestData == "chest:Police" then
						vRP.createWeebHook(policeLogs,"```PASSAPORTE: "..user_id.." ( GUARDOU )\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end