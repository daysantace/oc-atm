-- config
serverAddress = -- server address
port = -- server port

-- get libs
require("event")
require("component")
require("term")
keypad = require("component").os_keypad
modem = component.proxy(component.modem.address)
data = component.proxy(component.data.address)

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

keyButton = {"1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "#"} 
keyButtonColours = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "13", "0", "14"}
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
    username=string.sub(cardsplicing,1,16)
    cardnum=string.sub(cardsplicing,17,40)
    cardFiller=string.sub(cardsplicing,41,120)
    checksum=string.sub(cardsplicing,121,128)

    -- 80 BYTE FILLER STRING SPLITTING + VERIFICATION HERE

    -- do not change variable cardFiller as it'll break the checksum

    -- verify card
    if not usernamecheck == username then
      print("VERIFY ERROR")
      print("Card holder name and machine user name do not match")
      sleep(3)
      goto labelVerify
    end
    checksumCheck = username .. cardnum .. cardFiller
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
    print("Welcome, " .. usernamecheck .. ".")
    print("Your balance is " .. userBal .. " diamonds.") -- change diamonds to preferred cutrency
    print("1 - Deposit")
    print("3 - Withdraw")

    -- get key input
    _, _, input, _ = event.pull("keypad")
end