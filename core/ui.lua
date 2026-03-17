-- Trechos específicos para alterar no seu UI:CreateMainGui e UI:AddPage

-- No mainFrame:
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fundo mais escuro

-- No SideMenu (Botões):
-- Altere a cor do texto padrão e a cor de seleção
local purpleColor = Color3.fromRGB(231, 84, 255)

function UI:AddPage(gui, name, buttonText)
    -- ... (código anterior)
    
    -- Botão lateral estilo Nolva
    button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold -- Fonte mais limpa
    
    -- GRADIENTE LATERAL (Igual à foto, apenas uma bordinha ou sombra roxa)
    local selectionGradient = Instance.new("UIGradient")
    selectionGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, purpleColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    selectionGradient.Transparency = NumberSequence.new(0.8) -- Bem sutil
    selectionGradient.Enabled = false
    selectionGradient.Parent = button

    -- Evento de Clique (Corrigindo para Roxo)
    button.MouseButton1Click:Connect(function()
        -- Resetar outros
        for _, btnData in pairs(gui.buttons) do
            btnData.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            btnData.gradient.Enabled = false
        end
        -- Ativar
        button.TextColor3 = purpleColor
        selectionGradient.Enabled = true
        -- ... (restante da lógica de troca de página)
    end)
end
