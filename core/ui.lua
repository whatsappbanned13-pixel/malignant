-- core/ui.lua - VERSÃO CLEAN (Cinza, sem neve, bordas quadradas)
local UI = {}

local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

function UI:CreateMainGui(title, color)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "S3IKY"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999999
    
    -- Frame principal (MENOR: 650x400)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 650, 0, 400)  -- Altura reduzida
    mainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Cinza escuro
    mainFrame.BackgroundTransparency = 0  -- SEM opacidade
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui
    
    -- BORDAS QUADRADAS (sem arredondamento)
    -- (removido o UICorner)
    
    -- Sombra suave (opcional)
    self:CreateSoftShadow(mainFrame)
    
    -- Barra de título
    self:CreateTitleBar(mainFrame, title, color)
    
    -- Menu lateral
    local sideMenu = self:CreateSideMenu(mainFrame)
    
    -- Área de conteúdo
    local contentArea, contentContainer = self:CreateContentArea(mainFrame)
    
    -- SEM EFEITO DE NEVE (removido)
    
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
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
end

function UI:CreateTitleBar(parent, title, color)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Cinza mais escuro
    titleBar.BackgroundTransparency = 0
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 3
    titleBar.Parent = parent
    
    -- Sem bordas arredondadas (removido UICorner)
    
    -- Gradiente vermelho (opcional - pode remover se quiser)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color or Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
    })
    gradient.Rotation = 90
    gradient.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(0, 250, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.ZIndex = 4
    titleText.Parent = titleBar
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    closeButton.BackgroundTransparency = 0
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 4
    closeButton.Parent = titleBar
    
    -- Botão quadrado também (sem bordas arredondadas)
    -- (removido UICorner)
    
    closeButton.MouseButton1Click:Connect(function()
        parent.Parent:Destroy()
    end)
    
    return titleBar
end

function UI:CreateSideMenu(parent)
    local sideMenu = Instance.new("Frame")
    sideMenu.Name = "SideMenu"
    sideMenu.Size = UDim2.new(0, 160, 1, -40)  -- Largura ajustada
    sideMenu.Position = UDim2.new(0, 0, 0, 40)
    sideMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 35)  -- Cinza médio
    sideMenu.BackgroundTransparency = 0
    sideMenu.BorderSizePixel = 0
    sideMenu.ZIndex = 3
    sideMenu.Parent = parent
    
    -- Sem bordas arredondadas
    
    local menuContainer = Instance.new("ScrollingFrame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, 0, 1, 0)
    menuContainer.BackgroundTransparency = 1
    menuContainer.BorderSizePixel = 0
    menuContainer.ScrollBarThickness = 4
    menuContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    menuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    menuContainer.ZIndex = 4
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
    contentArea.Size = UDim2.new(1, -160, 1, -40)
    contentArea.Position = UDim2.new(0, 160, 0, 40)
    contentArea.BackgroundColor3 = Color3.fromRGB(45, 45, 45)  -- Cinza mais claro
    contentArea.BackgroundTransparency = 0
    contentArea.BorderSizePixel = 0
    contentArea.ZIndex = 3
    contentArea.Parent = parent
    
    -- Sem bordas arredondadas
    
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
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    -- Botão do menu
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BackgroundTransparency = 0
    button.Text = "   " .. buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.ZIndex = 5
    button.Parent = gui.sideMenu:FindFirstChild("MenuContainer")
    
    -- Botão quadrado (sem bordas arredondadas)
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 4, 1, -10)
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
                btnData.button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                btnData.line.Visible = false
            end
            
            data.button.BackgroundColor3 = Color3.fromRGB(80, 0, 0)  -- Vermelho escuro quando selecionado
            data.line.Visible = true
            
            for pageName, page in pairs(gui.pages) do
                page.Visible = (pageName == name)
            end
        end)
    end
    
    -- Ativar primeira página
    local firstName = next(gui.buttons)
    if firstName then
        gui.buttons[firstName].button.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
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
