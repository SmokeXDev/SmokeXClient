local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local Smoke = GuiLibrary:Create{Name = "Smoke Client", Size = UDim2.fromOffset(600, 400), Theme = GuiLibrary.Themes.Dark, Link = "https://dsc.gg/smxke | "}

function notify(Title, Text, Delay, Function)
    Smoke:Notification{Title = Title, Text = Text, Duration = Delay, Function = Callback}
end
function infonotify(Title, Text, Delay, Function)
    Smoke:Notification{Title = Title, Text = Text, Duration = Delay, Function = Callback}
end
function warnnotify(Title, Text, Delay, Function)
    Smoke:Notification{Title = Title, Text = Text, Duration = Delay, Function = Callback}
end

--Tabs
local CombatWindow = Smoke:Tab{Name = "Combat", Icon = "http://www.roblox.com/asset/?id=6035078889"}
local BlatantWindow = Smoke:Tab{Name = "Blatant", Icon = "http://www.roblox.com/asset/?id=6034287525"}
local UtilityWindow = Smoke:Tab{Name = "Utility", Icon = "http://www.roblox.com/asset/?id=6023426938"}
local RenderWindow = Smoke:Tab{Name = "Render", Icon = "http://www.roblox.com/asset/?id=6031075931"}

--Other
Smoke:Credit({
	["Name"] = "xysim",
	["Description"] = "Smoke Developer",
	["Discord"] = "discord.gg/Sm2xSZBFDn"
})
Smoke:Credit({
	["Name"] = "xysim github",
	["Github"] = "github.com/SmokeXDev"
})

--Loaded
notify("Smoke", "Loaded Successfully!", 5)
loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/Detector.lua", true))()

--Feautres
local Anim = game.Players.LocalPlayer.Character.Animate
UtilityWindow:Toggle{
    ["Name"] = "NoAnim",
    ["StartingState"] = false,
    ["Description"] = "Removes your roblox anim",
    ["Callback"] = function(callback) 
        if callback then
            Anim.Disabled = true
        else
            Anim.Disabled = false
        end
    end
}

BlatantWindow:Button({
	["Name"] = "MassReport",
	["Callback"] = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/MassReport.lua", true))()
	end,
	["Description"] = "MassReporting everyone"
})

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
RenderWindow:Toggle({
	["Name"] = "Crosshair",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			Mouse.Icon = "rbxassetid://9943168532"
		else
			Mouse.Icon = ""
		end
	end
})

local NightVal = false
RenderWindow:Toggle({
	["Name"] = "Night",
	["StartingState"] = false,
	["Description"] = "Set time to night",
	["Callback"] = function(callback)
		if callback then
			NightVal = true
			while NightVal and task.wait(0.3) do
				game:GetService("Lighting").TimeOfDay = "00:00:00"
			end
		else
			NightVal = false
			wait(0.3)
			game:GetService("Lighting").TimeOfDay = "13:00:00"
		end
	end
})

local ErrorTimeVal = false
RenderWindow:Toggle({
	["Name"] = "ErrorTime",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			ErrorTimeVal = true
			while ErrorTimeVal and task.wait(0.1) do
				game.Lighting.ClockTime = 1
				wait(0.1)
				game.Lighting.ClockTime = 13
			end
		else
			ErrorTimeVal = false
			game.Lighting.ClockTime = 1
		end
	end
})

local GravitiyVal = {Value = 1}
local Normal = false
local Velocity = false
UtilityWindow:Slider({
	["Name"] = "Gravity",
	["Default"] = 192.2,
	["Min"] = 0,
	["Max"] = 192.2,
	["Callback"] = function(GravityFunc) GravitiyVal.Value = GravityFunc end
})
local GravitySelect = UtilityWindow:Dropdown({
	["Name"] = "GravityMode",
	["StartingText"] = "Select Gravity...",
	["Description"] = nil,
	["Items"] = {
		{"Normal", 1},
		{"Velocity", 2}
	},
	["Callback"] = function(gravitymode)
		if gravitymode == 1 then
			Velocity = false
			Normal = true
			while Normal and task.wait() do
				game.workspace.Gravity = GravitiyVal.Value
			end
		elseif gravitymode == 2 then
			Normal = false
			Velocity = true
			game.workspace.Gravity = 192.2
			while Velocity and task.wait(.2) do
				game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, GravitiyVal.Value, 0)
			end
		else
			Normal = false
			Velocity = false
		end
	end
})

