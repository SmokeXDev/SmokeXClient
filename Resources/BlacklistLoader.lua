local http_request = syn and syn.request or request;
local Players = game:GetService("Players")
local Teleport = game:GetService("TeleportService")
local BlacklistUsers = http_request({Url = "https://raw.githubusercontent.com/SmokeXDev/SmokeUsers/main/Blacklist.json", Method = 'GET'}).Body;
local blacklisted = game:GetService("HttpService"):JSONDecode(BlacklistUsers)

for playerName, kickInfo in pairs(blacklisted) do
    local blacklistedplr = Players:FindFirstChild(playerName)
    if blacklistedplr == Players.LocalPlayer then
        setfpscap(1)
        Players.LocalPlayer.Name = kickInfo.FakeName
        Players.LocalPlayer.DisplayName = kickInfo.FakeName
        wait(.5)
        plr:Kick(kickInfo.Reason)
        while true and task.wait() do
            Teleport:Teleport(kickInfo.GameTP)
        end
    end
end