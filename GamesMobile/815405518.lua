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

--Features Variables
local NightVar = false
local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local msg = {""}

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
GuiLibrary:AddToggle("AutoFarm", function(callback)
    if callback then
        Anim.Disabled = true
        HumRootPart.CFrame = CFrame.new(0.791430056, 116.820633, -186.754868, -0.981703579, 1.53577525e-06, -0.190415546, 1.56365259e-05, 1, -7.25500504e-05, 0.190415546, -7.42000775e-05, -0.981703579)
        Char:FindFirstChild("Head").Anchored = true
        Char:FindFirstChild("UpperTorso").Anchored = true
        Char:FindFirstChild("UpperTorso").Anchored = true
    else
        Anim.Disabled = false
        Char:FindFirstChild("Head").Anchored = false
        Char:FindFirstChild("UpperTorso").Anchored = false
        Char:FindFirstChild("UpperTorso").Anchored = false
    end
end, false)