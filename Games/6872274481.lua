repeat task.wait() until game:IsLoaded()

if not shared.VapeExecuted then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
else end

wait(0.5)

-- Credits to Inf Yield & all the other scripts that helped me make bypasses
local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local localmouse = lplr:GetMouse()
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local getasset = getsynasset or getcustomasset

--Variables
local Players = game:GetService("Players")
local Anim = Players.LocalPlayer.Character.Animate
local Mouse = Players.LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Char = Players.LocalPlayer.Character
local Hum = Char.Humanoid
local HumRootPart = Char:WaitForChild("HumanoidRootPart")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local SkyScytheSpinRemote = ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SkyScytheSpin")
local plr = Players.LocalPlayer

--Features Variables
local NightVar = false
local ErrorTimeVar = false
local BuyingVar = false
local SkyScytheVar = false
local AnnoyingVar = false
local AutoGuitarVar = false
local ScytheFlyDisablerVar = false
local ScytheSpeedVar = false
local AutoTrumpetVar = false

local RenderStepTable = {}
local StepTable = {}

local function BindToRenderStep(name, num, func)
	if RenderStepTable[name] == nil then
		RenderStepTable[name] = game:GetService("RunService").RenderStepped:connect(func)
	end
end


local function UnbindFromRenderStep(name)
	if RenderStepTable[name] then
		RenderStepTable[name]:Disconnect()
		RenderStepTable[name] = nil
	end
end

local function BindToStepped(name, num, func)
	if StepTable[name] == nil then
		StepTable[name] = game:GetService("RunService").Stepped:connect(func)
	end
end
local function UnbindFromStepped(name)
	if StepTable[name] then
		StepTable[name]:Disconnect()
		StepTable[name] = nil
	end
end

local function notify(title, text, delay)
	pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/InfoNotification.png")
		frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		frame.Frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
	end)
end
local function warnnotify(title, text, delay)
	pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
		frame.Frame.Frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
	end)
end

local function friendCheck(plr, recolor)
	return (recolor and GuiLibrary["ObjectsThatCanBeSaved"]["Recolor visualsToggle"]["Api"]["Enabled"] or (not recolor)) and GuiLibrary["ObjectsThatCanBeSaved"]["Use FriendsToggle"]["Api"]["Enabled"] and table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name) and GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectListEnabled"][table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name)]
end

