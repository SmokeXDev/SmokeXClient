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
local DefaultMessage = "Im using Smokex client. And my user is: "..player.DisplayName.. " | Smoke Client on top"
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