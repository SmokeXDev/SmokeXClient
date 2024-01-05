repeat task.wait() until game:IsLoaded()

local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()
local Smoke = GuiLibrary:CreateWindow({["Title"] = "Smoke Client", ["Center"] = true, ["AutoShow"] = true, ["TabPadding"] = 8, ["MenuFadeTime"] = 0.2})

--Variables
local Players = game:GetService("Players")
local Anim = Players.LocalPlayer.Character.Animate
local Mouse = Players.LocalPlayer:GetMouse()
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
local WatermarkMsg = "| Smxke on top! dsc.gg/smxke"

--Notifications
local function notify(title)
	GuiLibrary:Notify(title)
end

--Features Variables
local NightVar = false
local ErrorTimeVar = false
local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local msg = {""}
local RGBSkinVar = false
local JumpPower = {Value = 50}
local ChillUIColor = Color3.new(0, 1, 0)
local InstaKillAuraVar = false
local AutoToxicVar = false
local WaterMarkSpam = false

--Lists
local Messages = {
    "L everyone, + %d kills for me.",
    "Easy game, already %d kills.",
    "How you died in a block game bro, you're so bad, maybe you don't have a gaming chair like mine got %d kills.",
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
    "Bad? get better with dsc.gg/smxke",
    "Bad? get better with .gg/tzDKuCxKTE",
    "If you don't have skill like I do then just use the Smxke Client",
    "Imagine losing because you don't have the Smxke Client",
    "Smxke Client on top! dsc.gg/smxke",
    "Smxke Client on top! .gg/tzDKuCxKTE"
}

--Tabs
local Tabs = {
    CombatTab = Smoke:AddTab("Combat"),
    BlatantTab = Smoke:AddTab("Blatant"),
    UtilityTab = Smoke:AddTab("Utility"),
    RenderTab = Smoke:AddTab("Render"),
    UniversalTab = Smoke:AddTab("Universal"),
    ConfigTab = Smoke:AddTab("Config")
}

--Boxs
local Combat = Tabs.CombatTab:AddLeftGroupbox("Combat")
local Blatant = Tabs.BlatantTab:AddLeftGroupbox("Blatant")
local Utility = Tabs.UtilityTab:AddLeftGroupbox("Utility")
local Render = Tabs.RenderTab:AddLeftGroupbox("Render")
local Universal = Tabs.UniversalTab:AddLeftGroupbox("Universal")
local Config = Tabs.ConfigTab:AddLeftGroupbox("Menu")

--Loaded
notify("Smoke Loaded Successfully!")
loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeXClient/main/Resources/Detector.lua", true))()

--Feautres
Universal:AddToggle("Crosshair", {
    ["Text"] = "Crosshair",
    ["Default"] = false,
    ["Tooltip"] = "Replaces your cursor with a different one",
    ["Callback"] = function(callback)
        if callback then
			Mouse.Icon = "rbxassetid://9943168532"
		else
			Mouse.Icon = ""
		end
    end
})

Universal:AddToggle("Night", {
    ["Text"] = "Night",
    ["Default"] = false,
    ["Tooltip"] = "Sets your time to night",
    ["Callback"] = function(callback)
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
    end
})

Universal:AddToggle("ErrorTime", {
    ["Text"] = "ErrorTime",
    ["Default"] = false,
    ["Tooltip"] = nil,
    ["Callback"] = function(callback)
        if callback then
			ErrorTimeVar = true
			while ErrorTimeVar and task.wait(.1) do
				Lighting.ClockTime = 1
				wait(.1)
				Lighting.ClockTime = 13
			end
		else
			ErrorTimeVar = false
			Lighting.ClockTime = 1
		end
    end
})

Universal:AddToggle("ChatDisabler", {
    ["Text"] = "ChatDisabler",
    ["Default"] = false,
    ["Tooltip"] = "Removes chat",
    ["Callback"] = function(callback)
        if callback then
            local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end)
            if succ then
                -- disabled
            elseif err then
                notify("Error has occured while trying to disable the chat")
            end
        else
            local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
            if succ then
                -- restored
            elseif err then
                notify("Error has occured while trying to enable the chat")
            end
        end
    end
})

