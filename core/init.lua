-- Core/Init.lua
local Init = {}

local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

function Init:Setup(config, places)
    self.config = config
    self.places = places
    self.player = player
    self.userInputService = userInputService
    
    -- Aguardar carregamento
    wait(1)
    
    -- Remover GUI antiga se existir
    local existing = player.PlayerGui:FindFirstChild(config.menuName)
    if existing then
        existing:Destroy()
    end
    
    print("⚙️ Configurações carregadas")
end

function Init:Finish(gui)
    -- Tecla para abrir/fechar menu
    userInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.config.menuKeybind then
            wait(0.1)
            gui.mainFrame.Visible = not gui.mainFrame.Visible
        end
    end)
    
    -- Notificação
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = self.config.menuName,
        Text = "Pressione CTRL para abrir",
        Duration = 3
    })
end

return Init