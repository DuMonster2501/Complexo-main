function vRP.createWeebHook(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({ content = message }),{ ['Content-Type'] = "application/json" })
	end
end