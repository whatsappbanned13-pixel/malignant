-- MAIN.lua - S3IKY HACK V3
-- GitHub: https://github.com/seuusuario/S3IKY-HACK

local repo = "raw.githubusercontent.com/seuusuario/S3IKY-HACK/main/"

-- Função para carregar módulos com segurança
local function loadModule(path)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(repo .. path))()
    end)
    if not success then
        warn("❌ Erro ao carregar: " .. path)
        return nil
    end
    return module
end

-- Carregar configurações primeiro
local Config = loadModule("Config/Settings.lua")
local Places = loadModule("Config/Places.lua")

-- Carregar core
local Init = loadModule("Core/Init.lua")
local UI = loadModule("Core/UI.lua")

-- Inicializar core
Init:Setup(Config, Places)

-- Criar GUI principal
local gui = UI:CreateMainGui("S3IKY HACK V3", Config.mainColor)

-- Lista de módulos para carregar
local modules = {
    "Fly",
    "Speed", 
    "InfiniteJump",
    "Aimbot",
    "ESP",
    "Stick",
    "Teleport"
}

-- Carregar cada módulo
for _, moduleName in ipairs(modules) do
    local module = loadModule("Modules/" .. moduleName .. ".lua")
    if module then
        module:Init(gui, Config, Places)
        print("✅ Carregado: " .. moduleName)
    end
end

-- Configurar navegação entre páginas
UI:SetupNavigation(gui)

-- Finalizar
Init:Finish(gui)
print("🎯 S3IKY HACK pronto! Pressione CTRL para abrir")
