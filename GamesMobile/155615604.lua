local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/Arceus-X-UI-Library/main/source.lua"))()
GuiLibrary:SetTitle("Smoke Client [BETA] | Mobile")
GuiLibrary:SetTheme("TomorrowNightBlue")

--Loaded
loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeXClient/main/Resources/Detector.lua", true))()

--Variables
local Players = game:GetService("Players")
local Anim = Players.LocalPlayer.Character.Animate
local Mouse = Players.LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Char = Players.LocalPlayer.Character
local Hum = Char.Humanoid
local HumRootPart = Char:WaitForChild("HumanoidRootPart")
local MeleeEvent = ReplicatedStorage:WaitForChild("meleeEvent")
local Item = game:GetService("Workspace").Remote:WaitForChild("ItemHandler")

--Features Variables
local NightVar = false
local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local msg = {""}
local KillAuraVar = false
local SprintVar = false

--Features
GuiLibrary:AddToggle("Night", function(callback)
    if callback then
        NightVar = true
        while NightVar and task.wait(.3) do
            Lighting.TimeOfDay = "00:00:00"
        end
    else
        NightVar = false
        wait(.3)
        Lighting.TimeOfDay = "13:00:00"
    end
end, false)

GuiLibrary:AddToggle("ChatDisabler", function(callback)
    if callback then
        local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end)
        if succ then
            -- disabled
        elseif err then
            -- error
        end
    else
        local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
        if succ then
            -- restored
        elseif err then
            -- error
        end
    end
end, false)

GuiLibrary:AddToggle("ChatSpammer", function(callback)
    if callback then
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatServiceSpam = true
            while TextChatServiceSpam do
                game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
                wait(.5)
            end
        elseif game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService then
            LegacyChatServiceSpam = true
            while LegacyChatServiceSpam do
                ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(msg, "All")
                wait(.5)
            end
        end
    else
        TextChatServiceSpam = false
        LegacyChatServiceSpam = false
    end
end, false)

--Game Features
GuiLibrary:AddButton("AutoGuns", function()
    HumRootPart.CFrame = CFrame.new(823.260498, 99.9899826, 2253.3291, 1, -8.28284996e-10, -0.000169262014, 8.28318247e-10, 1, 1.96093281e-10, 0.000169262014, -1.96233474e-10, 1)
    wait(.2)
    Item:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
    Item:InvokeServer(workspace.Prison_ITEMS.giver.M9.ITEMPICKUP)
    wait(.1)
    HumRootPart.CFrame = CFrame.new(-937.466064, 94.1287613, 2061.44702, -0.0350593626, 2.13304414e-08, -0.999385238, 3.84639947e-08, 1, 1.9994209e-08, 0.999385238, -3.77393619e-08, -0.0350593626)
    wait(.2)
    Item:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
    wait(.1)
    HumRootPart.CFrame = CFrame.new(931.399658, 99.9899826, 2388.50073, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

GuiLibrary:AddComboBox("SelectTeam", {"Inmates", "Guards", "Criminals"}, function(Value)
    if Value == "Inmates" then
        workspace.Remote.TeamEvent:FireServer("Bright orange")
    elseif Value == "Guards" then
        workspace.Remote.TeamEvent:FireServer("Bright blue")
    elseif Value == "Criminals" then
        HumRootPart.CFrame = CFrame.new(-921.168884, 95.327179, 2144.69336, -0.0187869966, 2.35240947e-08, -0.999823511, -3.93195201e-08, 1, 2.42670737e-08, 0.999823511, 3.97684872e-08, -0.0187869966)
        wait(.2)
        HumRootPart.CFrame = CFrame.new(931.399658, 99.9899826, 2388.50073, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    end
end)

GuiLibrary:AddToggle("KillAura", function(callback)
    if callback then
        KillAuraVar = true
        while KillAuraVar and task.wait() do
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    MeleeEvent:FireServer(player)
                end
            end
        end
    else
        KillAuraVar = false
    end
end, false)

GuiLibrary:AddToggle("Sprint", function(callback)
    if callback then
        SprintVar = true
        while SprintVar and task.wait() do
            Hum.WalkSpeed = 25
        end
    else
        SprintVar = false
        Hum.WalkSpeed = 16
    end
end, false)