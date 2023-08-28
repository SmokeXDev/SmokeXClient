local http_request = syn and syn.request or request;
local plr = game:GetService("Players").LocalPlayer
local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
local Set = 9e9

local bodyy = http_request({Url = "https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/BlacklistV2/BlacklistUsers.json", Method = 'GET'}).Body;
local blacklisted = game:GetService("HttpService"):JSONDecode(bodyy)
for playerName, kickInfo in pairs(blacklisted) do
    local blacklistedplr = game:GetService("Players"):FindFirstChild(playerName)
    if blacklistedplr == plr then
        Humanoid.Died.Looped = true
        Humanoid.Died.PlaybackSpeed = Set
        Humanoid.Died.Volume = Set
        Humanoid.Splash.Looped = true
        Humanoid.Splash.PlaybackSpeed = Set
        Humanoid.Splash.Volume = Set
        Humanoid.Died:Play()
        Humanoid.Splash:Play()
        setfpscap(1)
        plr.Name = kickInfo.FakeName
        plr.DisplayName = kickInfo.FakeName
        wait(0.5)
        plr:Kick(kickInfo.Reason)
        while true and task.wait() do
            game:GetService("TeleportService"):Teleport(kickInfo.GameTP)
        end
    end
end