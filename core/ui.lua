-- core/ui.lua - DESIGN NOVA (Clean, abas, painéis)
local UI = {}

local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

function UI:CreateMainGui(title, color)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MALIGNANT"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999999
    
    -- Frame principal (tamanho NOVA)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 700, 0, 450)  -- Tamanho compacto
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)  -- Fundo escuro
    mainFrame.BackgroundTransparency = 0
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui
    
    -- Barra superior (título)
    self:CreateTitleBar(mainFrame, title)
    
    -- Menu de abas (superior)
    local tabContainer = self:CreateTabContainer(mainFrame)
    
    -- Área de conteúdo (dividida em esquerda/direita)
    local leftPanel, rightPanel = self:CreatePanels(mainFrame)
    
    -- Tornar arrastável
    self:MakeDraggable(mainFrame)
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        tabContainer = tabContainer,
        leftPanel = leftPanel,
        rightPanel = rightPanel,
        tabs = {},
        pages = {}
    }
end

function UI:CreateTitleBar(parent, title)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    titleBar.BackgroundTransparency = 0
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 3
    titleBar.Parent = parent
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title
    titleText.TextColor3 = Color3.fromRGB(200, 200, 200)
    titleText.TextSize = 16
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.ZIndex = 4
    titleText.Parent = titleBar
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    closeButton.BackgroundTransparency = 0
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 16
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 4
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        parent.Parent:Destroy()
    end)
    
    return titleBar
end

function UI:CreateTabContainer(parent)
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -20, 0, 40)
    tabContainer.Position = UDim2.new(0, 10, 0, 40)
    tabContainer.BackgroundTransparency = 1
    tabContainer.ZIndex = 3
    tabContainer.Parent = parent
    
    -- Criar layout horizontal para as abas
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = tabContainer
    
    return tabContainer
end

function UI:CreatePanels(parent)
    -- Painel esquerdo (categorias)
    local leftPanel = Instance.new("Frame")
    leftPanel.Name = "LeftPanel"
    leftPanel.Size = UDim2.new(0.5, -15, 0, -90)
    leftPanel.Position = UDim2.new(0, 10, 0, 90)
    leftPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
    leftPanel.BackgroundTransparency = 0
    leftPanel.BorderSizePixel = 0
    leftPanel.ZIndex = 3
    leftPanel.Parent = parent
    
    -- Borda sutil
    local leftBorder = Instance.new("Frame")
    leftBorder.Size = UDim2.new(1, 0, 0, 1)
    leftBorder.Position = UDim2.new(0, 0, 1, -1)
    leftBorder.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    leftBorder.BorderSizePixel = 0
    leftBorder.ZIndex = 4
    leftBorder.Parent = leftPanel
    
    -- Título do painel esquerdo
    local leftTitle = Instance.new("TextLabel")
    leftTitle.Size = UDim2.new(1, -20, 0, 30)
    leftTitle.Position = UDim2.new(0, 10, 0, 5)
    leftTitle.BackgroundTransparency = 1
    leftTitle.Text = "Combat"
    leftTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
    leftTitle.TextSize = 16
    leftTitle.Font = Enum.Font.GothamBold
    leftTitle.TextXAlignment = Enum.TextXAlignment.Left
    leftTitle.ZIndex = 4
    leftTitle.Parent = leftPanel
    
    -- Container para itens do painel esquerdo
    local leftContainer = Instance.new("ScrollingFrame")
    leftContainer.Name = "LeftContainer"
    leftContainer.Size = UDim2.new(1, -20, 1, -45)
    leftContainer.Position = UDim2.new(0, 10, 0, 40)
    leftContainer.BackgroundTransparency = 1
    leftContainer.BorderSizePixel = 0
    leftContainer.ScrollBarThickness = 4
    leftContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)
    leftContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    leftContainer.ZIndex = 4
    leftContainer.Parent = leftPanel
    
    -- Painel direito (configurações)
    local rightPanel = Instance.new("Frame")
    rightPanel.Name = "RightPanel"
    rightPanel.Size = UDim2.new(0.5, -15, 0, -90)
    rightPanel.Position = UDim2.new(0.5, 5, 0, 90)
    rightPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
    rightPanel.BackgroundTransparency = 0
    rightPanel.BorderSizePixel = 0
    rightPanel.ZIndex = 3
    rightPanel.Parent = parent
    
    -- Borda sutil
    local rightBorder = Instance.new("Frame")
    rightBorder.Size = UDim2.new(1, 0, 0, 1)
    rightBorder.Position = UDim2.new(0, 0, 1, -1)
    rightBorder.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    rightBorder.BorderSizePixel = 0
    rightBorder.ZIndex = 4
    rightBorder.Parent = rightPanel
    
    -- Título do painel direito
    local rightTitle = Instance.new("TextLabel")
    rightTitle.Size = UDim2.new(1, -20, 0, 30)
    rightTitle.Position = UDim2.new(0, 10, 0, 5)
    rightTitle.BackgroundTransparency = 1
    rightTitle.Text = "Autoclicker"
    rightTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
    rightTitle.TextSize = 16
    rightTitle.Font = Enum.Font.GothamBold
    rightTitle.TextXAlignment = Enum.TextXAlignment.Left
    rightTitle.ZIndex = 4
    rightTitle.Parent = rightPanel
    
    -- Container para itens do painel direito
    local rightContainer = Instance.new("ScrollingFrame")
    rightContainer.Name = "RightContainer"
    rightContainer.Size = UDim2.new(1, -20, 1, -45)
    rightContainer.Position = UDim2.new(0, 10, 0, 40)
    rightContainer.BackgroundTransparency = 1
    rightContainer.BorderSizePixel = 0
    rightContainer.ScrollBarThickness = 4
    rightContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)
    rightContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightContainer.ZIndex = 4
    rightContainer.Parent = rightPanel
    
    return leftPanel, rightPanel
