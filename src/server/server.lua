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
function getMsg(port){
    modem.open(port)
    local _, port .. "sender", _, _, bal = event.pull("modem_message")
    modem.close(port)
}

while True do
    getMsg(portPublic)
    if string.sub(modemMessage,1,6) == "req_bal" then
        -- balance request
        modem.send(portPrivate,dataAddress,"req_bal" .. string.sub(modemMessage,8,string.len(modemMessage)))
        getMsg(portPrivate)
        if portPrivate .. "sender" == dataAddress then
            modem.send(portPublic,sender,bal)
        end
    end

    if string.sub(modemMessage,1,4) == "with" then
        -- withdrawal
        modem.send(portPrivate,dataAddress,"deduct" .. string.sub(modemMessage,7,string.len(modemMessage)))
    end