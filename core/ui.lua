local UI = {}
local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

-- Cores do Tema Verde Forte
local theme = {
    bg = Color3.fromRGB(10, 15, 10),
    side = Color3.fromRGB(5, 10, 5),
    accent = Color3.fromRGB(0, 200, 0), -- Verde Forte
    text = Color3.fromRGB(200, 255, 200),
    darkText = Color3.fromRGB(0, 100, 0)
}

function UI:CreateMainGui(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MALIGNANT_V2"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 800, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -400, 0.5, -225)
    mainFrame.BackgroundColor3 = theme.bg
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true -- Nota: Draggable é legado, mas funciona para testes rápidos
    mainFrame.Parent = screenGui

    -- Borda Neon Verde
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = theme.accent
    border.BorderSizePixel = 0
    border.ZIndex = 0
    border.Parent = mainFrame

    -- Menu Lateral
    local sideMenu = Instance.new("Frame")
    sideMenu.Name = "SideMenu"
    sideMenu.Size = UDim2.new(0, 180, 1, 0)
    sideMenu.BackgroundColor3 = theme.side
    sideMenu.BorderSizePixel = 0
    sideMenu.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 60)
    titleLabel.Text = title:upper()
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextColor3 = theme.accent
    titleLabel.TextSize = 22
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = sideMenu

    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 1, -70)
    buttonContainer.Position = UDim2.new(0, 0, 0, 70)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = sideMenu

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = buttonContainer

    -- Área de Conteúdo
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentContainer"
    contentArea.Size = UDim2.new(1, -190, 1, -10)
    contentArea.Position = UDim2.new(0, 185, 0, 5)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = mainFrame

    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        contentContainer = contentArea,
        sideMenu = sideMenu,
        pages = {},
        buttons = {}
    }
end

function UI:AddPage(gui, name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = theme.accent
    page.Visible = false
    page.Parent = gui.contentContainer

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0.5, -10, 0, 200) -- Colunas estilo Nolva
    grid.CellPadding = UDim2.new(0, 15, 0, 15)
    grid.Parent = page

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = theme.side
    btn.BorderSizePixel = 0
    btn.Text = "  " .. name:upper()
    btn.TextColor3 = theme.text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = gui.mainFrame.SideMenu.ButtonContainer

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 4, 1, 0)
    indicator.BackgroundColor3 = theme.accent
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = btn

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(gui.pages) do p.Visible = false end
        for _, b in pairs(gui.buttons) do 
            b.TextColor3 = theme.text
            b.Indicator.Visible = false 
        end
        page.Visible = true
        btn.TextColor3 = theme.accent
        indicator.Visible = true
    end)

    gui.pages[name] = page
    gui.buttons[name] = {Button = btn, Indicator = indicator}
    return page
end

return UI
