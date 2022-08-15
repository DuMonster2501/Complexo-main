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
Tunnel.bindInterface("doors",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {
	[1] = { ["x"] = -947.41, ["y"] = -2067.98, ["z"] = 9.51, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 2 },
	[2] = { ["x"] = -948.02, ["y"] = -2067.33, ["z"] = 9.51, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 1 },
	[3] = { ["x"] = -925.97, ["y"] = -2035.3, ["z"] = 9.41, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 4 },
	[4] = { ["x"] = -926.85, ["y"] = -2034.57, ["z"] = 9.41, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 3 },
	[5] = { ["x"] = -954.83, ["y"] = -2057.62, ["z"] = 9.41, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 6 },
	[6] = { ["x"] = -953.94, ["y"] = -2058.39, ["z"] = 9.41, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 5 },
	[7] = { ["x"] = -953.78, ["y"] = -2044.16, ["z"] = 9.51, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[8] = { ["x"] = -944.0, ["y"] = -2044.89, ["z"] = 9.41, ["hash"] = 855881614, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[9] = { ["x"] = -938.61, ["y"] = -2038.23, ["z"] = 9.41, ["hash"] = 855881614, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[10] = { ["x"] = -932.0, ["y"] = -2044.68, ["z"] = 9.41, ["hash"] = -806761221, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[11] = { ["x"] = -937.95, ["y"] = -2048.51, ["z"] = 6.1, ["hash"] = -806761221, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[12] = { ["x"] = -939.32, ["y"] = -2045.28, ["z"] = 6.1, ["hash"] = -806761221, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[13] = { ["x"] = -945.65, ["y"] = -2039.11, ["z"] = 6.1, ["hash"] = -806761221, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[14] = { ["x"] = -952.54, ["y"] = -2053.94, ["z"] = 9.41, ["hash"] = -806761221, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
    [15] = { ["x"] = -959.73, ["y"] = -2052.63, ["z"] = 9.41, ["hash"] = -1291439697, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[16] = { ["x"] = -955.87, ["y"] = -2049.02, ["z"] = 9.41, ["hash"] = -1291439697, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },	
	[17] = { ["x"] = -953.17, ["y"] = -2051.6, ["z"] = 9.41, ["hash"] = -1291439697, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },		
	[18] = { ["x"] = -913.15, ["y"] = -2030.45, ["z"] = 9.41, ["hash"] = 1307986194, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[19] = { ["x"] = 1846.049, ["y"] = 2604.733, ["z"] = 45.579, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
    [20] = { ["x"] = 1819.475, ["y"] = 2604.743, ["z"] = 45.577, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[21] = { ["x"] = 1845.33, ["y"] = 2585.99, ["z"] = 46.02, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[22] = { ["x"] = 1843.38, ["y"] = 2576.9, ["z"] = 46.02, ["hash"] = 2024969025, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[23] = { ["x"] = 1836.77, ["y"] = 2592.25, ["z"] = 46.02, ["hash"] = -684929024, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[24] = { ["x"] = 1831.46, ["y"] = 2594.1, ["z"] = 46.02, ["hash"] = -684929024, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[25] = { ["x"] = 1828.98, ["y"] = 2592.17, ["z"] = 46.02, ["hash"] = -684929024, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[26] = { ["x"] = 1818.98, ["y"] = 2594.29, ["z"] = 46.02, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[27] = { ["x"] = 1791.49, ["y"] = 2551.99, ["z"] = 45.68, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[28] = { ["x"] = 1776.21, ["y"] = 2552.03, ["z"] = 45.68, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[29] = { ["x"] = 1765.68, ["y"] = 2566.54, ["z"] = 45.73, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true }, 
	[30] = { ["x"] = 1771.95, ["y"] = 2570.48, ["z"] = 45.73, ["hash"] = 2074175368, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[31] = { ["x"] = 1754.35, ["y"] = 2501.39, ["z"] = 45.74, ["hash"] = 1373390714, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[32] = { ["x"] = 1759.42, ["y"] = 2493.05, ["z"] = 45.75, ["hash"] = 241550507, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[33] = { ["x"] = 1769.37, ["y"] = 2498.78, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[34] = { ["x"] = 1766.06, ["y"] = 2497.16, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[35] = { ["x"] = 1762.96, ["y"] = 2495.29, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[36] = { ["x"] = 1756.79, ["y"] = 2491.62, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[37] = { ["x"] = 1753.5, ["y"] = 2489.85, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[38] = { ["x"] = 1750.41, ["y"] = 2488.0, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[39] = { ["x"] = 1776.32, ["y"] = 2485.9, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[40] = { ["x"] = 1773.13, ["y"] = 2484.15, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[41] = { ["x"] = 1769.96, ["y"] = 2482.11, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[42] = { ["x"] = 1766.76, ["y"] = 2480.45, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[43] = { ["x"] = 1763.72, ["y"] = 2478.64, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[44] = { ["x"] = 1760.5, ["y"] = 2476.74, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[45] = { ["x"] = 1757.43, ["y"] = 2474.94, ["z"] = 45.75, ["hash"] = 913760512, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true }
}
----------------------------------------------------------------------------------------------------------------------------------------- 
-- DOORSSTATISTICS
----------------------------------------------------------------------------------------------------------------------------------------- 
function cRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("sound:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsStatistics")
AddEventHandler("doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)