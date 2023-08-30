local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local Smoke = GuiLibrary:Create{Name = "Smoke Client", Size = UDim2.fromOffset(600, 400), Theme = GuiLibrary.Themes.Dark, Link = "https://dsc.gg/smxke | "}

if not isfolder("Smoke") then
    makefolder("Smoke")
end
if not isfolder("Smoke/assets") then
    makefolder("Smoke/assets")
end
if not isfile("Smoke/assets/Cape.png") then
    writefile("Smoke/assets/Cape.png", game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/assets/Cape.png"))
end

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
loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/SmokeXTeam/NewDetect.lua", true))()

--Feautres
UtilityWindow:Toggle{
    ["Name"] = "NoAnim",
    ["StartingState"] = false,
    ["Description"] = "Removes your roblox anim",
    ["Callback"] = function(callback) 
        if callback then
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        else
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
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

local mouse = game:GetService("Players").LocalPlayer:GetMouse()
RenderWindow:Toggle({
	["Name"] = "Crosshair",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			mouse.Icon = "rbxassetid://9943168532"
		else
			mouse.Icon = ""
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

UtilityWindow:Slider({
	["Name"] = "GravityV2",
	["Default"] = 192.2,
	["Min"] = 0,
	["Max"] = 192.2,
	["Callback"] = function(GravitiyVal)
		workspace.Gravity = GravitiyVal
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

local EnabledSpamV2 = false
local DelaySpamV2 = 10
local msg = {""}
UtilityWindow:Toggle({
	["Name"] = "ChatSpammerV2",
	["StartingState"] = false,
	["Description"] = "[BETA]",
	["Callback"] = function(callback)
		if callback then
			EnabledSpamV2 = true
			while EnabledSpamV2 and task.wait(DelaySpamV2) do
				game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
			end
		else
			EnabledSpamV2 = false
		end
	end
})
UtilityWindow:textBox({
	["Name"] = "Message for ChatSpammerV2 [BETA]",
	["Callback"] = function(newMsg)
		msg = newMsg
	end
})

local RainbowSkinVal = false
RenderWindow:Toggle({
	["Name"] = "RainbowSkin",
	["StartingState"] = false,
	["Description"] = "Makes your character rainbow",
	["Callback"] = function(callback)
		if callback then
			RainbowSkinVal = true
			while RainbowSkinVal and task.wait() do
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				for _,part in pairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Color = Color3.new(math.random(), math.random(), math.random())
					end
				end
			end
		else
			RainbowSkinVal = false
		end
	end
})

local SpeedVal = {Value = 1}
local Normal = false
local TPSpeed = false
local CFrame = false
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
		{"CFrame", 3}
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
		else
			Normal = false
			TPSpeed = false
			CFrame = false
		end
	end
})

UtilityWindow:Slider({
	["Name"] = "HighJump",
	["Default"] = 50,
	["Min"] = 1,
	["Max"] = 500,
	["Callback"] = function(JumpPower)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = JumpPower
	end
})

--Game Features
local AutoCollectVal = false
UtilityWindow:Toggle({
	["Name"] = "AutoCollect",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			AutoCollectVal = true
			while AutoCollectVal and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteCalls"):WaitForChild("GameSpecific"):WaitForChild("Lobby"):WaitForChild("Collecting"):WaitForChild("CollectedSpeed"):FireServer(3)
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteCalls"):WaitForChild("GameSpecific"):WaitForChild("Lobby"):WaitForChild("Collecting"):WaitForChild("CollectedSpeed"):FireServer(2)
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteCalls"):WaitForChild("GameSpecific"):WaitForChild("Lobby"):WaitForChild("Collecting"):WaitForChild("CollectedSpeed"):FireServer(1)
			end
		else
			AutoCollectVal = false
		end
	end
})

local InfSpeedVal = false
UtilityWindow:Toggle({
	["Name"] = "InfiniteSpeed",
	["StartingState"] = false,
	["Callback"] = function(callback)
		if callback then
			InfSpeedVal = true
			while InfSpeedVal and task.wait() do
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 999999
			end
		else
			infonotify("InfSpeed", "Disabled!", 5)
			InfSpeedVal = false
		end
	end
})

RenderWindow:Button({
	["Name"] = "MiniFPSBoost",
	["Description"] = "Removes some stuff in the game no needed",
	["Callback"] = function(callback)
		if callback then
			game.workspace.Important.Doors:Destroy()
			game.workspace.Important.Collecting:Destroy()
		end
	end
})