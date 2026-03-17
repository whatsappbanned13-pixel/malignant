-- S3IKY HACK - VERSÃO UNIFICADA (TUDO NUM ARQUIVO SÓ)
local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- =============== CONFIGURAÇÕES ===============
local Settings = {
    mainColor = Color3.fromRGB(255, 0, 0),
    flySpeed = 75,
    flyKeybind = "F",
    menuKeybind = Enum.KeyCode.LeftControl,
    menuName = "S3IKY"
}

local Places = {
    ["Tumba"] = Vector3.new(542.62, 25.93, -502.01),
    ["Banco"] = Vector3.new(27.41, 18.66, 793.15),
    ["Base"] = Vector3.new(0, 50, 0)
}

-- =============== CRIAÇÃO DA GUI ===============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = Settings.menuName
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Bordas arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = mainFrame

-- Gradiente vermelho
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new(Color3.fromRGB(255,0,0), Color3.fromRGB(50,0,0))
gradient.Rotation = 90
gradient.Parent = mainFrame

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.BackgroundTransparency = 0.1
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "S3IKY HACK"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- =============== EFEITO DE NEVE ===============
for i = 1, 20 do
    local snow = Instance.new("Frame")
    snow.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
    snow.Position = UDim2.new(math.random(), 0, math.random(), 0)
    snow.BackgroundColor3 = Color3.fromRGB(255,255,255)
    snow.BackgroundTransparency = 0.3
    snow.ZIndex = 10
    snow.Parent = mainFrame
    
    local snowCorner = Instance.new("UICorner")
    snowCorner.CornerRadius = UDim.new(1,0)
    snowCorner.Parent = snow
    
    local speed = math.random(20,50) / 1000
    
    spawn(function()
        while snow do
            snow.Position = snow.Position + UDim2.new(0,0,speed,0)
            if snow.Position.Y.Scale > 1 then
                snow.Position = UDim2.new(math.random(),0,-0.1,0)
            end
            wait(0.05)
        end
    end)
end

-- =============== MENU LATERAL ===============
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 150, 1, -40)
sideMenu.Position = UDim2.new(0, 0, 0, 40)
sideMenu.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
sideMenu.BackgroundTransparency = 0.1
sideMenu.Parent = mainFrame

local menuContainer = Instance.new("ScrollingFrame")
menuContainer.Size = UDim2.new(1, -10, 1, -10)
menuContainer.Position = UDim2.new(0, 5, 0, 5)
menuContainer.BackgroundTransparency = 1
menuContainer.ScrollBarThickness = 3
menuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
menuContainer.Parent = sideMenu

-- =============== ÁREA DE CONTEÚDO ===============
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -150, 1, -40)
contentArea.Position = UDim2.new(0, 150, 0, 40)
contentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentArea.BackgroundTransparency = 0.1
contentArea.Parent = mainFrame

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -20, 1, -20)
contentContainer.Position = UDim2.new(0, 10, 0, 10)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = contentArea

-- =============== BOTÕES DO MENU ===============
local pages = {}
local buttons = {}

local menuItems = {
    {"Movimento", "Movimento"},
    {"Aimbot", "Aimbot"},
    {"Visuais", "Visuais"},
    {"Lugares", "Lugares"}
}

for i, item in ipairs(menuItems) do
    local btn = Instance.new("TextButton")
    btn.Name = item[1] .. "Button"
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.2
    btn.Text = "   " .. item[2]
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = menuContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Página correspondente
    local page = Instance.new("ScrollingFrame")
    page.Name = item[1] .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = (i == 1)
    page.Parent = contentContainer
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 10)
    pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    pageLayout.Parent = page
    
    pages[item[1]] = page
    buttons[item[1]] = btn
    
    -- Adicionar alguns toggles de exemplo na página Movimento
    if item[1] == "Movimento" then
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, -10, 0, 100)
        container.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        container.Parent = page
        
        local containerCorner = Instance.new("UICorner")
        containerCorner.CornerRadius = UDim.new(0, 8)
        containerCorner.Parent = container
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -10, 0, 35)
        toggleFrame.Position = UDim2.new(0, 5, 0, 5)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        toggleFrame.Parent = container
        
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Size = UDim2.new(0, 150, 1, 0)
        toggleLabel.Position = UDim2.new(0, 10, 0, 0)
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Text = "Fly"
        toggleLabel.TextColor3 = Color3.fromRGB(255,255,255)
        toggleLabel.TextScaled = true
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Parent = toggleFrame
    end
end

-- Navegação entre páginas
for name, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        for _, otherBtn in pairs(buttons) do
            otherBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        end
        btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        
        for pageName, page in pairs(pages) do
            page.Visible = (pageName == name)
        end
    end)
end

-- Ativar primeira página
if buttons["Movimento"] then
    buttons["Movimento"].BackgroundColor3 = Color3.fromRGB(40, 0, 0)
end

-- =============== FUNÇÃO FLY ===============
local flyEnabled = false
local flyBV = nil
local flyBG = nil

function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(1,1,1)*9e9
            flyBV.Parent = root
            
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(1,1,1)*9e9
            flyBG.Parent = root
            
            if player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.PlatformStand = true
            end
        end
    else
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.PlatformStand = false
        end
    end
end

-- Loop do fly
runService.RenderStepped:Connect(function()
    if flyEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        local dir = Vector3.new()
        
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            dir = dir + camera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            dir = dir - camera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            dir = dir - camera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            dir = dir + camera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            dir = dir + Vector3.new(0,1,0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            dir = dir - Vector3.new(0,1,0)
        end
        
        if dir.Magnitude > 0 then
            flyBV.Velocity = dir.Unit * 75
        else
            flyBV.Velocity = Vector3.new()
        end
        
        if flyBG then
            flyBG.CFrame = camera.CFrame
        end
    end
end)

-- Keybind Fly
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)

-- Tecla para abrir/fechar menu
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Settings.menuKeybind then
        wait(0.1)
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("✅ S3IKY HACK UNIFICADO carregado! Pressione CTRL para abrir/fechar")
print("❄️ Neve caindo ativada! Pressione F para fly")
