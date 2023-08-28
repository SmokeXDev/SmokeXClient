local whitelisted = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/Whitelist/main/NewWhitelist.json"))
local Players = game:GetService("Players")
local lplrname = game.Players.LocalPlayer.Name

local function notify(title, message, delay)
    local notification = Instance.new("ScreenGui")
    notification.Name = "Notification"

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.3, 0, 0.1, 0)
    frame.Position = UDim2.new(0.5, 0, 0.9, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = notification

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    titleLabel.TextStrokeTransparency = 0
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.Text = title
    titleLabel.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    textLabel.AnchorPoint = Vector2.new(0, 0.5)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextSize = 18
    textLabel.TextWrap = true
    textLabel.Text = message
    textLabel.Parent = frame

    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    wait(delay or 5)
    notification:Destroy()
end

for playerName, tagInfo in pairs(whitelisted) do
    local player = Players:FindFirstChild(playerName)
    if player then
        player.DisplayName = tagInfo.nametag
        player.Name = tagInfo.nametag2
        local head = player.Character and player.Character:FindFirstChild("Head")
        if head then
            local displayNameContainer = head:FindFirstChild("Nametag") and head.Nametag:FindFirstChild("DisplayNameContainer")
            if displayNameContainer then
                local displayName = displayNameContainer:FindFirstChild("DisplayName")
                if displayName then
                    displayName.Text = tagInfo.headname
                    displayName.TextColor3 = Color3.fromRGB(0xFF, 0x32, 0x32)
                end
            end
        end
        local textChatService = game:GetService("TextChatService")
        textChatService.OnIncomingMessage = function(message, chatStyle)
            local properties = Instance.new("TextChatMessageProperties")
            local player = game:GetService("Players"):GetPlayerByUserId(message.TextSource.UserId)
            if player then
                for playerName, tagInfo in pairs(whitelisted) do
                    if player.Name == playerName then
                        properties.PrefixText = '<font color="'..tagInfo.color..'">'..tagInfo.chattag..'</font> ' .. message.PrefixText
                        break
                    end
                end
            end
            return properties
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    local playerName = player.Name
    local tagInfo = whitelisted[playerName]
    if tagInfo and playerName ~= lplrname then
        notify("Smoke Team", playerName .. " is a " .. tagInfo.nametag .. " (" .. tagInfo.nametag2 .. ").", 8)
    end
end)

local tagInfo = whitelisted[lplrname]
if tagInfo then
    notify("Smoke Private", "You are a Smoke Private (" .. tagInfo.nametag .. ") (" .. tagInfo.nametag2 .. ").", 3)
end