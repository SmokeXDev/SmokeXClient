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
local PlrStats = Players.LocalPlayer.leaderstats
local HumRootPart = Char:WaitForChild("HumanoidRootPart")
local Service = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
local EggRemote = Service:WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open")
local ClickRemote = Service:WaitForChild("ClickService"):WaitForChild("RF"):WaitForChild("Click")
local BestPetRemote = Service:WaitForChild("PetsService"):WaitForChild("RF"):WaitForChild("EquipBest")
local CraftRemote = Service:WaitForChild("PetsService"):WaitForChild("RF"):WaitForChild("CraftAll")
local CodeRemote = Service:WaitForChild("CodesService"):WaitForChild("RF"):WaitForChild("Redeem")
local RebirthRemote = Service:WaitForChild("RebirthService"):WaitForChild("RF"):WaitForChild("Rebirth")

--Notifications
local function notify(title)
	GuiLibrary:Notify(title)
end

--Features Variables
local NightVar = false
local ErrorTimeVar = false
local GravitiyVal = {Value = 1}
local NormalGrav = false
local VelocityGrav = false
local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local msg = {""}
local RGBSkinVar = false
local SpeedValue = {Value = 1}
local NormalSpeed = false
local TPSpeed = false
local CFrameSpeed = false
local SlowAnimSpeed = false
local JumpPower = {Value = 50}
local ChillUIColor = Color3.new(0, 1, 0)
local AutoFarmVar = false
local AutoPetsVar = false
local AutoBestPetsVar = false
local AutoCraftVar = false
local AutoRebirthVar = false
local AutoClickVar = false

