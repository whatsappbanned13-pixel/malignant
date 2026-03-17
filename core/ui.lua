-- core/ui.lua - DESIGN NOVO (VERSÃO 100% FUNCIONAL)
local UI = {}

local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

function UI:CreateMainGui(title, color)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "S3IKY"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- Gradiente vermelho
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(Color3.fromRGB(255,0,0), Color3.fromRGB(50,0,0))
    gradient.Rotation = 90
    gradient.Parent = mainFrame
    
    -- Barra de título
    self:CreateTitleBar(mainFrame, title, color)
    
    -- Neve (simplificada e funcional)
    self:CreateSnowEffect(mainFrame)
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        pages = {},
        buttons = {}
    }
end

function UI:CreateTitleBar(parent, title, color)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    titleBar.BackgroundTransparency = 0.1
    titleBar.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
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
        parent.Parent:Destroy()
    end)
end

function UI:CreateSnowEffect(parent)
    for i = 1, 15 do
        local snow = Instance.new("Frame")
        snow.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
        snow.Position = UDim2.new(math.random(), 0, math.random(), 0)
        snow.BackgroundColor3 = Color3.fromRGB(255,255,255)
        snow.BackgroundTransparency = 0.3
        snow.ZIndex = 10
        snow.Parent = parent
        
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
end

function UI:AddPage(gui, name, buttonText)
    -- Versão simplificada (só para não dar erro)
    local page = Instance.new("Frame")
    page.Name = name.."Page"
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Parent = gui.mainFrame
    page.Visible = false
    
    gui.pages[name] = page
    return page
end

function UI:SetupNavigation(gui)
    -- Função vazia por enquanto
end

return UI
