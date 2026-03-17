-- core/ui.lua - DESIGN NOVO COM GRADIENTE E NEVE
local UI = {}

local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

function UI:CreateMainGui(title, color)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "S3IKY"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999999
    
    -- Frame principal com OPACIDADE
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 900, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.15 -- 15% de opacidade
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui
    
    -- BORDAS LISAS (mais arredondadas)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20) -- Aumentei para 20
    corner.Parent = mainFrame
    
    -- GRADIENTE VERMELHO na borda superior
    local gradientFrame = Instance.new("Frame")
    gradientFrame.Size = UDim2.new(1, 0, 0, 80)
    gradientFrame.Position = UDim2.new(0, 0, 0, 0)
    gradientFrame.BackgroundTransparency = 1
    gradientFrame.ZIndex = 5
    gradientFrame.Parent = mainFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 0))
    })
    gradient.Rotation = 90
    gradient.Parent = gradientFrame
    
    -- Sombra suave
    self:CreateSoftShadow(mainFrame)
    
    -- Barra de título com opacidade
    self:CreateTitleBar(mainFrame, title, color)
    
    -- Menu lateral com opacidade
    local sideMenu = self:CreateSideMenu(mainFrame)
    
    -- Área de conteúdo com opacidade
    local contentArea, contentContainer = self:CreateContentArea(mainFrame)
    
    -- EFEITO DE NEVE! ❄️❄️❄️
    self:CreateSnowEffect(mainFrame)
    
    -- Tornar arrastável
    self:MakeDraggable(mainFrame)
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        sideMenu = sideMenu,
        contentContainer = contentContainer,
        pages = {},
        buttons = {}
    }
end

-- Sombra mais suave
function UI:CreateSoftShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
end

-- EFEITO DE NEVE ❄️
function UI:CreateSnowEffect(parent)
    local snowFolder = Instance.new("Folder")
    snowFolder.Name = "SnowEffect"
    snowFolder.Parent = parent
    
    -- Criar 30 bolinhas de neve
    for i = 1, 30 do
        local snow = Instance.new("Frame")
        snow.Name = "Snow" .. i
        snow.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        snow.Position = UDim2.new(math.random(), 0, math.random(), 0)
        snow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        snow.BackgroundTransparency = math.random(30, 70) / 100
        snow.ZIndex = 10
        snow.Parent = snowFolder
        
        -- Borda arredondada (para parecer bola)
        local snowCorner = Instance.new("UICorner")
        snowCorner.CornerRadius = UDim.new(1, 0)
        snowCorner.Parent = snow
        
        -- Animação da neve caindo
        local speed = math.random(30, 100) / 100
        local startPos = snow.Position
        local offset = 0
        
        spawn(function()
            while snow and snow.Parent do
                offset = offset + speed / 100
                if offset > 1 then
                    offset = 0
                end
                
                snow.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset,
                    startPos.Y.Scale + offset * 0.02,
                    startPos.Y.Offset
                )
                
                -- Reset quando sair da tela
                if snow.Position.Y.Scale > 1 then
                    snow.Position = UDim2.new(math.random(), 0, -0.1, 0)
                    startPos = snow.Position
                    offset = 0
                end
                
                wait(0.05)
            end
        end)
    end
end

function UI:CreateTitleBar(parent, title, color)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    titleBar.BackgroundTransparency = 0.2
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 3
    titleBar.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = titleBar
    
    -- Gradiente sutil no título
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 0))
    })
    gradient.Rotation = 90
    gradient.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(0, 250, 1, 0)
    titleText.Position = UDim2.new(0, 20, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.GothamBlack
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.ZIndex = 4
    titleText.Parent = titleBar
    
    -- Sombra no texto
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.fromRGB(0, 0, 0)
    shadow.Thickness = 2
    shadow.Transparency = 0.5
    shadow.Parent = titleText
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -45, 0.5, -17.5)
    closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    closeButton.BackgroundTransparency = 0.3
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 4
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        parent.Parent:Destroy()
    end)
    
    return titleBar
end

function UI:CreateSideMenu(parent)
    local sideMenu = Instance.new("Frame")
    sideMenu.Name = "SideMenu"
    sideMenu.Size = UDim2.new(0, 200, 1, -45)
    sideMenu.Position = UDim2.new(0, 0, 0, 45)
    sideMenu.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    sideMenu.BackgroundTransparency = 0.2
    sideMenu.BorderSizePixel = 0
    sideMenu.ZIndex = 3
    sideMenu.Parent = parent
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
    })
    gradient.Rotation = 90
    gradient.Parent = sideMenu
    
    local menuContainer = Instance.new("ScrollingFrame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, -10, 1, -10)
    menuContainer.Position = UDim2.new(0, 5, 0, 5)
    menuContainer.BackgroundTransparency = 1
    menuContainer.BorderSizePixel = 0
    menuContainer.ScrollBarThickness = 4
    menuContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    menuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    menuContainer.ZIndex = 4
    menuContainer.Parent = sideMenu
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = menuContainer
    
    return sideMenu
end

function UI:CreateContentArea(parent)
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -200, 1, -45)
    contentArea.Position = UDim2.new(0, 200, 0, 45)
    contentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    contentArea.BackgroundTransparency = 0.2
    contentArea.BorderSizePixel = 0
    contentArea.ZIndex = 3
    contentArea.Parent = parent
    
    local container = Instance.new("Frame")
    container.Name = "ContentContainer"
    container.Size = UDim2.new(1, -20, 1, -20)
    container.Position = UDim2.new(0, 10, 0, 10)
    container.BackgroundTransparency = 1
    container.ZIndex = 4
    container.Parent = contentArea
    
    return contentArea, container
end

function UI:AddPage(gui, name, buttonText)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 5
    page.Parent = gui.contentContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 15)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    -- Botão do menu lateral com design novo
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.BackgroundTransparency = 0.3
    button.Text = "   " .. buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.ZIndex = 5
    button.Parent = gui.sideMenu:FindFirstChild("MenuContainer")
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 5, 1, -10)
    line.Position = UDim2.new(0, 0, 0, 5)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    line.BorderSizePixel = 0
    line.Visible = false
    line.ZIndex = 6
    line.Parent = button
    
    gui.pages[name] = page
    gui.buttons[name] = {button = button, line = line}
    
    return page
end

function UI:SetupNavigation(gui)
    for name, data in pairs(gui.buttons) do
        data.button.MouseButton1Click:Connect(function()
            for _, btnData in pairs(gui.buttons) do
                btnData.button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                btnData.line.Visible = false
            end
            
            data.button.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
            data.line.Visible = true
            
            for pageName, page in pairs(gui.pages) do
                page.Visible = (pageName == name)
            end
        end)
    end
    
    -- Ativar primeira página
    local firstName = next(gui.buttons)
    if firstName then
        gui.buttons[firstName].button.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        gui.buttons[firstName].line.Visible = true
        gui.pages[firstName].Visible = true
    end
end

function UI:MakeDraggable(frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local titleBar = frame:FindFirstChild("TitleBar")
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

return UI
