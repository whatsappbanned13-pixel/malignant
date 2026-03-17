-- core/ui.lua - VERSÃO ULTRA FINAL
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
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 900, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -450, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    mainFrame.BackgroundTransparency = 0
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui
    
    -- Menu lateral (com nome centralizado)
    local sideMenu = self:CreateSideMenu(mainFrame, title)
    
    -- Área de conteúdo
    local contentArea, contentContainer = self:CreateContentArea(mainFrame)
    
    -- LINHA DIVISÓRIA VERTICAL (do topo ao fim)
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(0, 1, 1, 0)
    divider.Position = UDim2.new(0, 220, 0, 0)  -- Começa onde termina o menu
    divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    divider.BorderSizePixel = 0
    divider.ZIndex = 5
    divider.Parent = mainFrame
    
    -- Tornar arrastável
    self:MakeDraggable(mainFrame, sideMenu)
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        sideMenu = sideMenu,
        contentContainer = contentContainer,
        pages = {},
        buttons = {}
    }
end

function UI:CreateSideMenu(parent, title)
    local sideMenu = Instance.new("Frame")
    sideMenu.Name = "SideMenu"
    sideMenu.Size = UDim2.new(0, 220, 1, 0)
    sideMenu.BackgroundColor3 = Color3.fromRGB(22, 22, 22)  -- MESMA COR DO FUNDO
    sideMenu.BackgroundTransparency = 0
    sideMenu.BorderSizePixel = 0
    sideMenu.ZIndex = 3
    sideMenu.Parent = parent
    
    -- TÍTULO DO HACK NO MENU LATERAL (BRANCO, CENTRALIZADO)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "MenuTitle"
    titleLabel.Size = UDim2.new(1, 0, 0, 60)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "malignant"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- BRANCO
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.ZIndex = 5
    titleLabel.Parent = sideMenu
    
    -- Container de botões
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 1, -60)
    buttonContainer.Position = UDim2.new(0, 0, 0, 60)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = sideMenu
    
    -- Layout dos botões
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 0)  -- SEM ESPAÇO, ENCOSTADOS
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = buttonContainer
    
    return sideMenu
end

function UI:CreateContentArea(parent)
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -220, 1, 0)
    contentArea.Position = UDim2.new(0, 220, 0, 0)
    contentArea.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    contentArea.BackgroundTransparency = 0
    contentArea.BorderSizePixel = 0
    contentArea.ZIndex = 3
    contentArea.Parent = parent
    
    -- TÍTULO DA PÁGINA ATUAL (opcional)
    local pageTitle = Instance.new("TextLabel")
    pageTitle.Name = "PageTitle"
    pageTitle.Size = UDim2.new(1, -20, 0, 40)
    pageTitle.Position = UDim2.new(0, 10, 0, 10)
    pageTitle.BackgroundTransparency = 1
    pageTitle.Text = ""
    pageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    pageTitle.TextScaled = true
    pageTitle.Font = Enum.Font.GothamBold
    pageTitle.TextXAlignment = Enum.TextXAlignment.Left
    pageTitle.Visible = false
    pageTitle.ZIndex = 5
    pageTitle.Parent = contentArea
    
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
    
    -- Layout da página
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 15)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    -- LINHA DE CONTORNO DA CATEGORIA (no topo da página)
    local categoryLine = Instance.new("Frame")
    categoryLine.Size = UDim2.new(1, -20, 0, 2)
    categoryLine.Position = UDim2.new(0, 10, 0, 0)
    categoryLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    categoryLine.BorderSizePixel = 0
    categoryLine.ZIndex = 6
    categoryLine.Parent = page
    
    -- Botão do menu (LATERAL - ENCOSTADO 100%)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, 0, 0, 45)  -- Largura TOTAL, encostado
    button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)  -- MESMA COR DO FUNDO
    button.BackgroundTransparency = 0
    button.Text = "  " .. buttonText
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.ZIndex = 5
    button.Parent = gui.sideMenu:FindFirstChild("ButtonContainer")
    
    -- GRADIENTE DE SELEÇÃO (COM OPACIDADE)
    local selectionGradient = Instance.new("UIGradient")
    selectionGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 200, 0)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 150, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
    })
    selectionGradient.Rotation = 90
    selectionGradient.Transparency = NumberSequence.new(0.5)  -- 50% de opacidade
    selectionGradient.Visible = false
    selectionGradient.Parent = button
    
    -- LINHA INDICADORA VERDE (sem opacidade)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 4, 1, 0)
    line.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    line.BackgroundTransparency = 0
    line.Visible = false
    line.ZIndex = 7
    line.Parent = button
    
    -- Evento de clique
    button.MouseButton1Click:Connect(function()
        -- Resetar todos os botões
        for _, btnData in pairs(gui.buttons) do
            btnData.button.TextColor3 = Color3.fromRGB(180, 180, 180)
            btnData.line.Visible = false
            if btnData.gradient then
                btnData.gradient.Visible = false
            end
        end
        
        -- Ativar este botão
        button.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Texto verde quando selecionado
        line.Visible = true
        selectionGradient.Visible = true  -- Gradiente com opacidade aparece
        
        -- Mostrar página correspondente
        for pageName, page in pairs(gui.pages) do
            page.Visible = (pageName == name)
        end
    end)
    
    gui.pages[name] = page
    gui.buttons[name] = {
        button = button,
        line = line,
        gradient = selectionGradient
    }
    
    return page
end

function UI:SetupNavigation(gui)
    -- Ativar primeira página
    local firstName = next(gui.buttons)
    if firstName then
        local firstData = gui.buttons[firstName]
        firstData.button.TextColor3 = Color3.fromRGB(0, 255, 0)
        firstData.line.Visible = true
        if firstData.gradient then
            firstData.gradient.Visible = true
        end
        gui.pages[firstName].Visible = true
    end
end

function UI:MakeDraggable(frame, sideMenu)
    local dragging = false
    local dragStart
    local startPos
    
    sideMenu.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    sideMenu.InputEnded:Connect(function(input)
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