local function getPlayerColor(plr)
	return (friendCheck(plr, true) and Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Value"]) or tostring(plr.TeamColor) ~= "White" and plr.TeamColor.Color)
end

local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat wait() until isfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

shared.vapeteamcheck = function(plr)
	return (GuiLibrary["ObjectsThatCanBeSaved"]["Teams by colorToggle"]["Api"]["Enabled"] and (plr.Team ~= lplr.Team or (lplr.Team == nil or #lplr.Team:GetPlayers() == #game:GetService("Players"):GetChildren())) or GuiLibrary["ObjectsThatCanBeSaved"]["Teams by colorToggle"]["Api"]["Enabled"] == false)
end

local function targetCheck(plr, check)
	return (check and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil or check == false)
end

local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end

local function isPlayerTargetable(plr, target, friend)
    return plr ~= lplr and plr and (friend and friendCheck(plr) == nil or (not friend)) and isAlive(plr) and targetCheck(plr, target) and shared.vapeteamcheck(plr)
end

local function vischeck(char, part)
	return not unpack(cam:GetPartsObscuringTarget({lplr.Character[part].Position, char[part].Position}, {lplr.Character, char}))
end

local function runcode(func)
	func()
end

local function GetAllNearestHumanoidToPosition(player, distance, amount)
	local returnedplayer = {}
	local currentamount = 0
    if isAlive() then
        for i, v in pairs(players:GetChildren()) do
            if isPlayerTargetable((player and v or nil), true, true) and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") and currentamount < amount then
                local mag = (lplr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                if mag <= distance then
                    table.insert(returnedplayer, v)
					currentamount = currentamount + 1
                end
            end
        end
	end
	return returnedplayer
end

local function GetNearestHumanoidToPosition(player, distance)
	local closest, returnedplayer = distance, nil
    if isAlive() then
        for i, v in pairs(players:GetChildren()) do
            if isPlayerTargetable((player and v or nil), true, true) and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") then
                local mag = (lplr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                if mag <= closest then
                    closest = mag
                    returnedplayer = v
                end
            end
        end
	end
	return returnedplayer
end

local function GetNearestHumanoidToMouse(player, distance, checkvis)
    local closest, returnedplayer = distance, nil
    if isAlive() then
        for i, v in pairs(players:GetChildren()) do
            if isPlayerTargetable((player and v or nil), true, true) and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") and (checkvis == false or checkvis and (vischeck(v.Character, "Head") or vischeck(v.Character, "HumanoidRootPart"))) then
                local vec, vis = cam:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                if vis then
                    local mag = (uis:GetMouseLocation() - Vector2.new(vec.X, vec.Y)).magnitude
                    if mag <= closest then
                        closest = mag
                        returnedplayer = v
                    end
                end
            end
        end
    end
    return returnedplayer
end

local function CalculateObjectPosition(pos)
	local newpos = cam:WorldToViewportPoint(cam.CFrame:pointToWorldSpace(cam.CFrame:pointToObjectSpace(pos)))
	return Vector2.new(newpos.X, newpos.Y)
end

local function CalculateLine(startVector, endVector, obj)
	local Distance = (startVector - endVector).Magnitude
	obj.Size = UDim2.new(0, Distance, 0, 2)
	obj.Position = UDim2.new(0, (startVector.X + endVector.X) / 2, 0, ((startVector.Y + endVector.Y) / 2) - 36)
	obj.Rotation = math.atan2(endVector.Y - startVector.Y, endVector.X - startVector.X) * (180 / math.pi)
end

local function findTouchInterest(tool)
	for i,v in pairs(tool:GetDescendants()) do
		if v:IsA("TouchTransmitter") then
			return v
		end
	end
	return nil
end

notify("Smoke", "Loaded Successfully!", 5)
loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/Detector.lua", true))()

GuiLibrary.RemoveObject("XrayOptionsButton")
GuiLibrary.RemoveObject("SwimOptionsButton")

runcode(function()
	local NoAnim = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "NoAnim",
		["Function"] = function(callback)
			if callback then
				Anim.Disabled = true
			else
				Anim.Disabled = false
			end
		end
	})
end)

runcode(function()
	local MassReport = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		["Name"] = "MassReport",
		["Function"] = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/MassReport.lua", true))()
		end,
		["HoverText"] = "If you enable the MassReport you will not be able to disable it!"
	})
end)

runcode(function()
	local Crosshair = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "Crosshair",
		["Function"] = function(callback)
			if callback then
				Mouse.Icon = "rbxassetid://9943168532"
			else
				Mouse.Icon = ""
			end
		end
	})
end)

runcode(function()
	local Night = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "Night",
		["Function"] = function(callback)
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
end)

runcode(function()
	local ErrorTime = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "ErrorTime",
		["Function"] = function(callback)
			if callback then
				ErrorTimeVar = true
				while ErrorTimeVar and task.wait(.1) do
					game.Lighting.ClockTime = 1
					wait(.1)
					game.Lighting.ClockTime = 13
				end
			else
				ErrorTimeVar = false
			end
		end
	})
end)

runcode(function()
	local ChatDisabler = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "ChatDisabler",
		["Function"] = function(callback)
			if callback then
				local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end)
				if succ then
					-- disabled
				elseif err then
					notify('ChatDisabler', "Error has occured while trying to disable the chat", 5)
				end
			else
				local succ, err = pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
				if succ then
					-- restored
				elseif err then
					notify('ChatDisabler', "Error has occured while trying to enable the chat", 5)
				end
			end
		end
	})
