-- GUI/Elements.lua
local Elements = {}

local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

function Elements:CreateSection(parent, title, color)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 30)
    section.BackgroundTransparency = 1
    section.Parent = parent
    section.ZIndex = 5
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = color or Color3.fromRGB(255, 0, 0)
    line.BorderSizePixel = 0
    line.ZIndex = 6
    line.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = color or Color3.fromRGB(255, 0, 0)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 6
    titleLabel.Parent = section
    
    return section
end

function Elements:CreateContainer(parent, height)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, height or 150)
    container.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    container.Parent = parent
    container.ZIndex = 5
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container
    
    return container
end

function Elements:CreateToggle(parent, text, default, callback, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    frame.Parent = parent
    frame.ZIndex = 5
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 4)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "Toggle"
    toggleFrame.Size = UDim2.new(0, 50, 0, 24)
    toggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.ZIndex = 6
    toggleFrame.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 24, 0, 24)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Text = ""
    toggleButton.ZIndex = 7
    toggleButton.Parent = toggleFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = toggleButton
    
    local enabled = default or false
    
    local function updateToggle()
        if enabled then
            tweenService:Create(toggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -24, 0, 0)}):Play()
            toggleFrame.BackgroundColor3 = color or Color3.fromRGB(255, 0, 0)
        else
            tweenService:Create(toggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end
    
    updateToggle()
    
    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
        if callback then
            callback(enabled)
        end
    end)
    
    return frame, enabled
end

function Elements:CreateSlider(parent, text, min, max, default, callback, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    frame.Parent = parent
    frame.ZIndex = 5
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 4)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 40, 0, 20)
    valueLabel.Position = UDim2.new(1, -50, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = color or Color3.fromRGB(255, 0, 0)
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = 6
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 6)
    sliderBg.Position = UDim2.new(0, 10, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBg.ZIndex = 6
    sliderBg.Parent = frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = sliderBg
    
    local percent = (default - min) / (max - min)
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    sliderFill.BackgroundColor3 = color or Color3.fromRGB(255, 0, 0)
    sliderFill.ZIndex = 7
    sliderFill.Parent = sliderBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Position = UDim2.new(percent, -8, 0, -5)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.ZIndex = 8
    sliderButton.Parent = sliderBg
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = sliderButton
    
    local dragging = false
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
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
            sliderButton.Position = UDim2.new(newPercent, -8, 0, -5)
            valueLabel.Text = tostring(value)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return frame
end

function Elements:CreateKeybind(parent, text, defaultKey, callback, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    frame.Parent = parent
    frame.ZIndex = 5
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 4)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local keyButton = Instance.new("TextButton")
    keyButton.Size = UDim2.new(0, 60, 0, 25)
    keyButton.Position = UDim2.new(1, -70, 0.5, -12.5)
    keyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyButton.Text = defaultKey
    keyButton.TextColor3 = color or Color3.fromRGB(255, 0, 0)
    keyButton.TextScaled = true
    keyButton.Font = Enum.Font.GothamBold
    keyButton.ZIndex = 7
    keyButton.Parent = frame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 4)
    keyCorner.Parent = keyButton
    
    local listening = false
    
    keyButton.MouseButton1Click:Connect(function()
        listening = true
        keyButton.Text = "..."
        keyButton.TextColor3 = Color3.fromRGB(255, 255, 0)
    end)
    
    userInputService.InputBegan:Connect(function(input)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local key = input.KeyCode.Name
                keyButton.Text = key
                keyButton.TextColor3 = color or Color3.fromRGB(255, 0, 0)
                listening = false
                if callback then
                    callback(key)
                end
            end
        end
    end)
    
    return frame
end

return Elements