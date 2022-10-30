-- init
local component = require("component")
local internet = require("internet")
local os = require("os")

if not component.isAvailable("internet") then
  print("The OC-ATM installer requires an internet card.")
  io.read()
  os.exit()
end

-- get input for what to install
print("OC-ATM Installer")
print("Please type the respective number to install file.")
print("1 - ATM")
print("2 - ATM Robot")
print("3 - Server")
print("4 - Till")
print("5 - Writer")
print("6 - Relay")

inp = io.read()

-- install ATM
pcall(internet.request, url, nil, {["user-agent"]="Wget/OpenComputers"})
