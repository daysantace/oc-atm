-- config
port = -- port for wireless networking, match it up with whatever the ATM is using
currency = "minecraft:diamond" -- ID of currency (by default diamonds)
atmAddress = -- address of the atm

-- import libs
require ("component")
require ("sides")
require ("os")

modem = component.proxy(component.modem.address)
inventory = component.inventory_controller

-- wait for input from ATM
while true do
  ::strt::
  portMessage, _, messageCmd = event.pull("modem_message")
  if portMessage == port then
-- deposit
    if messageCmd = "req_deposit" then
  -- move back to chest
      move(2)
      move(2)
      currencyDep = 0
  -- read items in hopper and take
      for i=1, 5 then
        slotCheck = inventory.getStackInSlot(2,i)
        if slotCheck["name"] = currency then
          currencyDep + slotCheck["size"] = currencyDep
          suckFromSlot(2, i, slotCheck["size"])
        end
      end
  -- send message to ATM and deposit diamonds
      move(3)
      move(3)
      modem.send(atmAddress, port, tostring(currencyDep))
      for i=1, 5 then
        robot.select(i)
        currencyDep = robot.count(i)
        for j=1, 27 then
          slotCheck = inventory.getStackInSlot(3,i)
          if not slotCheck["size"] == slotCheck["maxsize"] then
            slotDep = slotCheck["maxsize"] - slotCheck["size"]
            dropIntoSlot(3,j,slotDep)
          end
        end
      end
    end

-- withdraw
    if string.sub(messageCmd,1,12) = "req_withdraw" then
      withAmt == tonumber(string.sub(messageCmd,13,string.len(messageCmd)))
      amtStore = 0
      -- check if enough currency in ATM
      for i=1, 5 then
        slotCheck = inventory.getStackInSlot(3,i)
        amtStore = amtStore .. slotCheck["size"]
      end
      
      if amtStore < withAmt then
        modem.send(atmAddress,port,"err_atmbal")
        goto strt
    
      else
        for i=1, 5 then
          if withAmt > 64 then
            withAmt = withAmt - 64
          end
          inventory.suckFromSlot(3, i, withAmt)
          move(2)
          move(2)
          inventory.dropIntoSlot(2,i,withAmt)
        end
      end
    end
  end
end