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
	["Callback"] = function(GravitiyVal, callback)
		if callback then
			workspace.Gravity = GravitiyVal
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

--Game Features
local FarmJumpsVal = false
CombatWindow:Toggle({
	["Name"] = "FarmJumps",
	["StartingState"] = false,
	["Description"] = "Auto Farming Jumps",
	["Callback"] = function(callback)
		if callback then
			FarmJumpsVal = true
			while FarmJumpsVal and task.wait(0.5) do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-500.47287, 5.51772547, 10915.1553, -0.999997258, -1.50035824e-08, 0.00233520381, -1.49010466e-08, 1, 4.39257235e-08, -0.00233520381, 4.38908074e-08, -0.999997258)
			end
		else
			FarmJumpsVal = false
		end
	end
})

local FarmSpeedVal = false
CombatWindow:Toggle({
	["Name"] = "FarmSpeed",
	["StartingState"] = false,
	["Description"] = "Auto Farming Speed",
	["Callback"] = function(callback)
		if callback then
			FarmSpeedVal = true
			while FarmSpeedVal and task.wait(0.5) do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2496.354, 57.8458519, 38671.9609, -0.99582231, 8.23530932e-09, -0.0913119763, 1.93580751e-09, 1, 6.90773447e-08, 0.0913119763, 6.86119961e-08, -0.99582231)
			end
		else
			FarmSpeedVal = false
		end
	end
})

local FarmHealthVal = false
CombatWindow:Toggle({
	["Name"] = "FarmHealth",
	["StartingState"] = false,
	["Description"] = "Auto Farming Health",
	["Callback"] = function(callback)
		if callback then
			FarmHealthVal = true
			while FarmHealthVal and task.wait(0.5) do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4500.24902, 6.88842297, 10845.2812, -0.999975204, -1.24351951e-08, 0.00704113534, -1.26406974e-08, 1, -2.91414697e-08, -0.00704113534, -2.92297528e-08, -0.999975204)
			end
		else
			FarmHealthVal = false
		end
	end
})

local FarmDamageVal = false
CombatWindow:Toggle({
	["Name"] = "FarmDamage",
	["StartingState"] = false,
	["Description"] = "Auto Farming Damage",
	["Callback"] = function(callback)
		if callback then
			FarmDamageVal = true
			while FarmDamageVal and task.wait(0.1) do
				game:GetService("ReplicatedStorage").AutoDamage:FireServer(true)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6500.04785, 0.198037609, 10220.5449, -0.998949587, -3.03456531e-08, 0.0458233096, -3.43861615e-08, 1, -8.73875337e-08, -0.0458233096, -8.8871424e-08, -0.998949587)
			end
		else
			FarmDamageVal = false
			game:GetService("ReplicatedStorage").AutoDamage:FireServer(false)
		end
	end
})

local FarmAllVal = false
CombatWindow:Toggle({
	["Name"] = "FarmAll",
	["StartingState"] = false,
	["Description"] = "Auto Farming everything",
	["Callback"] = function(callback)
		if callback then
			FarmAllVal = true
			while FarmAllVal and task.wait() do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-500.47287, 5.51772547, 10915.1553, -0.999997258, -1.50035824e-08, 0.00233520381, -1.49010466e-08, 1, 4.39257235e-08, -0.00233520381, 4.38908074e-08, -0.999997258)
				wait(0.5)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2496.354, 57.8458519, 38671.9609, -0.99582231, 8.23530932e-09, -0.0913119763, 1.93580751e-09, 1, 6.90773447e-08, 0.0913119763, 6.86119961e-08, -0.99582231)
				wait(0.5)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4500.24902, 6.88842297, 10845.2812, -0.999975204, -1.24351951e-08, 0.00704113534, -1.26406974e-08, 1, -2.91414697e-08, -0.00704113534, -2.92297528e-08, -0.999975204)
				wait(0.5)
			end
		else
			FarmAllVal = false
		end
	end
})