--Lists
local Codes = {
	["happyanniversaryraceclicker"] = "Boost",
	["sorryforanotherrejoin"] = "x5 Boosts",
	["500mvisits"] = "x3 Lucky Boosts",
	["goodupdate"] = "x3 Win Boosts",
	["happy4thofjuly"] = "Rewards",
	["forgiveusfornoupdate"] = "x3 Lucky Boosts + x3 Wins Boosts",
	["freepet"] = "x3 Lucky Boosts + x3 Wins Boosts",
	["Updateclickcode"] = "AutoClicker Boost",
	["FREEPET1"] = "Limited Free Pet",
	["ObbyBoost"] = "x2 Wins Boosts + x3 Wins Boosts",
	["X3WOWCODE"] = "x3 Lucky Boosts + x3 Wins Boosts",
	["x330min5"] = "x3 Wins Boosts",
	["NEWCODEWIN1"] = "x3 Wins Boosts",
	["x3upd1"] = "x3 Wins Boosts",
	["winsop2"] = "x3 Wins Boosts",
	["x3wincode2"] = "x3 Wins Boosts",
	["500KLikes"] = "100 Wins",
	["ThankYou50M"] = "25 Wins",
	["Almost100MVisits"] = "25 Wins",
	["1MGroupMembers"] = "15 Wins",
	["ThanksFor5MillionsVisits"] = "8 Wins",
	["LetsGo5KLikes"] = "6 Wins",
	["NewUpdate"] = "3 Wins",
	["myvalentine"] = "x3 Wins Boosts",
	["opx3code"] = "x3 Wins Boosts"
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
Universal:AddToggle("NoAnim", {
    ["Text"] = "NoAnim",
    ["Default"] = false,
    ["Tooltip"] = "Removes your roblox anim",
    ["Callback"] = function(callback)
        if callback then
            Anim.Disabled = true
        else
            Anim.Disabled = false
        end
    end
})

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

Universal:AddDivider()
Universal:AddSlider("Gravity", {
    ["Text"] = "Gravity",
    ["Default"] = 192.2,
    ["Min"] = 0,
    ["Max"] = 192.2,
    ["Rounding"] = 1,
    ["Compact"] = false,
    ["Callback"] = function(GravityFunc)
        GravitiyVal.Value = GravityFunc
    end
})
Universal:AddDropdown("GravityMode", {
    ["Values"] = {"Normal", "Velocity"},
    ["Default"] = "Normal",
    ["Multi"] = false,
    ["Text"] = "GravityMode",
    ["Tooltip"] = nil,
    ["Callback"] = function(Value)
        if Value == "Normal" then
            VelocityGrav = false
			NormalGrav = true
			while NormalGrav and task.wait() do
				game.workspace.Gravity = GravitiyVal.Value
			end
        elseif Value == "Velocity" then
            NormalGrav = false
			VelocityGrav = true
			game.workspace.Gravity = 192.2
			while VelocityGrav and task.wait(.2) do
				game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, GravitiyVal.Value, 0)
			end
        else
            NormalGrav = false
            VelocityGrav = false
        end
    end
})
Universal:AddDivider()

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
Universal:AddSlider("Speed", {
    ["Text"] = "Speed",
    ["Default"] = 16,
    ["Min"] = 1,
    ["Max"] = 100,
    ["Rounding"] = 1,
    ["Compact"] = false,
    ["Callback"] = function(SpeedFunc)
        SpeedValue.Value = SpeedFunc
    end
})
Universal:AddDropdown("SpeedMode", {
    ["Values"] = {"Normal", "TPSpeed", "CFrame", "SlowAnim"},
    ["Default"] = "Normal",
    ["Multi"] = false,
    ["Text"] = "SpeedMode",
    ["Tooltip"] = "Select a speed mode",
    ["Callback"] = function(Value)
        if Value == "Normal" then
            NormalSpeed = true
            TPSpeed = false
            CFrameSpeed = false
            SlowAnimSpeed = false
            while NormalSpeed and task.wait() do
                Hum.WalkSpeed = SpeedValue.Value
            end
        elseif Value == "TPSpeed" then
            Options.Speed:SetValue(5)
            NormalSpeed = false
            TPSpeed = true
            CFrameSpeed = false
            SlowAnimSpeed = false
            while TPSpeed and task.wait(.5) do
                HumRootPart.CFrame = HumRootPart.CFrame + HumRootPart.CFrame.lookVector * SpeedValue.Value
            end
        elseif Value == "CFrame" then
            Options.Speed:SetValue(1)
            NormalSpeed = false
            TPSpeed = false
            CFrameSpeed = true
            SlowAnimSpeed = false
            while CFrameSpeed and task.wait() do
                HumRootPart.CFrame = HumRootPart.CFrame + HumRootPart.CFrame.lookVector * SpeedValue.Value
            end
        elseif Value == "SlowAnim" then
            NormalSpeed = false
            TPSpeed = false
            CFrameSpeed = false
            SlowAnimSpeed = true
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "http://www.roblox.com/asset/?id=913402848"
            local AnimationLoad = Hum:LoadAnimation(Anim)
            AnimationLoad:Play()
            local function AnimCheck()
                if Hum:GetState() == Enum.HumanoidStateType.Running or Hum:GetState() == Enum.HumanoidStateType.Walking then
                    if not AnimationLoad.IsPlaying then
                        AnimationLoad:Play()
                    end
                else
                    if AnimationLoad.IsPlaying then
                        AnimationLoad:Stop()
                    end
                end
            end
            while SlowAnimSpeed and task.wait() do
                Hum.WalkSpeed = SpeedValue.Value
                AnimCheck()
            end
        else
            Hum.WalkSpeed = 16
            NormalSpeed = false
            TPSpeed = false
            CFrameSpeed = false
            SlowAnimSpeed = false
        end
    end
})
Universal:AddDivider()

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
Utility:AddToggle("AutoClick", {
	["Text"] = "AutoClick",
	["Default"] = false,
	["Tooltip"] = nil,
	["Callback"] = function(callback)
		if callback then
			AutoClickVar = true
			while AutoClickVar and task.wait() do
				ClickRemote:InvokeServer()
			end
		else
			AutoClickVar = false
		end
	end
})

