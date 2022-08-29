<<<<<<< HEAD:bios.lua
local result, reason = ""
=======
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
>>>>>>> 927efbb70286e41fa9ddef4002583e38b3dc6661:src/bios.lua
