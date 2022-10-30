-- init
local component = require("component")
local internet = require("internet")
local os = require("os")

if not component.isAvailable("internet") then
  print("The OC-ATM installer requires an internet card.")
  os.exit()
end

-- get input for what to install
print("OC-ATM Installer")
