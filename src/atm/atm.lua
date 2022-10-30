-- config
local serverAddress = -- server address
local robotAddress = -- robot address (for withdrawals and deposits)
local port = -- server port

-- get libs
local event = require("event")
local component = require("component")
local term = require("term")
local keypad = require("component").os_keypad
local modem = component.proxy(component.modem.address)
local data = component.proxy(component.data.address)

--init
modem.setWakeMessage("ATM-WAKE")

event.shouldInterrupt = function()
  return false
end

function sleep (a) 
  local sec = tonumber(os.clock() + a); 
  while (os.clock() < sec) do 
  end 
end

local keyButton = {"1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "#"} 
local keyButtonColours = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "13", "0", "14"}
keypad.setKey(keyButton,keyButtonColours)

while true do
    :: labelVerify ::
    term.clear()
    -- read card data
    print("Please insert your card.")
    function readCard(playerName, cardData)
      usernamecheck = playerName
      cardsplicing = cardData
    end
    event.listen("magData", readCard())
    event.pull("interrupted")
    event.ignore("magData", readCard())

    -- split string
    local username=string.sub(cardsplicing,1,16)
    local cardnum=string.sub(cardsplicing,17,40)
    local cardFiller=string.sub(cardsplicing,41,120)
    local checksum=string.sub(cardsplicing,121,128)

    -- 80 BYTE FILLER STRING SPLITTING + VERIFICATION HERE

    -- do not change variable cardFiller as it'll break the checksum

    -- verify card
    if not usernamecheck == username then
      print("VERIFY ERROR")
      print("Card holder name and machine user name do not match")
      sleep(3)
      goto labelVerify
    end
    local checksumCheck = username .. cardnum .. cardFiller
    if not string.sub(data.sha256(checksumCheck),1,8) == checksum then
      print("VERIFY ERROR")
      print("Checksum failed")
      sleep(3)
      goto labelVerify
    end

    -- get info from server
    :: labelATMGUI ::
    print("Loading...")
    modem.send(port,serverAddress,"req_bal")
    modem.open(port)
    _, _, _, _, _, userBal = event.pull("modem_message")
    modem.close()
    term.clear()

    -- ATM GUI
    print("Welcome, " .. username .. ".")
    print("Your balance is " .. userBal .. " diamonds.") -- change diamonds to preferred currency
    print("1 - Deposit")
    print("3 - Withdraw")

    -- get key input
    _, _, input, _ = event.pull("keypad")
    if input == "1" then
      -- deposit
      print("Please deposit into the hopper below.")
      modem.send(port,robotAddress,"req_deposit")
      modem.open(port)
      _, _, _, _, _, depAmt = event.pull("modem.message")
      modem.close()
      modem.send(port,serverAddress,"deposit " .. depAmt)
    end
  
    if input == "3" then
      -- withdraw
      print("Please enter the amount of money you would like to withdraw.")
      keypadInput == ""
      _, _, input, _ = event.pull("keypad")
      if input
      keypadInput == keypadInput .. input
      modem.send(port,robotAddress,"req_withdraw " .. input)

    end
end