Blatant:AddToggle("AutoFarm", {
	["Text"] = "AutoFarm",
	["Default"] = false,
	["Tooltip"] = "Farms wins",
	["Callback"] = function(callback)
		if callback then
			AutoFarmVar = true
			while true and task.wait() do
				ClickRemote:InvokeServer()
				HumRootPart.Velocity = Vector3.new(-1000000, 0, 0)
			end
		else
			AutoFarmVar = false
		end
	end
})

Utility:AddToggle("AutoPets", {
	["Text"] = "AutoPets",
	["Default"] = false,
	["Tooltip"] = "Buys pets for you",
	["Callback"] = function(callback)
		if callback then
			AutoPetsVar = true
			while AutoPetsVar and task.wait() do
				if PlrStats:FindFirstChild("🏁Wins").Value == 0 or PlrStats:FindFirstChild("🏁Wins").Value < 4 then
                    notify("Error: You need more wins, please use autofarm for get some wins and restart AutoPets.")
					Toggles.AutoPets:SetValue(false)
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 4 or PlrStats:FindFirstChild("🏁Wins").Value > 4 then
                    EggRemote:InvokeServer("Starter01", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 25 or PlrStats:FindFirstChild("🏁Wins").Value > 25 then
                    EggRemote:InvokeServer("Starter02", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 175 or PlrStats:FindFirstChild("🏁Wins").Value > 175 then
                    EggRemote:InvokeServer("Starter03", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 750 or PlrStats:FindFirstChild("🏁Wins").Value > 750 then
                    EggRemote:InvokeServer("Starter04", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 7.500 or PlrStats:FindFirstChild("🏁Wins").Value > 7.500 then
                    EggRemote:InvokeServer("Pro01", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 50.000 or PlrStats:FindFirstChild("🏁Wins").Value > 50.000 then
                    EggRemote:InvokeServer("Pro02", "1", {})
                elseif PlrStats:FindFirstChild("🏁Wins").Value == 200.000 or PlrStats:FindFirstChild("🏁Wins").Value > 200.000 then
                    EggRemote:InvokeServer("Pro03", "1", {})
                end
			end
		else
			AutoPetsVar = false
		end
	end
})

Utility:AddToggle("AutoBestPets", {
	["Text"] = "AutoBestPets",
	["Default"] = false,
	["Tooltip"] = "Automatically equips the best pets you have",
	["Callback"] = function(callback)
		if callback then
			AutoBestPetsVar = false
			while AutoBestPetsVar and task.wait() do
				BestPetRemote:InvokeServer()
			end
		else
			AutoBestPetsVar = false
		end
	end
})

Utility:AddToggle("AutoCraft", {
	["Text"] = "AutoCraft",
	["Default"] = false,
	["Tooltip"] = "Automatically crafts all pets for you",
	["Callback"] = function(callback)
		if callback then
			AutoCraftVar = true
            while AutoCraftVar and task.wait() do
                CraftRemote:InvokeServer()
            end
        else
            AutoCraftVar = false
		end
	end
})

local ReedemCodes = Combat:AddButton({
	["Text"] = "ReedemCodes",
	["Func"] = function()
		for code, description in pairs(Codes) do
			CodeRemote:InvokeServer(code)
			notify("Code: " .. code .. " You won: " .. description)
		end
	end,
	["DoubleClick"] = false,
	["Tooltip"] = "Reedems all codes for you"
})

Utility:AddToggle("AutoRebirth", {
	["Text"] = "AutoRebirth",
	["Default"] = false,
	["Tooltip"] = "Automatically rebirths for you",
	["Callback"] = function(callback)
		if callback then
			AutoRebirthVar = true
			while AutoRebirthVar and task.wait() do
				RebirthRemote:InvokeServer()
			end
		else
			AutoRebirthVar = false
		end
	end
})