Universal:AddDivider()
Universal:AddToggle("ChatSpammer", {
    ["Text"] = "ChatSpammer",
    ["Default"] = false,
    ["Tooltip"] = nil,
    ["Callback"] = function(callback)
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
    end
})
Universal:AddInput("ChatSpammerMsg", {
    ["Default"] = "Smxke on top",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Text"] = "ChatSpammerMsg",
    ["Tooltip"] = "Message to spam",
    ["Placeholder"] = "Enter you're text...",
    ["Callback"] = function(msgvalue)
        msg = msgvalue
    end
})
Universal:AddDivider()

Universal:AddToggle("RGBSkin", {
    ["Text"] = "RGBSkin",
    ["Default"] = false,
    ["Tooltip"] = "Makes your character rainbow",
    ["Callback"] = function(callback)
        if callback then
			RGBSkinVar = true
			while RGBSkinVar and task.wait() do
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				for _,part in pairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Color = Color3.new(math.random(), math.random(), math.random())
					end
				end
			end
		else
			RGBSkinVar = false
		end
    end
})

Universal:AddDivider()
Universal:AddSlider("HighJumpPower", {
    ["Text"] = "HighJumpPower",
    ["Default"] = 50,
    ["Min"] = 10,
    ["Max"] = 300,
    ["Rounding"] = 1,
    ["Compact"] = false,
    ["Callback"] = function(JumpPowerFunc)
        JumpPower.Value = JumpPowerFunc
    end
})

Universal:AddLabel("Keybind"):AddKeyPicker("HighJump", {
    ["Default"] = "T",
    ["SyncToggleState"] = false,
    ["Mode"] = "Toggle",
    ["Text"] = 'HighJump',
    ["NoUI"] = false,
    ["Callback"] = function(ToggleState)
        if ToggleState == true then
            HumRootPart.Velocity = Vector3.new(0, JumpPower.Value, 0)
        else
            HumRootPart.Velocity = Vector3.new(0, JumpPower.Value, 0)
        end
    end
})
Universal:AddDivider()

Universal:AddDivider()
Universal:AddToggle("ChillUI", {
    ["Text"] = "ChillUI",
    ["Default"] = false,
    ["Tooltip"] = "Changes your screen color",
    ["Callback"] = function(callback)
        if callback then
            ChillUI = Instance.new("ScreenGui")
            ChillUI.Name = "ChillUI"
            ChillUI.ResetOnSpawn = false
            Frame = Instance.new("Frame")
            Frame.Name = "Frame"
            Frame.Parent = ChillUI
            Frame.BackgroundTransparency = 0.5
			Frame.Visible = true
            Frame.BorderColor3 = Color3.new(0, 0, 0)
            Frame.BorderSizePixel = 0
            Frame.Size = UDim2.new(9e9, 9e9, 9e9, 9e9)
            ChillUI.Parent = game.CoreGui
            ChillUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        else
            ChillUI.Frame.Visible = false
        end
    end
})
Universal:AddLabel("ChillUIColor"):AddColorPicker("ChillUIColor", {
    ["Default"] = Color3.new(0, 1, 0),
    ["Title"] = "ChillUIColor",
    ["Transparency"] = 0.5,
    ["Callback"] = function(Value)
        if ChillUI and ChillUI.Frame and ChillUI.Frame.Visible == true then
            ChillUI.Frame.BackgroundColor3 = Value
        elseif ChillUI and ChillUI.Frame and ChillUI.Frame.Visible == false then
            Toggles.ChillUI:SetValue(true)
        end
    end
})
Universal:AddDivider()

--Watermark
GuiLibrary:SetWatermarkVisibility(true)
local frameTimer, frameCounter, fps = tick(), 0, 60
local watermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
    frameCounter = frameCounter + 1
    if tick() - frameTimer >= 1 then fps, frameTimer, frameCounter = frameCounter, tick(), 0 end
    GuiLibrary:SetWatermark("Smoke Client | dsc.gg/smxke | " .. fps .. "fps")
