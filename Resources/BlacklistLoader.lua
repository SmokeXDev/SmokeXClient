local http_request = syn and syn.request or request;
local Players = game:GetService("Players")
local Teleport = game:GetService("TeleportService")
local BlacklistUsers = http_request({Url = "https://raw.githubusercontent.com/xysimdev/SmokeUsers/main/Blacklist.json", Method = 'GET'}).Body;
local blacklisted = game:GetService("HttpService"):JSONDecode(BlacklistUsers)

for playerName, kickInfo in pairs(blacklisted) do
    local blacklistedplr = Players:FindFirstChild(playerName)
    if blacklistedplr == Players.LocalPlayer then
        Players.LocalPlayer:Kick(kickInfo.Reason)
        setfpscap(1)
        Teleport:Teleport(kickInfo.GameTP)
    end
end