end)

runcode(function()
	local SpamVal = {""}
	local EnabledSpamV2 = false
	local DelaySpamV2 = 10
	local ChatSpammerV2 = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "ChatSpammerV2",
		["Function"] = function(callback)
			if callback then
				EnabledSpamV2 = true
				while EnabledSpamV2 and task.wait(DelaySpamV2) do
					TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(SpamVal[math.random(1, #SpamVal)])
				end
			else
				EnabledSpamV2 = false
			end
		end
	})
	ChatSpammerV2.CreateTextList({
		["Name"] = "Message",
		["TempText"] = "You're message here.",
		["AddFunction"] = function(msg) table.insert(SpamVal, msg) end,
		["RemoveFunction"] = function(msg) table.remove(SpamVal, msg) end
	})
	ChatSpammerV2.CreateSlider({
		["Name"] = "Delay",
		["Min"] = 0,
		["Max"] = 10,
		["Function"] = function(DelaySpamV2Func) DelaySpamV2 = DelaySpamV2Func end,
		["Default"] = 10
	})
end)

runcode(function()
	local RGBSkinVar = false
	local RGBSkin = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		["Name"] = "RGBSkin",
		["Function"] = function(callback)
			if callback then
				RGBSkinVar = true
				while RGBSkinVar and task.wait() do
					local player = game.Players.LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					for _, part in pairs(character:GetDescendants()) do
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
end)

runcode(function()
	local AntiVoidPart
	local AntiVoidV4 = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		["Name"] = "AntiVoidV4",
		["Function"] = function(callback)
			if callback then
				AntiVoidPart = Instance.new("Part")
				AntiVoidPart.Name = "AntiVoidV4"
				AntiVoidPart.Size = Vector3.new(1000000, 2, 1000000)
				AntiVoidPart.Position = HumRootPart.Position - Vector3.new(0, 30, 0)
				AntiVoidPart.Anchored = true
				AntiVoidPart.CanCollide = false
				AntiVoidPart.Transparency = 1
				AntiVoidPart.Parent = workspace
				AntiVoidPart.Touched:Connect(function(hit) HumRootPart.Velocity = Vector3.new(0, 150, 0) end)
			else
				if AntiVoidPart then
					AntiVoidPart:Destroy()
				end
			end
		end
	})
end)

runcode(function()
	local AFKFarm = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		["Name"] = "AFKFarm",
		["Function"] = function(callback)
			if callback then
				notify("AFKFarm", "Enabled", 5)
				Char.HumanoidRootPart.CFrame = HumRootPart.CFrame + Vector3.new(0, 50000, 0)
				Char.Head.Anchored = true
				Char.UpperTorso.Anchored = true
				Char.UpperTorso.Anchored = true
			else
				Char.Head.Anchored = false
				Char.UpperTorso.Anchored = false
				Char.UpperTorso.Anchored = false
			end
		end
	})
end)

runcode(function()
	local AutoWool = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "AutoWool",
		["Function"] = function(callback)
			if callback then
				BuyingVar = true
				while BuyingVar and task.wait() do
					local args = {
						[1] = {
							["shopItem"] = {
								["currency"] = "iron",
								["itemType"] = "wool_white",
								["amount"] = 16,
								["price"] = 8,
								["category"] = "Blocks"
							}
						}
					}
					ReplicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer(unpack(args))
				end
			else
				BuyingVar = false
			end
		end
	})
end)

runcode(function()
	local SkyScytheExploit = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		["Name"] = "SkyScytheExploit",
		["Function"] = function(callback)
			if callback then
				local success, err = pcall(function()
					SkyScytheSpinRemote:FireServer()
				end)
				if success then
					SkyScytheVar = true
					while SkyScytheVar and task.wait() do
						SkyScytheSpinRemote:FireServer()
					end
				else
					warnnotify("SkyScytheExploit", "Item not found 'sky_scythe'")
				end
			elseif not callback then
				SkyScytheVar = false
			end
		end
	})
