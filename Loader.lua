local DiscordInvite = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Resources/BlacklistLoader.lua", true))()
DiscordInvite.Join("Sm2xSZBFDn")
local Success, Error = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Games/"..game.PlaceId..".lua", true))() end)
if Success then
    -- Loaded
elseif Error then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/Games/Universal.lua", true))()
end