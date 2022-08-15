--[[ VERSÃO CONVERTIDA PARA VRPEX BY COMBO

O MAPA VOCÊ STARTA NA PASTA DE MAPAS, JÁ VEM COM UM BLIP DE TELEPORTE NA PORTA DO CASSINO
SLOTS IMAGE É SÓ PARA AUXILIAR NA ADICÃO DE NOVOS SLOTS NA CONFIG.LUA

MEXER APENAS EM:

Config.ItemName; -- ITEM QUE SERÁ USADO NAS APOSTAS
Config.Mult;  -- MULTIPLICADOR DO ITEM PARA VITÓRIAS
Config.Slots['bet'] -- APENAS A LINHA BET, QUE É BASICAMENTE O VALOR DO ITEM PARA APOSTAR NA MÁQUINA ]]



Config = {}

Config.ItemName = 'chips' -- ITEM QUE SERÁ APOSTADO E MULTIPLICADO

Config.PrintClient = false -- Print on client's console the spins in case of object bug
Config.Offset = true -- Add 30% propability to stop the spins in wrong position

Config.HideUI = true
Config.HideUIEvent = 'hud:toggleui'
Config.ShowUIEvent = 'hud:toggleui'

Config.Mult = { -- Multipliers based on GTA:ONLINE
	['1'] = 250,	
	['2'] = 500,
	['3'] = 1000,
	['4'] = 1500,
	['5'] = 2000,
	['6'] = 2500,
	['7'] = 3000,
}

Config.Slots = {
	[1] = { -- Diamonds
		pos = vector3(1116.33,228.27,-49.2),		-- Slot's position
		bet = 1,								-- Hou much chips will take for each spin
		prop = 'vw_prop_casino_slot_07a',			-- The name of the spin object
		prop1 = 'vw_prop_casino_slot_07a_reels',	-- The name of the reel inside the slot
		prop2 = 'vw_prop_casino_slot_07b_reels',	-- The name of the blur reel inside the slot
	},
	[2] = { -- Diamonds
		pos = vector3(1113.47,239.01,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[3] = { -- Diamonds
		pos = vector3(1107.63,233.41,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[4] = { -- Diamonds
		pos = vector3(1102.03,232.5,-49.25),
		bet = 1,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	
	
	
	
	[5] = { -- Fortune And Glory
		pos = vector3(977.83, 67.94, 74.74),
		bet = 1,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[6] = { -- Fortune And Glory
		pos = vector3(979.33, 68.53, 74.74),
		bet = 1,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[7] = { -- Fortune And Glory
		pos = vector3(980.00, 67.07, 74.74),
		bet = 1,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[8] = { -- Fortune And Glory
		pos = vector3(978.60, 66.48, 74.74),
		bet = 1,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	
	
	
	[9] = { -- Have A Stab
		pos = vector3(1101.46,230.67,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[10] = { -- Have A Stab
		pos = vector3(1103.67,230.51,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[11] = { -- Have A Stab
		pos = vector3(1109.88,234.89,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[12] = { -- Have A Stab
		pos = vector3(1112.76,234.79,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[13] = { -- Have A Stab
		pos = vector3(1111.93,238.19,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[14] = { -- Have A Stab
		pos = vector3(1118.52,229.93,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[15] = { -- Have A Stab
		pos = vector3(1121.12,229.95,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	
	
	
	
	[16] = { -- Shoot First
		pos = vector3(1114.85,233.1,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[17] = { -- Shoot First
		pos = vector3(1120.23,231.62,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[18] = { -- Shoot First
		pos = vector3(1110.05,238.06,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[19] = { -- Shoot First
		pos = vector3(1105.88,228.84,-49.2),
		bet = 1,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	
	
	
	[20] = { -- Fame or Shame
		pos = vector3(1108.65,236.8,-49.84),
		bet = 1,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[21] = { -- Fame or Shame
		pos = vector3(1103.77,228.33,-49.84),
		bet = 1,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[22] = { -- Fame or Shame
		pos = vector3(1101.22,229.22,-49.84),
		bet = 1,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[23] = { -- Fame or Shame
		pos = vector3(1112.99,232.42,-49.84),
		bet = 1,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	
}




Config.Wins = { -- DO NOT TOUCH IT
	[1] = '2',
	[2] = '3',
	[3] = '6',
	[4] = '2',
	[5] = '4',
	[6] = '1',
	[7] = '6',
	[8] = '5',
	[9] = '2',
	[10] = '1',
	[11] = '3',
	[12] = '6',
	[13] = '7',
	[14] = '1',
	[15] = '4',
	[16] = '5',
}