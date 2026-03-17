local Elements = {}
local accent = Color3.fromRGB(0, 255, 70)

function Elements:NewSection(parent, title)
    local s = Instance.new("Frame", parent)
    s.BackgroundColor3 = Color3.fromRGB(15, 20, 15)
    s.BorderSizePixel = 0
    
    local h = Instance.new("TextLabel", s)
    h.Size = UDim2.new(1, 0, 0, 25)
    h.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
    h.Text = " " .. title
    h.Font = Enum.Font.GothamBold
    h.TextColor3 = accent
    h.TextXAlignment = Enum.TextXAlignment.Left
    h.BorderSizePixel = 0

    local holder = Instance.new("Frame", s)
    holder.Size = UDim2.new(1, -10, 1, -30)
    holder.Position = UDim2.new(0, 5, 0, 30)
    holder.BackgroundTransparency = 1
    
    Instance.new("UIListLayout", holder).Padding = UDim.new(0, 5)
    return holder
end

function Elements:NewToggle(parent, text, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 25)
    f.BackgroundTransparency = 1

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -40, 1, 0)
    l.Text = text
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.Gotham
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextButton", f)
    box.Size = UDim2.new(0, 35, 0, 18)
    box.Position = UDim2.new(1, -35, 0.5, -9)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.Text = ""
    box.BorderSizePixel = 0

    local state = false
    box.MouseButton1Click:Connect(function()
        state = not state
        box.BackgroundColor3 = state and accent or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

return Elements
