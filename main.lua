local UI = loadstring(game:HttpGet("Sua_URL_Para_UI.lua"))()
local Elements = loadstring(game:HttpGet("Sua_URL_Para_Elements.lua"))()

local Main = UI:CreateMainGui("Malignant")

-- Página de Combate
local CombatPage = UI:AddPage(Main, "Combat")
local AimbotSection = Elements:CreateSection(CombatPage, "Aimbot Settings")
local AutoClickSection = Elements:CreateSection(CombatPage, "Autoclicker")

Elements:CreateToggle(AimbotSection, "Enable Aimbot", false, function(v)
    print("Aimbot:", v)
end)

Elements:CreateSlider(AimbotSection, "Smoothness", 1, 20, 5, function(v)
    print("Smooth:", v)
end)

Elements:CreateToggle(AutoClickSection, "Enable Autoclick", false, function(v)
    print("Autoclick:", v)
end)

-- Ativar primeira página por padrão
Main.buttons["Combat"].Button.TextColor3 = Color3.fromRGB(0, 200, 0)
Main.buttons["Combat"].Indicator.Visible = true
Main.pages["Combat"].Visible = true

print("Malignant carregado com sucesso!")
