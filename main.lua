-- main.lua - S3IKY HACK
local repo = "https://raw.githubusercontent.com/whatsappbanned13-pixel/malignant/main/"

-- Função para carregar módulos
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

-- Carregar configurações (pastas em minúsculas)
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
local gui = UI:CreateMainGui("S3IKY HACK", Settings.mainColor)

-- Carregar módulos (opcionais)
local modules = {
    Fly = loadModule("modules/fly.lua")
    -- Adicione mais módulos aqui depois
}

-- Inicializar módulos
for name, module in pairs(modules) do
    if module and module.Init then
        module:Init(gui, Settings, Elements)
        print("✅ Módulo carregado: " .. name)
    end
end

-- Finalizar
Init:Finish(gui)

print("🎯 S3IKY HACK pronto! Pressione CTRL para abrir")
