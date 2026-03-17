-- core/ui.lua - DESIGN CORRIGIDO (bordas lisas em tudo)
local UI = {}

local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

function UI:CreateMainGui(title, color)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "S3IKY"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    
    -- Frame principal (com bordas lisas em TODOS os lados)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 750, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -375, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- BORDA LISA EM TODOS OS LADOS (NÃO SÓ EM CIMA)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- Garantir que o conteúdo interno também tenha bordas lisas
    local mask = Instance.new("UICorner")
    mask.CornerRadius = UDim.new(0, 20)
    mask.Parent = mainFrame
    
    -- Gradiente vermelho na parte superior
    local gradientFrame = Instance.new("Frame")
    gradientFrame.Size = UDim2.new(1, 0, 0, 80)
    gradientFrame.BackgroundTransparency = 1
    gradientFrame.ZIndex = 2
    gradientFrame.Parent = mainFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 0))
    })
    gradient.Rotation = 90
    gradient.Parent = gradientFrame
    
    -- Barra de título
    self:CreateTitleBar(mainFrame, title, color)
    
    -- Menu lateral
    local sideMenu = self:CreateSideMenu(mainFrame)
    
    -- Área de conteúdo
    local contentArea, contentContainer = self:CreateContentArea(mainFrame)
    
    -- Efeito de neve
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

function UI:CreateTitleBar(parent, title, color)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    titleBar.BackgroundTransparency = 0.1
    titleBar.BorderSizePixel = 0
    titleBar.Parent = parent
    
    -- Bordas arredondadas no título também
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0, 250, 1, 0)
    titleText.Position = UDim2.new(0, 20, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -45, 0.5, -17.5)
    closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
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
    sideMenu.Size = UDim2.new(0, 170, 1, -45)
    sideMenu.Position = UDim2.new(0, 0, 0, 45)
    sideMenu.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    sideMenu.BackgroundTransparency = 0.1
    sideMenu.BorderSizePixel = 0
    sideMenu.Parent = parent
    
    -- Bordas arredondadas no menu lateral
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = sideMenu
    
    local menuContainer = Instance.new("ScrollingFrame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, -10, 1, -10)
    menuContainer.Position = UDim2.new(0, 5, 0, 5)
    menuContainer.BackgroundTransparency = 1
    menuContainer.BorderSizePixel = 0
    menuContainer.ScrollBarThickness = 3
    menuContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    menuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    menuContainer.Parent = sideMenu
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = menuContainer
    
    return sideMenu
end

function UI:CreateContentArea(parent)
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -170, 1, -45)
    contentArea.Position = UDim2.new(0, 170, 0, 45)
    contentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    contentArea.BackgroundTransparency = 0.1
    contentArea.BorderSizePixel = 0
    contentArea.Parent = parent
    
    -- Bordas arredondadas na área de conteúdo
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = contentArea
    
    local container = Instance.new("Frame")
    container.Name = "ContentContainer"
    container.Size = UDim2.new(1, -20, 1, -20)
    container.Position = UDim2.new(0, 10, 0, 10)
    container.BackgroundTransparency = 1
    container.Parent = contentArea
    
    return contentArea, container
end

function UI:CreateSnowEffect(parent)
    for i = 1, 20 do
        local snow = Instance.new("Frame")
        snow.Name = "Snow" .. i
        snow.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
        snow.Position = UDim2.new(math.random(), 0, math.random(), 0)
        snow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        snow.BackgroundTransparency = math.random(30, 70) / 100
        snow.ZIndex = 10
        snow.Parent = parent
        
        local snowCorner = Instance.new("UICorner")
        snowCorner.CornerRadius = UDim.new(1, 0)
        snowCorner.Parent = snow
        
        local speed = math.random(20, 50) / 1000
        
        spawn(function()
            while snow and snow.Parent do
                snow.Position = snow.Position + UDim2.new(0, 0, speed, 0)
                if snow.Position.Y.Scale > 1 then
                    snow.Position = UDim2.new(math.random(), 0, -0.1, 0)
                end
                wait(0.05)
            end
        end)
    end
end

function UI:AddPage(gui, name, buttonText)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = gui.contentContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    -- Botão do menu
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.BackgroundTransparency = 0.2
    button.Text = "   " .. buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = gui.sideMenu:FindFirstChild("MenuContainer")
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 4, 1, -10)
    line.Position = UDim2.new(0, 0, 0, 5)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    line.Visible = false
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
    local dragStart
    local startPos
    
    local titleBar = frame:FindFirstChild("TitleBar")
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
