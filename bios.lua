local result, reason = ""
do
	local handle, chunk = component.proxy(component.list("internet")()) or error("ERROR - Internet card not detected").request("https://raw.githubusercontent.com/daysantace/oc-atm/master/src/startup/start.lua")
	while true do
		chunk = handle.read(math.huge)
		
		if chunk then
			result = result .. chunk
		else
			break
		end
	end
	handle.close()
end