local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/Arceus-X-UI-Library/main/source.lua"))()
GuiLibrary:SetTitle("Smoke Client [BETA] | Mobile")
GuiLibrary:SetTheme("TomorrowNightBlue")

--Loaded
loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeXClient/main/Resources/Detector.lua", true))()

--Variables
local Players = game:GetService("Players")
local Anim = Players.LocalPlayer.Character.Animate
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Char = Players.LocalPlayer.Character
local Hum = Char.Humanoid
local HumRootPart = Char:WaitForChild("HumanoidRootPart")
local HitRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Hit")
local RebirthRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Rebirth")
local LocalPlayer = Players.LocalPlayer
local InteractivesPartsFolder = workspace.Interactives
local PlrKills = Players.LocalPlayer.GameStats.Kills.Value
local WatermarkMsg = "| Smxke on top!"

--Features Variables
local NightVar = false
local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local msg = {"Smoke Client on top"}
local InstaKillAuraVar = false
local AutoToxicVar = false
local WaterMarkSpam = false

--Lists
local DamageParts = {
    "TopMesh3",
    "TopMesh2",
    "TopMesh1",
    "MiddleMesh3",
    "MiddleMesh2",
    "MiddleMesh1",
    "LowerMesh3",
    "LowerMesh2",
    "LowerMesh1",
    "Water3",
    "Water2",
    "Water1"
}
local Messages = {
    "L everyone, + %d kills for me.",
    "Easy game, already %d kills.",
    "How you lost in a block game bro, maybe you don't have a gaming chair like mine got %d kills.",
    "L TRASH KIDS + %d kills.",
    "I never thought someone could be this bad but here we are lol, imagine not having + %d kills little man."
}
local GodModeParts = {
    "Safezone",
    "Safezone2",
    "Safezone3",
    "Safezone4"
}
local WaterMarkMsgs = {
    "Bad? get better with Smxke",
    "If you don't have skill like I do then just use the Smxke Client",
    "Imagine losing because you don't have the Smxke Client",
    "Smxke Client on top!",
}

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
GuiLibrary:AddToggle("InstaKillAura", function(callback)
    if callback then
        InstaKillAuraVar = true
        while InstaKillAuraVar and wait() do
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    HitRemote:FireServer(player)
                end
            end
        end
    else
        InstaKillAuraVar = false
    end
end, false)

GuiLibrary:AddToggle("AutoRebirth", function(callback)
    if callback then
        AutoRebirthVar = true
        while AutoRebirthVar and wait() do
            RebirthRemote:FireServer()
        end
    else
        AutoRebirthVar = false
    end
end, false)

GuiLibrary:AddToggle("KillAll", function(callback)
    if callback then
        KillAllVar = true
        while KillAllVar and task.wait(.2) do
            local Playerss = Players:GetPlayers()
            local RandomPlr = Playerss[math.random(1, #Playerss)]
            if RandomPlr ~= LocalPlayer then
                LocalPlayer.Character:MoveTo(RandomPlr.Character.HumanoidRootPart.Position)
            end
        end
    else
        KillAllVar = false
    end
end, false)

GuiLibrary:AddButton("NoWater", function()
    for _, blockName in ipairs(DamageParts) do
        local block = DamagePartsFolder[blockName]
        if block then
            block:Destroy()
        end
    end
end)

GuiLibrary:AddToggle("AutoToxic", function(callback)
    if callback then
        AutoToxicVar = true
        while AutoToxicVar and task.wait() do
            local PlrKills2 = Players.LocalPlayer.GameStats.Kills.Value
            if PlrKills2 ~= PlrKills then
                local Message2 = math.random(1, #Messages)
                local Message = Messages[Message2]:format(PlrKills2) .. " " .. WatermarkMsg
                game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(Message)
                PlrKills = PlrKills2
            end
        end
    else
        AutoToxicVar = true
    end
end, false)

GuiLibrary:AddToggle("GodMode", function(callback)
    if callback then
        for _, GodModePartsName in ipairs(GodModeParts) do
            local GodModeParts2 = InteractivesPartsFolder[GodModePartsName]
            if GodModeParts2 then
                GodModeParts2.Size = Vector3.new(9e9, 9e9, 9e9)
            end
        end
    else
        for _, GodModePartsName in ipairs(GodModeParts) do
            local GodModeParts2 = InteractivesPartsFolder[GodModePartsName]
            if GodModeParts2 then
                GodModeParts2.Size = Vector3.new(44, 18, 44)
            end
        end
    end
end, false)

GuiLibrary:AddButton("Speed", function()
    Hum.WalkSpeed = 40
end)

GuiLibrary:AddToggle("WaterMarkChatSpam", function(callback)
    if callback then
        WaterMarkSpam = true
        while WaterMarkSpam and task.wait(5) do
            local Message2 = math.random(1, #WaterMarkMsgs)
            local Message = WaterMarkMsgs[Message2]
            game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(Message)
        end
    else
        WaterMarkSpam = false
    end
end, false)