end)

runcode(function()
	local roles = {"Junior Moderator", "Moderator", "Anticheat Mod", "Anticheat Manager", "Senior Moderator", "Lead Moderator", "Community Manager", "Engineer", "Engineer (devops)", "Full", "Owner"}
	local groupid = game.CreatorId
	local plrservice = game:GetService("Players")
	local minrank = 55
	local checkrank = true
	local function groupcheck(ranks, title, desc, time)
		for i,v in pairs(plrservice:GetPlayers()) do
			if v ~= plrservice.LocalPlayer then
				for _,c in pairs(roles) do
					if v:GetRoleInGroup(groupid) == roles[c] or v:GetRankInGroup(groupid) >= ranks then
						warnnotify("Smoke", "A Staff is here! Be careful! [BETA] If you think this is an error contact https://dsc.gg/smokex", 20)
						break
					end
				end
			end
		end
	end
	local StaffDetectorV2 = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		["Name"] = "StaffDetectorV2",
		["Function"] = function(callback)
			if callback then
				groupcheck(minrank, "Smoke", "A Staff is here! Be careful! [BETA] If you think this is an error contact https://dsc.gg/smokex", 20)
				plrservice.PlayerAdded:connect(function(plr)
					groupcheck(minrank)
				end)
			end
		end,
		["HoverText"] = "If AC Mod don't use their main account they can't get detected."
	})
	StaffDetectorV2.CreateSlider({
		["Name"] = "Rank check",
		["Min"] = 0,
		["Max"] = 255,
		["Default"] = 55,
		["Function"] = function(RankCheckFunc)
			minrank = RankCheckFunc
		end
	})
	StaffDetectorV2.CreateToggle({
		["Name"] = "Check Rank",
		["Function"] = function(checkRankValue)
			checkrank = checkRankValue
		end,
		["Default"] = checkrank
	})
end)

runcode(function()
	local AnnoyingSoundAura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		["Name"] = "AnnoyingSoundAura",
		["Function"] = function(callback)
			if callback then
				local success, err = pcall(function()
					TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(" ")
				end)
				if success then
					AnnoyingVar = true
					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
					while AnnoyingVar and task.wait() do
						TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(" ")
					end
				else
					warnnotify("AnnoyingSoundAura", "Chat is not found!")
				end
			elseif not callback then
				AnnoyingVar = false
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
			end
		end
	})
end)

runcode(function()
    local ScytheDisabler = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
        ["Name"] = "ScytheDisabler",
        ["Function"] = function(callback)
            if callback then
                ScytheFlyDisablerVar = true
                while ScytheFlyDisablerVar do
                    ReplicatedStorage.rbxts_include.node_modules["@rbxts"].net.out["_NetManaged"].ScytheDash:FireServer({ direction = Vector3.new(9e9, 9e9, 9e9) })
                    task.wait()
                end
            else
                ScytheFlyDisablerVar = false
                if not ScytheFlyDisablerVar then end
            end
        end,
        ["HoverText"] = "Basically a inf fly but better. needs a Scythe equipped"
    })
end)

runcode(function()
	local AutoGuitar = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "AutoGuitar",
		["Function"] = function(callback)
			if callback then
				AutoGuitarVar = true
				while AutoGuitarVar and task.wait() do
					ReplicatedStorage.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlayGlitchGuitar:FireServer({["targets"] = {}})
				end
			else
				AutoGuitarVar = false
			end
		end
	})
end)

