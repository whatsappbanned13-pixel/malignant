-- config/settings.lua
local Settings = {
    -- Cores
    mainColor = Color3.fromRGB(255, 0, 0),
    secondaryColor = Color3.fromRGB(255, 255, 255),
    
    -- Fly
    flySpeed = 75,
    flyKeybind = "F",
    
    -- Speed
    speedValue = 25,
    speedKeybind = "G",
    
    -- Infinite Jump
    infiniteJumpKeybind = "J",
    
    -- Aimbot
    aimbotSmoothness = 0.5,
    aimbotMaxDistance = 200,
    aimbotKeybind = "X",
    aimbotTargetPart = "Head",
    
    -- ESP
    espSize = 1,
    espOpacity = 0.8,
    
    -- Stick
    stickKeybind = "H",
    stickTargetPart = "HumanoidRootPart",
    
    -- Menu
    menuKeybind = Enum.KeyCode.LeftControl,
    menuName = "S3IKY"
}

return Settings
