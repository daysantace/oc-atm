-- get libs
require("event")
require("component")
keypad = require("component").os_keypad
modem = component.proxy(component.modem.address)
data = component.proxy(component.data.address)

event.shouldInterrupt = function()
  return false
end

customButtons = {"1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "#"} 

while true do
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
    cardID=string.sub(cardsplicing,41,80)
    accID=string.sub(cardsplicing,81,120)
    checksum=string.sub(cardsplicing,128,128)
end
