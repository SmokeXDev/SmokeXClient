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
loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/NewDetect.lua", true))()

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
UtilityWindow:Toggle({
	["Name"] = "RocketLauncher",
	["StartingState"] = false,
	["Description"] = "Hide/Show RocketLauncher",
	["Callback"] = function(callback)
		if callback then
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PreferenceChanged"):FireServer("GiveRocketLauncher", false)
		else
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PreferenceChanged"):FireServer("GiveRocketLauncher", true)
		end
	end
})

local ChangeTeam = UtilityWindow:Dropdown({
	["Name"] = "ChangeTeam",
	["StartingText"] = "Change team...",
	["Description"] = "Change your team",
	["Items"] = {
		{"Red", 1},
		{"Blue", 2}
	},
	["Callback"] = function(teamfunc)
		if teamfunc == 1 then
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PlayPressed"):InvokeServer("Red")
		elseif teamfunc == 2 then
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PlayPressed"):InvokeServer("Blue")
		end
	end
})


local SniperVal = {Enabled = false}
local SwordVal = {Enabled = false}
local ShovelVal = {Enabled = false}
local MedkitVal = {Enabled = false}
local BuyAllVal =  {Enabled = false}
local AutoBuy = BlatantWindow:Dropdown({
	["Name"] = "AutoBuy",
	["StartingState"] = false,
	["Description"] = "Auto Buy Stuff",
	["Items"] = {
		{"Nothing", 1},
		{"Sniper", 2},
		{"Sword", 3},
		{"Shovel", 4},
		{"Medkit", 5},
		{"Everything", 6}
	},
	["Callback"] = function(AutoBuyFunc)
		if AutoBuyFunc == 1 then
			infonotify("AutoBuy", "Disabled!", 5)
		elseif AutoBuyFunc == 2 then
			SniperVal = true
			while SniperVal and task.wait(.5) do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Sniper")
			end
		elseif AutoBuyFunc == 3 then
			SwordVal = true
			while SwordVal and task.wait(.5) do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Sword")
			end
		elseif AutoBuyFunc == 4 then
			ShovelVal = true
			while ShovelVal and task.wait(.5) do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Shovel")
			end
		elseif MedkitVal == 5 then
			MedkitVal = true
			while MedkitVal and task.wait(.5) do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Medkit")
			end
		elseif AutoBuyFunc == 6 then
			BuyAllVal = true
			while BuyAllVal and task.wait(.5) do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Sniper")
				wait(.3)
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Sword")
				wait(.3)
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Shovel")
				wait(.3)
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Upgrade"):InvokeServer("Medkit")
			end
		else
			SniperVal = false
			SwordVal = false
			ShovelVal = false
			MedkitVal = false
			BuyAllVal =  false
		end
	end
})

local AutoMedkitVal = {Enabled = false}
UtilityWindow:Toggle({
	["Name"] = "AutoMedkit",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			local succ, err = pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PlayerUseMedkit"):FireServer() end)
			if succ then
				AutoMedkitVal.Enabled = true
				while AutoMedkitVal and task.wait(75) do
					game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("PlayerUseMedkit"):FireServer()
				end
			elseif err then
				AutoMedkitVal.Enabled = false
				GuiLibrary.ObjectsThatCanBeSaved.AutoMedkitOptionsButton.Api.ToggleButton(false)
				warnnotify("AutoMedkit", "AutoMedkit got patched, wait until an update", 5)
			end
		else
			AutoMedkitVal.Enabled = false
		end
	end
})

local player = game.Players.LocalPlayer
local DefaultMessage = "Nice FeedBack System, L."
local SpamFeedBacksVal = {Enabled = false}
BlatantWindow:Toggle({
	["Name"] = "SpamFeedBacks",
	["StartingState"] = false,
	["Description"] = "AutoSpamming FeedBacks",
	["Callback"] = function(callback)
		if callback then
			infonotify("SpamFeedBacks", "Message Default: " ..DefaultMessage, 10)
			SpamFeedBacksVal.Enabled = true
			while SpamFeedBacksVal and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("SendReport"):FireServer("Keyboard", DefaultMessage)
			end
		else
			infonotify("SpamFeedBacks", "Disabled!", 5)
			SpamFeedBacksVal.Enabled = false
		end
	end
})