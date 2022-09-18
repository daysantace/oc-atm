-- get libs
local component=require(component)
local computer=require(computer)

--check for components
if computer.totalMemory()<384000 then
  term.clear()
  print("ERROR! Not enough memory")
end

if not component.isAvaliable("modem") then
  print("ERROR! Network card not detected")
end

if not component.isAvaliable("data") then
  print("ERROR! Data card not detected")
end

local modem=component.getPrimary("modem")
local data=component.getPrimary("data")


while true do
  
  -- header
  print("OC-ATM 0.0.1")
  print("")
  print("1 - Log in")
  print("2 - Sign up")
  local inp=io.read()
  
  if inp=="1" then -- log in
    computer.beep(750,0.25)
    print("Enter username")
    local id=io.read()
    
    local pwd=io.read()
  end
end
