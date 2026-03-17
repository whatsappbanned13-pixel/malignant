local UI = {}
local player = game:GetService("Players").LocalPlayer

-- Configuração de Cores (Verde Matrix)
local theme = {
    main_bg = Color3.fromRGB(8, 12, 8),
    side_bg = Color3.fromRGB(5, 8, 5),
    accent = Color3.fromRGB(0, 255, 70), -- Verde Forte
    text = Color3.fromRGB(200, 255, 200),
    dark_green = Color3.fromRGB(0, 50, 0)
}

function UI:CreateMainGui(title)
    local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    sg.Name = "Malignant_Green"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame", sg)
    main.Name = "Main"
    main.Size = UDim2.new(0, 820, 0, 460)
    main.Position = UDim2.new(0.5, -410, 0.5, -230)
    main.BackgroundColor3 = theme.main_bg
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true -- Para facilitar o movimento

    -- Linha de brilho no topo
    local line = Instance.new("Frame", main)
    line.Size = UDim2.new(1, 0, 0, 2)
    line.BackgroundColor3 = theme.accent
    line.BorderSizePixel = 0

    -- Menu Lateral
    local side = Instance.new("Frame", main)
    side.Size = UDim2.new(0, 190, 1, 0)
    side.BackgroundColor3 = theme.side_bg
    side.BorderSizePixel = 0

    local t = Instance.new("TextLabel", side)
    t.Size = UDim2.new(1, 0, 0, 60)
    t.Text = title:upper()
    t.Font = Enum.Font.GothamBlack
    t.TextSize = 22
    t.TextColor3 = theme.accent
    t.BackgroundTransparency = 1

    local btnContainer = Instance.new("Frame", side)
    btnContainer.Size = UDim2.new(1, 0, 1, -70)
    btnContainer.Position = UDim2.new(0, 0, 0, 70)
    btnContainer.BackgroundTransparency = 1

    Instance.new("UIListLayout", btnContainer).SortOrder = Enum.SortOrder.LayoutOrder

    -- Área onde as páginas aparecem
    local content = Instance.new("Frame", main)
    content.Name = "Content"
    content.Size = UDim2.new(1, -210, 1, -20)
    content.Position = UDim2.new(0, 200, 0, 10)
    content.BackgroundTransparency = 1

    return {
        sg = sg,
        content = content,
        container = btnContainer,
        pages = {},
        buttons = {}
    }
end

function UI:AddPage(gui, name)
    local page = Instance.new("ScrollingFrame", gui.content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = theme.accent

    local grid = Instance.new("UIGridLayout", page)
    grid.CellSize = UDim2.new(0.5, -10, 0, 220)
    grid.CellPadding = UDim2.new(0, 15, 0, 15)

    local b = Instance.new("TextButton", gui.container)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = theme.side_bg
    b.BorderSizePixel = 0
    b.Text = "  " .. name
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.fromRGB(150, 150, 150)
    b.TextXAlignment = Enum.TextXAlignment.Left

    b.MouseButton1Click:Connect(function()
        for _, p in pairs(gui.pages) do p.Visible = false end
        for _, btn in pairs(gui.buttons) do btn.TextColor3 = Color3.fromRGB(150, 150, 150) end
        page.Visible = true
        b.TextColor3 = theme.accent
    end)

    gui.pages[name] = page
    gui.buttons[name] = b
    return page
end

return UI
