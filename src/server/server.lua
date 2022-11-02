-- configs
local portPublic = -- transmission to ATMs
local portPrivate = -- transmission to database
local dataAddress = -- database address

-- get libs
local event = require("event")
local component = require("component")
local term = require("term")
local modem = component.proxy(component.modem.address)
local data = component.proxy(component.data.address)

-- init
while True do
    modem.open(portPublic)
    local _, sender, _, _, modemMessage = event.pull("modem_message")
    if string.sub(modemMessage,1,6) == "req_bal" then
        -- balance request
        modem.send(portPrivate,dataAddress,"req_bal" .. string.sub(modemMessage,7,string.len(modemMessage)))
        modem.open(portPrivate)
        local _, dataAddressConfirm, _, _, bal = event.pull("modem_message")
        modem.close(portPrivate)
        if dataAddressConfirm == dataAddress then
            modem.send(portPublic,sender,bal)
        end
    end

    if string.sub(modemMessage,1,4) == "with" then
        -- withdrawal
        modem.send(portPrivate,dataAddress,"req_bal" .. string.sub(modemMessage,7,string.len(modemMessage)))
        modem.open(portPrivate)
        local _, dataAddressConfirm, _, _, bal = event.pull("modem_message")
        modem.close(portPrivate)
        if dataAddressConfirm == dataAddress then
            modem.send(portPublic,sender,bal)
        end
    end