RenderWindow:Toggle({
	["Name"] = "ChatDisabler",
	["StartingState"] = false,
	["Description"] = "Remove ChatUI",
	["Callback"] = function(callback)
		if callback then
			local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end)
			if succ then
				-- disabled
			elseif err then
				notify("ChatDisabler", "Error has occured while trying to disable the chat", 5)
			end
		else
			local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
			if succ then
				-- restored
			elseif err then
				notify("ChatDisabler", "Error has occured while trying to enable the chat", 5)
			end
		end
	end
})

local TextChatServiceSpam = false
local LegacyChatServiceSpam = false
local SpamDelay = 0.5
local msg = {""}
local TextChatService = game:GetService("TextChatService")
UtilityWindow:Toggle({
	["Name"] = "ChatSpammer",
	["StartingState"] = false,
	["Description"] = nil,
	["Callback"] = function(callback)
		if callback then
			if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
				TextChatServiceSpam = true
				while TextChatServiceSpam and task.wait(SpamDelay) do
					game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
				end
			elseif TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
				LegacyChatServiceSpam = true
				while LegacyChatServiceSpam and task.wait(SpamDelay) do
					game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(msg, "All")
				end
			end
		else
			TextChatServiceSpam = false
			LegacyChatServiceSpam = false
		end
	end
})
UtilityWindow:textBox({
	["Name"] = "Message for ChatSpammer",
	["Callback"] = function(newMsg)
		msg = newMsg
	end
})

local RGBSkinVal = false
RenderWindow:Toggle({
	["Name"] = "RGBSkin",
	["StartingState"] = false,
	["Description"] = "Makes your character rainbow",
	["Callback"] = function(callback)
		if callback then
			RGBSkinVal = true
			while RGBSkinVal and task.wait() do
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				for _,part in pairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Color = Color3.new(math.random(), math.random(), math.random())
					end
				end
			end
		else
			RGBSkinVal = false
		end
	end
})

local SpeedVal = {Value = 1}
local Normal = false
local TPSpeed = false
local CFrame = false
local SlowAnim = false
local Humanoid = game.Players.LocalPlayer.Character.Humanoid
UtilityWindow:Slider({
	["Name"] = "Speed",
	["Default"] = 16,
	["Min"] = 1,
	["Max"] = 100,
	["Callback"] = function(SpeedFunc) SpeedVal.Value = SpeedFunc end
})
local SpeedSelect = UtilityWindow:Dropdown({
	["Name"] = "SpeedMode",
	["StartingText"] = "Select Speed...",
	["Description"] = nil,
	["Items"] = {
		{"Normal", 1},
		{"TPSpeed", 2},
		{"CFrame", 3},
		{"SlowAnim", 4}
	},
	["Callback"] = function(speedmode)
		if speedmode == 1 then
			TPSpeed = false
			CFrame = false
			Normal = true
			while Normal and task.wait() do
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedVal.Value
			end
		elseif speedmode == 2 then
			notify("TPSpeed", "Default: 5")
			SpeedVal.Value = 5
			Normal = false
			CFrame = false
			TPSpeed = true
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
			while TPSpeed and task.wait(.5) do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * SpeedVal.Value
			end
		elseif speedmode == 3 then
			notify("CFrame", "Default: 1")
			SpeedVal.Value = 1
			Normal = false
			TPSpeed = false
			CFrame = true
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
			while CFrame and task.wait() do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * SpeedVal.Value
			end
		elseif speedmode == 4 then
			Normal = false
			TPSpeed = false
			CFrame = false
			SlowAnim = true
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "http://www.roblox.com/asset/?id=913402848"
			local AnimationLoad = Humanoid:LoadAnimation(Anim)
			AnimationLoad:Play()
			local function AnimCheck()
				if Humanoid:GetState() == Enum.HumanoidStateType.Running or Humanoid:GetState() == Enum.HumanoidStateType.Walking then
					if not AnimationLoad.IsPlaying then
						AnimationLoad:Play()
					end
				else
					if AnimationLoad.IsPlaying then
						AnimationLoad:Stop()
					end
				end
			end
			while SlowAnim and task.wait() do
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedVal.Value
				AnimCheck()
			end
		else
			Normal = false
			TPSpeed = false
			CFrame = false
			SlowAnim = false
		end
	end
})

local JumpPower = {Value = 50}
UtilityWindow:Slider({
	["Name"] = "HighJumpPower",
	["Default"] = 50,
	["Min"] = 10,
	["Max"] = 300,
	["Callback"] = function(JumpPowerFunc)
		JumpPower.Value = JumpPowerFunc
	end
})
UtilityWindow:Keybind({
	["Name"] = "HighJump",
	["Keybind"] = nil,
	["Description"] = nil,
	["Callback"] = function()
		game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, JumpPower.Value, 0)
	end
})

