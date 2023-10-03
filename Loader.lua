repeat task.wait() until game:IsLoaded()

loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/BlacklistLoader.lua", true))()
local DiscordInvite = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()
DiscordInvite.Join("tzDKuCxKTE")

local Success, Error = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Games/"..game.PlaceId..".lua", true))() end)
if Success then
    -- Loaded
elseif Error then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Games/Universal.lua", true))()
end