-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("rope",cnVRP)
vCLIENT = Tunnel.getInterface("rope")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.startCarry(target,animationLib,animationLib2,animation,animation2,distans,distans2,height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	local source = source
	vCLIENT.syncTarget(targetSrc,source,animationLib2,animation2,distans,distans2,height,length,spin,controlFlagTarget,animFlagTarget)
	vCLIENT.syncSource(source,animationLib,animation,length,controlFlagSrc,animFlagTarget)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.stopCarry(targetSrc)
	vCLIENT.stopCarry(targetSrc)
end