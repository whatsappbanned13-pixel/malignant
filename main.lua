-- Dentro do loop de criação de páginas no main.lua:

elseif pageName == "Aimbot" then
    -- Criamos um layout de grade ou horizontal para as duas colunas
    local columnContainer = Instance.new("Frame")
    columnContainer.Size = UDim2.new(1, 0, 1, 0)
    columnContainer.BackgroundTransparency = 1
    columnContainer.Parent = page

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.Padding = UDim.new(0, 10)
    layout.Parent = columnContainer

    -- COLUNA 1: Aimbot Settings
    local col1 = Elements:CreateContainer(columnContainer, "Aimbot Settings", 350)
    Elements:CreateToggle(col1, "Aim nearest (world)", false, function(s) end, purpleColor)
    Elements:CreateSlider(col1, "Aim radius (world)", 0, 10, 3.0, function(v) end)
    Elements:CreateSlider(col1, "Aim speed", 0, 1, 0.60, function(v) end)
    Elements:CreateSlider(col1, "Aim FOV (px)", 0, 1000, 300, function(v) end)

    -- COLUNA 2: Autoclicker
    local col2 = Elements:CreateContainer(columnContainer, "Autoclicker", 350)
    Elements:CreateToggle(col2, "Autoclicker Enabled", false, function(s) end, purpleColor)
    Elements:CreateSlider(col2, "CPS", 1, 20, 10, function(v) end)
    Elements:CreateToggle(col2, "Right clicker", false, function(s) end, purpleColor)
