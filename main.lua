-- main.lua - MALIGNANT HACK (Carregador de Módulos)
local repo = "https://raw.githubusercontent.com/whatsappbanned13-pixel/malignant/main/"

-- =============== ANTI-CACHE ===============
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
local gui = UI:CreateMainGui("MALIGNANT", Settings.mainColor)

-- =============== CRIAR PÁGINAS ===============

-- Lista de todas as páginas
local pages = {
    {"Movimento", "Movimento"},
    {"Aimbot", "Aimbot"},
    {"Visuais", "Visuais"},
    {"Teleport", "Teleport"},
    {"Grudar", "Grudar"},
    {"Lugares", "Lugares"}
}

-- Criar cada página
for _, pageInfo in ipairs(pages) do
    local pageName = pageInfo[1]
    local pageTitle = pageInfo[2]
    
    local page = UI:AddPage(gui, pageName, pageTitle)
    
    -- Adicionar container em cada página
    if pageName == "Movimento" then
        local container = Elements:CreateContainer(page, 400)
        Elements:CreateToggle(container, "Fly", false, function(state)
            print("Fly:", state)
        end, Settings.mainColor)
    elseif pageName == "Aimbot" then
        local container = Elements:CreateContainer(page, 200)
        Elements:CreateToggle(container, "Aimbot", false, function(state)
            print("Aimbot:", state)
        end, Settings.mainColor)
    elseif pageName == "Visuais" then
        local container = Elements:CreateContainer(page, 200)
        Elements:CreateToggle(container, "ESP", false, function(state)
            print("ESP:", state)
        end, Settings.mainColor)
    elseif pageName == "Teleport" then
        local container = Elements:CreateContainer(page, 200)
        Elements:CreateToggle(container, "Teleport", false, function(state)
            print("Teleport:", state)
        end, Settings.mainColor)
    elseif pageName == "Grudar" then
        local container = Elements:CreateContainer(page, 200)
        Elements:CreateToggle(container, "Grudar", false, function(state)
            print("Grudar:", state)
        end, Settings.mainColor)
    elseif pageName == "Lugares" then
        local container = Elements:CreateContainer(page, 400)
        for name, data in pairs(Places) do
            Elements:CreateToggle(container, name, false, function(state)
                print("Ir para:", name)
            end, data.color or Settings.mainColor)
        end
    end
end

-- Carregar módulo Fly (se existir)
local Fly = loadModule("modules/fly.lua")
if Fly and Fly.Init then
    Fly:Init(gui, UI, Settings, Elements)
    print("✅ Fly carregado")
end

-- Configurar navegação
UI:SetupNavigation(gui)

-- Finalizar
Init:Finish(gui)

print("🎯 MALIGNANT HACK pronto! Pressione CTRL para abrir")
print("✅ Design final carregado!")
