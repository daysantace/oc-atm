-- components needed
local function getComponentAddress(name)
	return component.list(name)() or error("ERROR! Component " .. name .. " is missing")
end

local eepromAddress, modemAddress, gpuAddress, screenAddress, cpuAddress =
	getComponentAddress("eeprom"),
	getComponentAddress("modem"),
	getComponentAddress("gpu"),
	getComponentAddress("screen"),
	getComponentAddress("cpu")

-- bind gpu
component.invoke(gpuAddress, "bind", screenAddress")
local screenWidth, screenHeight = component.invoke(gpuAddress, "getResolution")