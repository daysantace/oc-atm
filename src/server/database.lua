-- config
serverAddress = -- server address
port = -- port

-- get libs
local event = require("event")
local component = require("component")
local term = require("term")
local modem = component.proxy(component.modem.address)
local data = component.proxy(component.data.address)

-- init
while True do
