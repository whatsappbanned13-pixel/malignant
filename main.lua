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

-- Lista de módulos para carregar
local moduleNames = {
    "fly"
    -- Adicione mais módulos aqui: "speed", "infinitejump", "aimbot", "esp
