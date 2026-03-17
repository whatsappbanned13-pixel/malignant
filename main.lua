-- main.lua - S3IKY HACK V3
local repo = "https://raw.githubusercontent.com/whatsappbanned13-pixel/malignant/main/"

local function loadModule(path)
    local url = repo .. path
    print("📥 Carregando: " .. path)
    
    local content = game:HttpGet(url)
    local fn = loadstring(content)
    if not fn then
        warn("❌ Erro ao compilar: " .. path)
        return nil
    end
    
    return fn()
end

print("🚀 Iniciando S3IKY HACK...")

-- Carregar configurações
local Settings = loadModule("config/settings.lua")
local Places = loadModule("config/places.lua")

-- Carregar core
local Init = loadModule("core/init.lua")
local UI = loadModule("core/ui.lua")

-- Carregar GUI
local Elements = loadModule("gui/elements.lua")

-- Verificar se tudo carregou
if not Settings or not Places or not Init or not UI or not Elements then
    warn("❌ Erro: Módulos principais não carregaram")
    return
end

print("✅ Configurações carregadas")

-- Inicializar
Init:Setup(Settings, Places)

-- Criar GUI
local gui = UI:CreateMainGui("S3IKY HACK V3", Settings.mainColor)

-- =============================================
-- CRIAR AS PÁGINAS MANUALMENTE (SOLUÇÃO TEMPORÁRIA)
-- =============================================

-- Página Movimento
local movePage = UI:AddPage(gui, "Movimento", "Movimento")
local moveContainer = Elements:CreateContainer(movePage, 400)

-- Botão Fly (teste)
Elements:CreateToggle(moveContainer, "Fly Teste", false, function(state)
    print("Fly:", state)
end, Settings.mainColor)

-- Página Aimbot
local aimPage = UI:AddPage(gui, "Aimbot", "Aimbot")
local aimContainer = Elements:CreateContainer(aimPage, 200)
Elements:CreateToggle(aimContainer, "Aimbot", false, function(state)
    print("Aimbot:", state)
end, Settings.mainColor)

-- Página Visuais
local visPage = UI:AddPage(gui, "Visuais", "Visuais")
local visContainer = Elements:CreateContainer(visPage, 200)
Elements:CreateToggle(visContainer, "ESP", false, function(state)
    print("ESP:", state)
end, Settings.mainColor)

-- Página Teleport
local telePage = UI:AddPage(gui, "Teleport", "Teleport")
local teleContainer = Elements:CreateContainer(telePage, 200)
Elements:CreateToggle(teleContainer, "Teleport", false, function(state)
    print("Teleport:", state)
end, Settings.mainColor)

-- Página Grudar
local stickPage = UI:AddPage(gui, "Grudar", "Grudar")
local stickContainer = Elements:CreateContainer(stickPage, 200)
Elements:CreateToggle(stickContainer, "Grudar", false, function(state)
    print("Grudar:", state)
end, Settings.mainColor)

-- Página Lugares
local placesPage = UI:AddPage(gui, "Lugares", "Lugares")
local placesContainer = Elements:CreateContainer(placesPage, 400)

-- Criar botões para cada lugar
for name, data in pairs(Places) do
    Elements:CreateToggle(placesContainer, name, false, function(state)
        print("Ir para:", name)
    end, data.color or Settings.mainColor)
end

-- Configurar navegação
UI:SetupNavigation(gui)

-- Finalizar
Init:Finish(gui)

print("🎯 S3IKY HACK pronto! Pressione CTRL para abrir")
print("✅ Páginas criadas:", #gui.pages)
