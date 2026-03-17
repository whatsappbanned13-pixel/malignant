-- main.lua - MALIGNANT HACK (Design NOVA)
local repo = "https://raw.githubusercontent.com/whatsappbanned13-pixel/malignant/main/"

local function getUrl(path)
    return repo .. path .. "?nocache=" .. math.random(1000000, 9999999)
end

local function loadModule(path)
    local url = getUrl(path)
    print("📥 Carregando: " .. path)
    local content = game:HttpGet(url)
    local fn = loadstring(content)
    if not fn then
        warn("❌ Erro ao compilar: " .. path)
        return nil
    end
    return fn()
end

print("🚀 Iniciando MALIGNANT HACK...")

local Settings = loadModule("config/settings.lua")
local Places = loadModule("config/places.lua")
local Init = loadModule("core/init.lua")
local UI = loadModule("core/ui.lua")

if not Settings or not Places or not Init or not UI then
    warn("❌ Erro: Módulos principais não carregaram")
    return
end

Init:Setup(Settings, Places)
local gui = UI:CreateMainGui("MALIGNANT", Settings.mainColor)

-- =============== CRIAR ABAS ===============
local tabs = {
    {"combat", "Combat"},
    {"visuals", "Visuals"},
    {"movement", "Movement"},
    {"exploits", "Exploits"}
}

for _, tabInfo in ipairs(tabs) do
    UI:AddTab(gui, tabInfo[1], tabInfo[2])
end

-- =============== POPULAR PAINEL ESQUERDO ===============
local leftContainer = gui.leftPanel:FindFirstChild("LeftContainer")

-- Seção Aimbot
UI:CreateConfigSection(leftContainer, "Aimbot Settings")

-- Aim nearest
UI:CreateToggle(leftContainer, "Aim nearest (world)", false, function(state)
    print("Aim nearest:", state)
end)

-- Aim radius
UI:CreateSlider(leftContainer, "Aims radius (world)", 1, 10, 3, "", function(value)
    print("Radius:", value)
end)

-- Aimspeed
UI:CreateSlider(leftContainer, "Aimspeed", 0.1, 2, 0.6, "", function(value)
    print("Aimspeed:", value)
end)

-- Aim height
UI:CreateSlider(leftContainer, "Aim height", 0, 2, 0.5, "", function(value)
    print("Aim height:", value)
end)

-- Aim FOV
UI:CreateSlider(leftContainer, "Aim FOV (px)", 50, 500, 300, "", function(value)
    print("FOV:", value)
end)

-- =============== POPULAR PAINEL DIREITO ===============
local rightContainer = gui.rightPanel:FindFirstChild("RightContainer")

-- Seção Autoclicker
UI:CreateConfigSection(rightContainer, "Autoclicker")

-- Autoclicker Enabled
UI:CreateToggle(rightContainer, "Autoclicker Enabled", false, function(state)
    print("Autoclicker:", state)
end)

-- Autoclicker Key
UI:CreateToggle(rightContainer, "Autoclicker Key: None", false, function(state)
    print("Key toggle:", state)
end)

-- CPS
UI:CreateSlider(rightContainer, "CPS", 1, 20, 1, "CPS", function(value)
    print("CPS:", value)
end)

-- Inventory fill
UI:CreateToggle(rightContainer, "inventory fill", false, function(state)
    print("Inventory fill:", state)
end)

-- Right clicker
UI:CreateToggle(rightContainer, "Right clicker", false, function(state)
    print("Right clicker:", state)
end)

UI:SetupTabs(gui)
Init:Finish(gui)

print("🎯 MALIGNANT HACK pronto! Pressione CTRL para abrir")
print("✅ Design NOVA carregado!")
