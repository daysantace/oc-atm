-- config
port = -- port for wireless networking, match it up with whatever the ATM is using
currency = "minecraft:diamond" -- ID of currency (by default diamonds)

-- import libs
require ("component")
require ("sides")
require ("os")

modem = component.proxy(component.modem.address)
inventory = component.inventory_controller

-- wait for input from ATM
while True do
  local portMessage, _, messageCmd = event.pull("modem_message")
  if portMessage == port then
    if messageCmd = "req_deposit" then
-- move back to chest
      move(2)
      move(2)
      currencyDep = 0
-- read items in hopper
      inventory.getStackInSlot(2,1)
