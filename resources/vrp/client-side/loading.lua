local Ran = false
AddEventHandler("vRP:clientSpawned", function ()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)