end)
GuiLibrary:OnUnload(function() watermarkConnection:Disconnect() GuiLibrary.Unloaded = true end)

--Config
GuiLibrary.KeybindFrame.Visible = true;
Config:AddButton("Uninject", function() GuiLibrary:Unload() end)
Config:AddLabel("UI Keybind"):AddKeyPicker("UI Keybind", {["Default"] = "Zero", ["NoUI"] = true, ["Text"] = "UI Keybind"})
GuiLibrary.ToggleKeybind = Options["UI Keybind"]
ThemeManager:SetLibrary(GuiLibrary)
SaveManager:SetLibrary(GuiLibrary)
ThemeManager:SetFolder("Smoke/Themes")
SaveManager:SetFolder("Smoke/Games/" .. game.PlaceId)
SaveManager:BuildConfigSection(Tabs.ConfigTab)
ThemeManager:ApplyToTab(Tabs.ConfigTab)
SaveManager:LoadAutoloadConfig()

--Game Features
Combat:AddToggle("InstaKillAura", {
    ["Text"] = "InstaKillAura",
    ["Default"] = false,
    ["Tooltip"] = "Kills everyone around you",
    ["Callback"] = function(callback)
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
    end
})

Utility:AddToggle("AutoRebirth", {
    ["Text"] = "AutoRebirth",
    ["Default"] = false,
    ["Tooltip"] = nil,
    ["Callback"] = function(callback)
        if callback then
            AutoRebirthVar = true
            while AutoRebirthVar and wait() do
                RebirthRemote:FireServer()
            end
        else
            AutoRebirthVar = false
        end
    end
})

Blatant:AddToggle("KillAll", {
    ["Text"] = "KillAll",
    ["Default"] = false,
    ["Tooltip"] = nil,
    ["Callback"] = function(callback)
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
    end
})

Utility:AddToggle("JesusMode", {
    ["Text"] = "JesusMode",
    ["Default"] = false,
    ["Tooltip"] = "Prevents you from dying from the water",
    ["Callback"] = function(callback)
        if callback then
            InteractivesPartsFolder.TopMesh3.CanCollide = true
            InteractivesPartsFolder.TopMesh2.CanCollide = true
            InteractivesPartsFolder.TopMesh1.CanCollide = true
        else
            InteractivesPartsFolder.TopMesh3.CanCollide = false
            InteractivesPartsFolder.TopMesh2.CanCollide = false
            InteractivesPartsFolder.TopMesh1.CanCollide = false
        end
    end
})

Utility:AddToggle("AutoToxic", {
    ["Text"] = "AutoToxic",
    ["Default"] = false,
    ["Tooltip"] = "Says somthing after every kill",
    ["Callback"] = function(callback)
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
    end
})

Utility:AddToggle("GodMode", {
    ["Text"] = "GodMode",
    ["Default"] = false,
    ["Tooltip"] = "Cannot kill unless disabled!",
    ["Callback"] = function(callback)
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
    end
})

local Speed = Utility:AddButton({
    ["Text"] = "Speed",
    ["Func"] = function()
        notify("Your speed now is 40, if you die you will lose your speed.")
        Hum.WalkSpeed = 40
    end,
    ["DoubleClick"] = false,
    ["Tooltip"] = "Sets your speed to 40 untill killed"
})

Utility:AddSlider("Gravity", {
    ["Text"] = "Gravity",
    ["Default"] = 192.2,
    ["Min"] = 0,
    ["Max"] = 192.2,
    ["Rounding"] = 1,
    ["Compact"] = false,
    ["Callback"] = function(GravityVal)
        workspace.Gravity = GravityVal
    end
})

Utility:AddToggle("WaterMarkChatSpam", {
    ["Text"] = "WaterMarkChatSpam",
    ["Default"] = false,
    ["Tooltip"] = "Spams chat with Smoke advertisements",
    ["Callback"] = function(callback)
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
    end
})