--Game Features
local AutoFarmVal = false
BlatantWindow:Toggle({
    ["Name"] = "AutoFarm",
    ["StartingState"] = false,
    ["Description"] = "AutoFarming",
    ["Callback"] = function(callback)
        if callback then
            AutoFarmVal = true
            while AutoFarmVal and task.wait() do
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("ClickService"):WaitForChild("RF"):WaitForChild("Click"):InvokeServer()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(-1000000, 0, 0)
            end
        else
            AutoFarmVal = false
        end
    end
})

local plrs = game.Players.LocalPlayer.leaderstats
local AutoPetsVal = false
UtilityWindow:Toggle({
    ["Name"] = "AutoPets",
    ["StartingState"] = false,
    ["Description"] = "auto buy pets",
    ["Callback"] = function(callback)
        if callback then
            AutoPetsVal = true
            while AutoPetsVal and task.wait() do
                if plrs:FindFirstChild("🏁Wins").Value == 0 or plrs:FindFirstChild("🏁Wins").Value < 4 then
                    notify("AutoPets", "Error: You need more wins, please use autofarm for get some wins and restart AutoPets.", 10)
                    UtilityWindow.AutoPets.Enabled = false
                elseif plrs:FindFirstChild("🏁Wins").Value == 4 or plrs:FindFirstChild("🏁Wins").Value > 4 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Starter01", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 25 or plrs:FindFirstChild("🏁Wins").Value > 25 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Starter02", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 175 or plrs:FindFirstChild("🏁Wins").Value > 175 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Starter03", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 750 or plrs:FindFirstChild("🏁Wins").Value > 750 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Starter04", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 7.500 or plrs:FindFirstChild("🏁Wins").Value > 7.500 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Pro01", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 50.000 or plrs:FindFirstChild("🏁Wins").Value > 50.000 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Pro02", "1", {})
                elseif plrs:FindFirstChild("🏁Wins").Value == 200.000 or plrs:FindFirstChild("🏁Wins").Value > 200.000 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RF"):WaitForChild("Open"):InvokeServer("Pro03", "1", {})
                end
            end
        else
            AutoPetsVal = false
        end
    end
})

local AutoBestPets = false
UtilityWindow:Toggle({
    ["Name"] = "AutoBestPets",
    ["StartingState"] = false,
    ["Description"] = "Auto equip best pets",
    ["Callback"] = function(callback)
        if callback then
            AutoBestPets = true
            while AutoBestPets and task.wait() do
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PetsService"):WaitForChild("RF"):WaitForChild("EquipBest"):InvokeServer()
            end
        else
            AutoBestPets = false
        end
    end
})

local AutoCraftVal = false
UtilityWindow:Toggle({
    ["Name"] = "AutoCraft",
    ["StartingState"] = false,
    ["Description"] = "Auto Craft all pets",
    ["Callback"] = function(callback)
        if callback then
            AutoCraftVal = true
            while AutoCraftVal and task.wait() do
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PetsService"):WaitForChild("RF"):WaitForChild("CraftAll"):InvokeServer()
            end
        else
            AutoCraftVal = false
        end
    end
})

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
CombatWindow:Button({
	["Name"] = "ReedemCodes",
	["Description"] = "Reedem all codes (Working only 1 time)",
	["Callback"] = function()
		for code, description in pairs(Codes) do
			game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CodesService"):WaitForChild("RF"):WaitForChild("Redeem"):InvokeServer(code)
			notify(code, "You won: " .. description, 10)
		end
	end
})

local SeasonVal = false
UtilityWindow:Toggle({
	["Name"] = "SeasonRedeemer",
	["StartingState"] = false,
	["Description"] = "Auto reedem free rewards on the season pass",
	["Callback"] = function(callback)
		if callback then
			SeasonVal = true
			while SeasonVal and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SeasonPassService"):WaitForChild("RF"):WaitForChild("ClaimTier"):InvokeServer()
			end
		else
			SeasonVal = false
		end
	end
})

local AutoRebirth = false
UtilityWindow:Toggle({
	["Name"] = "AutoRebirth",
	["StartingState"] = false,
	["Description"] = "Auto rebirth",
	["Callback"] = function(callback)
		if callback then
			AutoRebirth = true
			while AutoRebirth and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RF"):WaitForChild("Rebirth"):InvokeServer()
			end
		else
			AutoRebirth = false
		end
	end
})