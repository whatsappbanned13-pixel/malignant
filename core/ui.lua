-- core/ui.lua - VERSÃO CORRIGIDA (Tamanho ajustado, seleção funcionando)
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
    
    -- Frame principal (MAIS LARGO E MENOS ALTO)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 950, 0, 450)  -- MAIS LARGO (950) e MENOS ALTO (450)
    mainFrame.Position = UDim2.new(0.5, -475, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    mainFrame.BackgroundTransparency = 0
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui
    
    -- Barra de título (mais fina)
    self:CreateTitleBar(mainFrame, title, color)
    
    -- Menu lateral (um pouco mais largo)
    local sideMenu = self:CreateSideMenu(mainFrame)
    
    -- Área de conteúdo
    local contentArea, contentContainer = self:CreateContentArea(mainFrame)
    
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
    titleBar.Size = UDim2.new(1, 0, 0, 35)  -- TÍTULO MAIS FINO (35px)
    titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    titleBar.BackgroundTransparency = 0
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 3
    titleBar.Parent = parent
    
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
    closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    closeButton.BackgroundTransparency = 0
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 4
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        parent.Parent:Destroy()
    end)
    
    return titleBar
end

function UI:CreateSideMenu(parent)
    local sideMenu = Instance.new("Frame")
    sideMenu.Name = "SideMenu"
    sideMenu.Size = UDim2.new(0, 220, 1, -35)  -- MAIS LARGO (220px) e ajustado ao título
    sideMenu.Position = UDim2.new(0, 0, 0, 35)
    sideMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    sideMenu.BackgroundTransparency = 0
    sideMenu.BorderSizePixel = 0
    sideMenu.ZIndex = 3
    sideMenu.Parent = parent
    
    -- Linha divisória
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(0, 1, 1, -20)
    divider.Position = UDim2.new(1, -1, 0, 10)
    divider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    divider.BorderSizePixel = 0
    divider.ZIndex = 4
    divider.Parent = sideMenu
    
    local menuContainer = Instance.new("ScrollingFrame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, 0, 1, 0)
    menuContainer.BackgroundTransparency = 1
    menuContainer.BorderSizePixel = 0
    menuContainer.ScrollBarThickness = 4
    menuContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 0)
    menuContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    menuContainer.ZIndex = 4
    menuContainer.Parent = sideMenu
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 2)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = menuContainer
    
    return sideMenu
end

function UI:CreateContentArea(parent)
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -220, 1, -35)  -- Ajustado para menu de 220px
    contentArea.Position = UDim2.new(0, 220, 0, 35)
    contentArea.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    contentArea.BackgroundTransparency = 0
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
    -- Criar página
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 5
    page.Parent = gui.contentContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    -- Criar botão do menu
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, 0, 0, 38)  -- Botões um pouco menores
    button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    button.BackgroundTransparency = 0
    button.Text = "  " .. buttonText
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.ZIndex = 5
    button.Parent = gui.sideMenu:FindFirstChild("MenuContainer")
    
    -- Linha indicadora (verde)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 4, 1, 0)
    line.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    line.BackgroundTransparency = 0
    line.Visible = false
    line.ZIndex = 6
    line.Parent = button
    
    -- Gradiente para o botão selecionado
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 100, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
    })
    gradient.Rotation = 90
    gradient.Visible = false
    gradient.Parent = button
    
    -- Evento de clique (DIRETO NO BOTÃO)
    button.MouseButton1Click:Connect(function()
        -- Resetar todos os botões
        for _, btnData in pairs(gui.buttons) do
            btnData.button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            btnData.button.TextColor3 = Color3.fromRGB(180, 180, 180)
            btnData.line.Visible = false
            if btnData.gradient then
                btnData.gradient.Visible = false
            end
        end
        
        -- Ativar este botão
        button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        button.TextColor3 = Color3.fromRGB(0, 255, 0)
        line.Visible = true
        gradient.Visible = true
        
        -- Mostrar página correspondente
        for pageName, page in pairs(gui.pages) do
            page.Visible = (pageName == name)
        end
    end)
    
    -- Armazenar referências
    gui.pages[name] = page
    gui.buttons[name] = {
        button = button,
        line = line,
        gradient = gradient
    }
    
    return page
end

function UI:SetupNavigation(gui)
    -- Ativar primeira página automaticamente
    local firstName = next(gui.buttons)
    if firstName then
        local firstData = gui.buttons[firstName]
        firstData.button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        firstData.button.TextColor3 = Color3.fromRGB(0, 255, 0)
        firstData.line.Visible = true
        if firstData.gradient then
            firstData.gradient.Visible = true
        end
        gui.pages[firstName].Visible = true
    end
end

function UI:MakeDraggable(frame)
    local dragging = false
    local dragStart
    local startPos
    
    local titleBar = frame:FindChild("TitleBar")
    if not titleBar then return end
    
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
