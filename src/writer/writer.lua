-- config
port = -- port

-- import libs and get components
event = require("event")
component = require("component")
require("math")

writer = require("component").os_cardwriter
modem = component.proxy(component.modem.address)
data = component.proxy(component.data.address)

-- generate cardNum, readableName
math.randomseed(os.time())
cardNumA = math.random(100000000000,999999999999)
cardNumB = math.random(100000000000,999999999999)
cardNum = (cardNumA .. cardNumB)

print("Enter readable name")
readableName = io.read()

if not string.len(readableName) == 16 then
  for i, 16 - string.len(readableName)
    readableName = readableName .. " "
  
-- 80 BYTE FILLER CODE GOES HERE --

fillerDefault = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
-- default 80 byte filler, delete if using custom filler

-- 80 BYTE FILLER CODE GOES HERE --


filler = fillerDefault -- change fillerDefault to a concatination of filler variables

-- generate checksum
cardData = readableName .. cardNum .. filler
cardDataHashed = data.sha256(cardData)
checksum = string.sub(cardDataHashed,1,8)

-- write card and send to server
writer.write(cardData .. checksum,"Debit Card (" .. readableName ..")", true)
modem.broadcast(port,compCardData)
