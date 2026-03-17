-- Função para carregar com segurança
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then return result end
    warn("Falha ao carregar: " .. url)
    return nil
end

-- IMPORTANTE: Coloque seus links RAW aqui
local UI = SafeLoad("LINK_DO_SEU_UI_LUA")
local Elements = SafeLoad("LINK_DO_SEU_ELEMENTS_LUA")

if UI and Elements then
    local App = UI:CreateMainGui("Malignant")
    
    -- Exemplo: Página Combat
    local CombatPage = UI:AddPage(App, "Combat")
    
    local AimbotCol = Elements:NewSection(CombatPage, "Aimbot Settings")
    Elements:NewToggle(AimbotCol, "Enabled", function(v) print("Aimbot:", v) end)
    Elements:NewToggle(AimbotCol, "Aim Nearest", function(v) end)

    local ClickCol = Elements:NewSection(CombatPage, "Autoclicker")
    Elements:NewToggle(ClickCol, "Active", function(v) end)
    
    -- Ativar padrão
    App.pages["Combat"].Visible = true
    App.buttons["Combat"].TextColor3 = Color3.fromRGB(0, 255, 70)
else
    print("Erro crítico: Módulos não encontrados.")
end
