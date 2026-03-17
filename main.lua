-- MAIN EMERGÊNCIA - TUDO NUM ARQUIVO SÓ
local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "S3IKY"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.8,0,0,50)
btn.Position = UDim2.new(0.5,-120,0.5,-25)
btn.Text = "TESTE"
btn.Parent = frame

print("✅ GUI de emergência carregada!")
