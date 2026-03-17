-- modules/fly.lua
local Fly = {}

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

function Fly:Init(gui, UI, config, elements)
    -- CRIAR PÁGINA USANDO O UI (NÃO O GUI)
    local page = UI:AddPage(gui, "Movimento", "Movimento")
    
    -- Seção Fly
    local section = elements:CreateSection(page, "FLY HACK", config.mainColor)
    local container = elements:CreateContainer(page, 150)
    
    self.enabled = false
    self.speed = config.flySpeed
    self.keybind = config.flyKeybind
    self.flyBV = nil
    self.flyBG = nil
    
    -- Toggle
    elements:CreateToggle(container, "Ativar Fly", false, function(state)
        self.enabled = state
        self:toggle(state)
    end, config.mainColor)
    
    -- Slider velocidade
    elements:CreateSlider(container, "Velocidade", 10, 200, self.speed, function(value)
        self.speed = value
    end, config.mainColor)
    
    -- Keybind
    elements:CreateKeybind(container, "Keybind", self.keybind, function(key)
        self.keybind = key
    end, config.mainColor)
    
    -- Keybind global
    userInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode[self.keybind] then
            self.enabled = not self.enabled
            self:toggle(self.enabled)
        end
    end)
    
    -- Loop do fly (já existia)
    runService.RenderStepped:Connect(function()
        if self.enabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            
            if humanoid then
                humanoid.PlatformStand = true
            end
            
            if not self.flyBV or not self.flyBV.Parent then
                self:createFlyObjects(root)
            end
            
            if self.flyBG then
                self.flyBG.CFrame = camera.CFrame
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
                direction = direction.Unit * self.speed
                self.flyBV.Velocity = direction
            else
                self.flyBV.Velocity = Vector3.new()
            end
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
end

function Fly:toggle(state)
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
