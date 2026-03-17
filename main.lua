-- main.lua - S3IKY HACK V3 (COM ANTI-CACHE)
local repo = "https://raw.githubusercontent.com/whatsappbanned13-pixel/malignant/main/"

-- =============== ANTI-CACHE ===============
-- Adiciona um número aleatório na URL para forçar recarregar
local function getUrl(path)
    return repo .. path .. "?nocache=" .. math.random(1000000, 9999999)
end

-- Função para carregar módulos com anti-cache
local function loadModule(path)
    local url = getUrl(path)
    print("📥 Carregando: " .. path .. " (cache bypass)")
    
    local content = game:HttpGet(url)
    local fn = loadstring(content)
    if not fn then
        warn("❌ Erro ao compilar: " .. path)
        return nil
    end
    
    return fn()
end

print("🚀 Iniciando S3IKY HACK...")

-- Forçar pré-carregamento dos principais
game:GetService("ContentProvider"):Preload(getUrl("core/ui.lua"))
wait(0.5)

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

-- Criar GUI (AGORA VAI CARREGAR A NOVA VERSÃO!)
local gui = UI:CreateMainGui("S3IKY HACK V3", Settings.mainColor)

-- Página Movimento
local movePage = UI:AddPage(gui, "Movimento", "Movimento")
local moveContainer = Elements:CreateContainer(movePage, 400)

-- Carregar módulo Fly
local Fly = loadModule("modules/fly.lua")
if Fly and Fly.Init then
    Fly:Init(gui, UI, Settings, Elements)
    print("✅ Fly carregado")
end

-- Criar outras páginas
local aimPage = UI:AddPage(gui, "Aimbot", "Aimbot")
local aimContainer = Elements:CreateContainer(aimPage, 200)
Elements:CreateToggle(aimContainer, "Aimbot", false, function(state)
    print("Aimbot:", state)
end, Settings.mainColor)

local visPage = UI:AddPage(gui, "Visuais", "Visuais")
local visContainer = Elements:CreateContainer(visPage, 200)
Elements:CreateToggle(visContainer, "ESP", false, function(state)
    print("ESP:", state)
end, Settings.mainColor)

local telePage = UI:AddPage(gui, "Teleport", "Teleport")
local teleContainer = Elements:CreateContainer(telePage, 200)
Elements:CreateToggle(teleContainer, "Teleport", false, function(state)
    print("Teleport:", state)
end, Settings.mainColor)

local stickPage = UI:AddPage(gui, "Grudar", "Grudar")
local stickContainer = Elements:CreateContainer(stickPage, 200)
Elements:CreateToggle(stickContainer, "Grudar", false, function(state)
    print("Grudar:", state)
end, Settings.mainColor)

-- Página Lugares
local placesPage = UI:AddPage(gui, "Lugares", "Lugares")
local placesContainer = Elements:CreateContainer(placesPage, 400)

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
print("✅ Design NOVO carregado! Neve caindo ❄️")
