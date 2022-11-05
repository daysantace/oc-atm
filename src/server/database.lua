-- config
local serverAddress = -- server address
local port = -- port

-- get libs
local event = require("event")
local component = require("component")
local term = require("term")
local modem = component.proxy(component.modem.address)
local data = component.proxy(component.data.address)

-- init
while True do
    modemMessage = nil
    modem.open(port)
    local _, reqAddress, _, _, modemMessage = event.pull("modem_message")
    modem.close(port)
    if not modemMessage == nil then
        if string.sub(modemMessage,1,7) == "req_bal" then
            balInfo = string.sub(modemMessage,8,string.len(modemMessage))
            