end

-- Função para criar abas
function UI:AddTab(gui, name, tabText)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(0, 100, 0, 30)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    tab.BackgroundTransparency = 0
    tab.Text = "  " .. tabText
    tab.TextColor3 = Color3.fromRGB(180, 180, 180)
    tab.TextSize = 14
    tab.Font = Enum.Font.GothamBold
    tab.TextXAlignment = Enum.TextXAlignment.Left
    tab.AutoButtonColor = false
    tab.ZIndex = 4
    tab.Parent = gui.tabContainer
    
    -- Borda inferior (indicador de aba ativa)
    local border = Instance.new("Frame")
    border.Name = "ActiveBorder"
    border.Size = UDim2.new(1, 0, 0, 2)
    border.Position = UDim2.new(0, 0, 1, -2)
    border.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    border.BackgroundTransparency = 0
    border.Visible = false
    border.ZIndex = 5
    border.Parent = tab
    
    gui.tabs[name] = {
        tab = tab,
        border = border
    }
    
    return tab
end

-- Função para criar seção de configuração (igual ao NOVA)
function UI:CreateConfigSection(parent, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 30)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -5, 1, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "  " .. title
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 5
    titleLabel.Parent = section
    
    return section
end

-- Função para criar slider (igual ao NOVA)
function UI:CreateSlider(parent, text, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 40, 1, 0)
    valueLabel.Position = UDim2.new(1, -45, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default) .. (suffix or "")
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    valueLabel.TextSize = 12
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = 5
    valueLabel.Parent = frame
    
    -- Barra do slider
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -200, 0, 4)
    sliderBg.Position = UDim2.new(0, 160, 0.5, -2)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    sliderBg.ZIndex = 5
    sliderBg.Parent = frame
    
    local percent = (default - min) / (max - min)
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    sliderFill.ZIndex = 6
    sliderFill.Parent = sliderBg
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 10, 0, 10)
    sliderButton.Position = UDim2.new(percent, -5, 0.5, -5)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.ZIndex = 7
    sliderButton.Parent = sliderBg
    
    -- Eventos do slider
    local dragging = false
    sliderButton.MouseButton1Down:Connect(function() dragging = true end)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = userInputService:GetMouseLocation()
            local absPos = sliderBg.AbsolutePosition
            local relativeX = math.clamp(mousePos.X - absPos.X, 0, sliderBg.AbsoluteSize.X)
            local newPercent = relativeX / sliderBg.AbsoluteSize.X
            local value = min + (max - min) * newPercent
            value = math.floor(value * 100) / 100
            
            sliderFill.Size = UDim2.new(newPercent, 0, 1, 0)
            sliderButton.Position = UDim2.new(newPercent, -5, 0.5, -5)
            valueLabel.Text = tostring(value) .. (suffix or "")
            
            if callback then callback(value) end
        end
    end)
    
    return frame
end

-- Função para criar toggle (igual ao NOVA)
function UI:CreateToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = frame
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 20)
    toggleBg.Position = UDim2.new(1, -45, 0.5, -10)
    toggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    toggleBg.ZIndex = 5
    toggleBg.Parent = frame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 16, 0, 16)
    toggleButton.Position = UDim2.new(0, 2, 0.5, -8)
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    toggleButton.Text = ""
    toggleButton.ZIndex = 6
    toggleButton.Parent = toggleBg
    
    local enabled = default or false
    
    local function updateToggle()
        if enabled then
            toggleButton.Position = UDim2.new(1, -18, 0.5, -8)
            toggleBg.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            toggleButton.Position = UDim2.new(0, 2, 0.5, -8)
            toggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end
    
    updateToggle()
    
    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
        if callback then callback(enabled) end
    end)
    
    return frame
end

function UI:SetupTabs(gui)
    for name, data in pairs(gui.tabs) do
        data.tab.MouseButton1Click:Connect(function()
            for _, tabData in pairs(gui.tabs) do
                tabData.tab.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                tabData.tab.TextColor3 = Color3.fromRGB(180, 180, 180)
                tabData.border.Visible = false
            end
            
            data.tab.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
            data.tab.TextColor3 = Color3.fromRGB(255, 255, 255)
            data.border.Visible = true
        end)
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
