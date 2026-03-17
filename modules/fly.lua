-- Modules/Fly.lua
local Fly = {}
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

function Fly:Init(gui, config)
    local page = gui:AddPage(gui, "Movimento", "Movimento")
    local Elements = require(script.Parent.Parent.GUI.Elements) -- adaptar
    
    local section = Elements:CreateSection(page, "FLY HACK", config.mainColor)
    local container = Elements:CreateContainer(page, 150)
    
    local enabled = false
    local speed = config.flySpeed
    local keybind = config.flyKeybind
    local flyBV, flyBG
    
    Elements:CreateToggle(container, "Ativar Fly", false, function(state)
        enabled = state
        self:toggle(state, speed)
    end, config.mainColor)
    
    Elements:CreateSlider(container, "Velocidade", 10, 200, speed, function(value)
        speed = value
    end, config.mainColor)
    
    Elements:CreateKeybind(container, "Keybind", keybind, function(key)
        keybind = key
    end, config.mainColor)
    
    -- Loop do fly
    runService.RenderStepped:Connect(function()
        if enabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            if not flyBV or not flyBV.Parent then
                self:createFlyObjects(root)
            end
            
            local direction = Vector3.new()
            if userInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camera.CFrame.LookVector
            end
            if userInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camera.CFrame.LookVector
            end
            if userInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camera.CFrame.RightVector
            end
            if userInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camera.CFrame.RightVector
            end
            if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if direction.Magnitude > 0 then
                direction = direction.Unit * speed
                flyBV.Velocity = direction
            else
                flyBV.Velocity = Vector3.new()
            end
            
            if flyBG then
                flyBG.CFrame = camera.CFrame
            end
        end
    end)
    
    -- Keybind global
    userInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode[keybind] then
            self:toggle(not enabled, speed)
            enabled = not enabled
        end
    end)
end

function Fly:createFlyObjects(root)
    if not root then return end
    
    self.flyBV = Instance.new("BodyVelocity")
    self.flyBV.Name = "FlyBV"
    self.flyBV.MaxForce = Vector3.new(1, 1, 1) * 9e9
    self.flyBV.P = 20000
    self.flyBV.Parent = root
    
    self.flyBG = Instance.new("BodyGyro")
    self.flyBG.Name = "FlyBG"
    self.flyBG.MaxTorque = Vector3.new(1, 1, 1) * 9e9
    self.flyBG.P = 20000
    self.flyBG.D = 1000
    self.flyBG.Parent = root
    
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
    end
end

function Fly:toggle(state, speed)
    if state then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            self:createFlyObjects(player.Character.HumanoidRootPart)
        end
    else
        if self.flyBV then
            self.flyBV:Destroy()
            self.flyBV = nil
        end
        if self.flyBG then
            self.flyBG:Destroy()
            self.flyBG = nil
        end
        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

return Fly