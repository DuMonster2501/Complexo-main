-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local anims = {}
local players = {}
local showblips = {}
local anim_ids = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.teleport(x,y,z)
	SetEntityCoords(PlayerPedId(),x + 0.0001,y + 0.0001,z + 0.0001,1,0,0,0)
	vRPserver._updatePositions(x,y,z)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
	return x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:updateList")
AddEventHandler("vRP:updateList",function(status)
	players = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getPlayers()
	return players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:showIds")
AddEventHandler("vRP:showIds",function(status)
	showblips = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.nearestPlayers(vDistance)
	local r = {}
	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local coordsPed = GetEntityCoords(PlayerPedId())
			local distance = #(coords - coordsPed)
			if distance <= vDistance then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.nearestPlayersBlips()
	local r = {}
	for k,v in pairs(showblips) do
		local player = GetPlayerFromServerId(k)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local coordsPed = GetEntityCoords(PlayerPedId())
			local distance = #(coords - coordsPed)
			if distance <= 5 then
				r[GetPlayerServerId(player)] = { v,coords.x,coords.y,coords.z }
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.nearestPlayer(radius)
	local p = nil
	local players = tvRP.nearestPlayers(2)
	local min = radius + 0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARANIM
-----------------------------------------------------------------------------------------------------------------------------------------
local animActived = false
local animDict = nil
local animName = nil
local animFlags = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playAnim(upper,seq,looping)
	local ped = PlayerPedId()
	if seq.task then
		tvRP.stopAnim(true)
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local coords = GetEntityCoords(ped)
			TaskStartScenarioAtPosition(ped,seq.task,coords.x,coords.y,coords.z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		tvRP.stopAnim(upper)

		local flags = 0

		if upper then
			flags = flags + 48
		end

		if looping then
			flags = flags + 1
		end

		Citizen.CreateThread(function()
			RequestAnimDict(seq[1])
			while not HasAnimDictLoaded(seq[1]) do
				RequestAnimDict(seq[1])
				Citizen.Wait(10)
			end

			if HasAnimDictLoaded(seq[1]) then
				animDict = seq[1]
				animName = seq[2]
				animFlags = flags
				if flags == 49 then
					animActived = true
				end
				TaskPlayAnim(ped,seq[1],seq[2],3.0,3.0,-1,flags,0,0,0,0)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsEntityPlayingAnim(ped,animDict,animName,3) and animActived then
			TaskPlayAnim(ped,animDict,animName,3.0,3.0,-1,animFlags,0,0,0,0)
			timeDistance = 4
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
						   
		if animActived then
			timeDistance = 4
			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,16,true)
			DisableControlAction(1,17,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(upper)
	animActived = false
	if upper then
		ClearPedSecondaryTask(PlayerPedId())
	else
		ClearPedTasks(PlayerPedId())
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopActived()
	animActived = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Queue:playerActivated")
			return
		end
		Citizen.Wait(30000)
	end
end)