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
Smoke:set_status(
	"Smoke Status | Online"
)

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

local ChillUIColor = Color3.new(0, 0, 255)
RenderWindow:Toggle({
    ["Name"] = "ChillUI",
    ["StartingState"] = false,
    ["Description"] = "A Chill UI",
    ["Callback"] = function(callback)
        if callback then
            ChillUI = Instance.new("ScreenGui")
            ChillUI.Name = "ChillUI"
            ChillUI.ResetOnSpawn = false
            local Frame = Instance.new("Frame")
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
RenderWindow:ColorPicker({
    ["Style"] = GuiLibrary.ColorPickerStyles.Legacy,
    ["Callback"] = function(NewUIColor)
        ChillUIColor = NewUIColor
        if ChillUI.Frame.Visible == true then
            ChillUI.Frame.BackgroundColor3 = NewUIColor
		elseif ChillUI.Frame.Visible == false then
			warnnotify("ChillUI", "ChillUI is not enabled!", 8)
		else
			warnnotify("ChillUI", "ChillUI is not enabled!", 8)
        end
    end
})

--Game Features
local char = game.Players.LocalPlayer.Character.HumanoidRootPart
local Item = workspace.Remote.ItemHandler
UtilityWindow:Button({
	["Name"] = "AutoGuns",
	["Callback"] = function()
		notify("AutoGuns", "Getting Guns...", 5)
		char.CFrame = CFrame.new(823.260498, 99.9899826, 2253.3291, 1, -8.28284996e-10, -0.000169262014, 8.28318247e-10, 1, 1.96093281e-10, 0.000169262014, -1.96233474e-10, 1)
		wait(0.2)
		Item:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
		Item:InvokeServer(workspace.Prison_ITEMS.giver.M9.ITEMPICKUP)
		wait(0.1)
		char.CFrame = CFrame.new(-937.466064, 94.1287613, 2061.44702, -0.0350593626, 2.13304414e-08, -0.999385238, 3.84639947e-08, 1, 1.9994209e-08, 0.999385238, -3.77393619e-08, -0.0350593626)
		wait(0.2)
		Item:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
		wait(0.1)
		char.CFrame = CFrame.new(931.399658, 99.9899826, 2388.50073, -1, 0, 0, 0, 1, 0, 0, 0, -1)
		notify("AutoGuns", "Done.", 5)
	end
})

local SelectTeam = UtilityWindow:Dropdown({
	["Name"] = "SelectTeam",
	["StartingText"] = "Select Team...",
	["Description"] = "Change your team",
	["Items"] = {
		{"Criminals", 1},
		{"Inmates", 2},
		{"Guards", 3}
	},
	["Callback"] = function(teamfunc)
		if teamfunc == 1 then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-921.168884, 95.327179, 2144.69336, -0.0187869966, 2.35240947e-08, -0.999823511, -3.93195201e-08, 1, 2.42670737e-08, 0.999823511, 3.97684872e-08, -0.0187869966)
			wait(0.2)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(931.399658, 99.9899826, 2388.50073, -1, 0, 0, 0, 1, 0, 0, 0, -1)
		elseif teamfunc == 2 then
			workspace.Remote.TeamEvent:FireServer("Bright orange")
		elseif teamfunc == 3 then
			workspace.Remote.TeamEvent:FireServer("Bright blue")
		end
	end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local meleeEvent = ReplicatedStorage:WaitForChild("meleeEvent")
local Players = game:GetService("Players")
local KillAuraVal = false
CombatWindow:Toggle({
	["Name"] = "KillAura",
	["StartingState"] = false,
	["Description"] = "Kill aura",
	["Callback"] = function(callback)
		if callback then
			KillAuraVal = true
			while KillAuraVal and task.wait() do
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= Players.LocalPlayer then
						meleeEvent:FireServer(player)
					end
				end
			end
		else
			KillAuraVal = false
		end
	end
})

local SprintVal = false
UtilityWindow:Toggle({
	["Name"] = "Sprint",
	["StartingState"] = false,
	["Description"] = "Auto sprint for you",
	["Callback"] = function(callback)
		if callback then
			SprintVal = true
			while SprintVal and task.wait() do
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 22.5
			end
		else
			SprintVal = false
		end
	end
})