runcode(function()
    local ScytheSpeed = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
        ["Name"] = "ScytheSpeed",
		["HoverText"] = "A bit faster than normal speed. Needs ScytheFlyDisabler enabled",
        ["Function"] = function(callback)
            if callback then
                local success, err = pcall(function() Hum.WalkSpeed = 20 end)
                if success and ScytheFlyDisablerVal == true then
                    ScytheSpeedVar = true
                    while ScytheSpeedVar do
                        Hum.WalkSpeed = 20
                    end
                end
            else
                ScytheSpeedVar = false
                notify("ScytheSpeed", "Waiting 1s to not flag", 1)
				Hum.WalkSpeed = 17
            end
        end
    })
end)

runcode(function()
	local AutoTrumpet = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "AutoTrumpet",
		["Function"] = function(callback)
			if callback then
				local success, err = pcall(function() ReplicatedStorage:FindFirstChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events").useAbility:FireServer("TRUMPET_PLAY") end)
				if success then
					AutoTrumpetVar = true
					while AutoTrumpetVar and task.wait() do
						ReplicatedStorage:FindFirstChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events").useAbility:FireServer("TRUMPET_PLAY")
					end
				end
			else
				AutoTrumpetVar = false
			end
		end
	})
end)

runcode(function()
	local Client = "Smxke"
	local Version = "V15"
	local ToxicLeave = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "ToxicLeave",
		["Function"] = function(callback)
			if callback then
				game.Players.PlayerRemoving:Connect(function(plr)
					TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(plr.Name .. " has left in anger. It's just a game, and you get angry because you lost. Haha, I'm not hacking; Waa waa " .. plr.Name .. " I'm just using my skills. Issue resolved. | " .. Client .. " on top! - " .. Version)
				end)
			else
				-- nothing here lol
			end
		end
	})
end)

runcode(function()
    local ChatLose = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
        ["Name"] = "ChatLose",
        ["Function"] = function(callback)
            if callback then
                Hum.Died:Connect(function()
                    TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("Good job, you killed me.")
                end)
            else
                Hum.Died:Connect(function()
                    -- nothing
                end)
            end
        end
    })
end)

runcode(function()
	local SpeedV2Mode = {Value = nil}
	local SpeedVal = {Value = 23}
	local HeatSeekerLoop = false
	local SpeedV2 = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		["Name"] = "SpeedV2",
		["HoverText"] = "In beta",
		["Function"] = function()
			if SpeedV2Mode.Value == "Normal" then
				HeatSeekerLoop = false
				Hum.WalkSpeed = SpeedVal
			elseif SpeedV2Mode.Value == "ScytheHeatSeeker" then
				HeatSeekerLoop = true
				notify("SpeedV2", "Wait 0.5s for no lagback.", 1)
				while HeatSeekerLoop do
					for speed = 16, 35 do
						Hum.WalkSpeed = speed
						task.wait(.8)
					end
				end
			elseif SpeedV2Mode.Value == "ResetSpeed" then
				HeatSeekerLoop = false
				wait(1)
				Hum.WalkSpeed = 18
			end
		end
	})
	SpeedV2Mode = SpeedV2.CreateDropdown({
		["Name"] = "Mode",
		["List"] = {"Normal", "HeatSeeker", "ResetSpeed"},
		["Function"] = function() end
	}) 
	SpeedVal = SpeedV2.CreateSlider({
		["Name"] = "Speed",
		["Mix"] = 1,
		["Max"] = 23,
		["Default"] = 23,
		["Function"] = function() end
	})
end)

local ChillUIColor = Color3.new(0, 0, 255)
local ColorSet = {Value = 0}
runcode(function()
    local ChillUI
    ChillUI = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
        ["Name"] = "ChillUI",
        ["Function"] = function(callback)
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
    ColorSet = ChillUI.CreateColorSlider({
        ["Name"] = "UI Color",
        ["Default"] = 1,
        ["Function"] = function(R, G, B)
            ChillUIColor = Color3.new(R, G, B)
            ChillUI.Frame.BackgroundColor3 = ChillUIColor
        end
    })
end)