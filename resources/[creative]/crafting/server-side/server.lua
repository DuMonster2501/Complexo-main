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
Tunnel.bindInterface("crafting",cRP)
vCLIENT = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	["mafiaCrafting"] = {
		["perm"] = "Mafia",
		["list"] = {
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 500,
					["copper"] = 200
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 550,
					["copper"] = 200
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 150
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 150
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100
				}
			},
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100
				}
			}
		}
	},
	["ballasCrafting"] = {
		["perm"] = "Ballas",
		["list"] = {
			["dollars"] = {
				["amount"] = 50000,
				["destroy"] = true,
				["require"] = {
					["dollars2"] = 50000
				}
			}
		}
	},
	["vagosCrafting"] = {
		["perm"] = "Vagos",
		["list"] = {
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 500,
					["copper"] = 200
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 350,
					["copper"] = 185
				}
			},
			["WEAPON_SMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 375,
					["copper"] = 195
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 50
				}
			},
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 175,
					["copper"] = 50
				}
			},
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 100,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50,
					["copper"] = 30
				}
			},
			["WEAPON_MICROSMG_AMMO"] = {
				["amount"] = 100,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50,
					["copper"] = 30
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 100,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50,
					["copper"] = 30
				}
			},
			["WEAPON_PISTOL_MK2_AMMO"] = {
				["amount"] = 100,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 50,
					["copper"] = 30
				}
			},
			["WEAPON_ASSAULTRIFLE_AMMO"] = {
				["amount"] = 100,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 70
				}
			}
		}
	},
	["boateCrafting"] = {
		["perm"] = "Boate",
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["plastic"] = 10,
					["rubber"] = 10,
					["aluminum"] = 14,
					["copper"] = 8
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["plastic"] = 50,
					["aluminum"] = 150,
					["copper"] = 50
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 300,
					["glass"] = 30
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["glass"] = 30,
					["rubber"] = 6,
					["aluminum"] = 6,
					["copper"] = 6
				}
			},
			["rope"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 150,
					["plastic"] = 50,
					["glass"] = 20
				}
			}
		}
	},
	["generalCrafting"] = {
		["list"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 125
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 150
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 100
				}
			},
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 8,
					["copper"] = 4
				}
			},
			["WEAPON_FLASHLIGHT"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["plastic"] = 50,
					["glass"] = 20,
					["copper"] = 20
				}
			}
		}
	},
	["ilegalCrafting"] = {
		["list"] = {
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 500,
					["copper"] = 200,
					["blackcard"] = 1
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 550,
					["copper"] = 200,
					["blackcard"] = 1
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 150,
					["blackcard"] = 1
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 400,
					["copper"] = 150,
					["blackcard"] = 1
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100,
					["blackcard"] = 1
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100,
					["blackcard"] = 1
				}
			},
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100,
					["blackcard"] = 1
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 100,
					["bluecard"] = 1
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 300,
					["copper"] = 100,
					["bluecard"] = 1
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 240,
					["copper"] = 80,
					["bluecard"] = 1
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 100,
					["bluecard"] = 1
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 250,
					["copper"] = 150,
					["bluecard"] = 1
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 175,
					["copper"] = 100,
					["bluecard"] = 1
				}
			}
		}
	},
		["mecanicoCrafting"] = {
		["perm"] = "Mechanic",
		["list"] = {
			["tires"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 32
				}
			},
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 14,
					["aluminum"] = 6,
					["copper"] = 6
				}
			},
			["toolboxes1"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 120,
					["aluminum"] = 50,
					["copper"] = 50
				}
			}
		}
	},
	["fueltechCrafting"] = {
		["list"] = {
			["fueltech"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["cpuchip"] = 25
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 80,
					["aluminum"] = 60,
					["copper"] = 40
				}
			}
		}
	},
	["avalanchesCrafting"] = {
		["perm"] = "Avalanches",
		["list"] = {
			["hamburger"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["bread"] = 2,
					["alface"] = 1,
					["burguer"] = 1,
					["queijo"] = 1,
					["tomate"] = 1
				}
			},
			["water"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars"] = 250
				}
			},
			["soda"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars"] = 250
				}
			},
			["cola"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars"] = 250
				}
			}
		}
	},
	["lixeiroShop"] = {
		["list"] = {
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["elastic"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["battery"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["glass"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["glassbottle"] = 1
				}
			}
		}
	},
	["dressMaker"] = {
		["list"] = {
			["credential"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["dollars2"] = 250
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 5,
					["plastic"] = 4,
					["rubber"] = 4,
					["glass"] = 4,
					["copper"] = 5
				}
			},
			["backpack"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["fabric"] = 25
				}
			},
			["fabric"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["animalpelt"] = 4,
					["rubber"] = 5
				}
			}
		}
	},
	["foodMarket"] = {
		["list"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 6
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["banana"] = 9
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["orange"] = 9
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["passion"] = 9
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["strawberry"] = 9
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["tange"] = 9
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["water"] = 1,
					["grape"] = 9
				}
			}
		}
	},
	["mechanicCraft"] = {
		["perm"] = "Mechanic",
		["list"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 6
				}
			}
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if craftList[craftType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,craftList[craftType]["perm"]) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v.require) do
				table.insert(craftList,{ name = vRP.itemNameList(k), amount = v })
			end

			table.insert(inventoryShop,{ name = vRP.itemNameList(k), amount = parseInt(v.amount), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k), list = craftList })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				if vRP.getInventoryItemAmount(user_id,k) < parseInt(v*shopAmount) then
					return
				end
				Citizen.Wait(1)
			end

			for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
				vRP.removeInventoryItem(user_id,k,parseInt(v*shopAmount))
				Citizen.Wait(1)
			end

			if string.sub(shopItem,1,9) == "toolboxes" then
				local advAmount = 0

				repeat
					Citizen.Wait(1)
					advAmount = advAmount + 1
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)
					local number = 0

					repeat
						Citizen.Wait(1)
						number = number + 1
					until advDecode[tostring("toolboxes"..number)] == nil

					advDecode[tostring("toolboxes"..number)] = 10
					vRP.giveInventoryItem(user_id,tostring("toolboxes"..number),1,false)
					SaveResourceFile("logsystem","toolboxes.json",json.encode(advDecode),-1)
				until advAmount == shopAmount
			else
				vRP.giveInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]*shopAmount,false,slot)
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if craftList[shopType]["list"][shopItem]["destroy"] then
				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						if parseInt(v) <= 1 then
							vRP.giveInventoryItem(user_id,k,1)
						else
							vRP.giveInventoryItem(user_id,k,v/2)
						end
						Citizen.Wait(1)
					end
				end
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			vCLIENT.updateCrafting(source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		vCLIENT.updateCrafting(source,"requestCrafting")
	end
end)