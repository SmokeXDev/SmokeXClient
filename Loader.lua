loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/BlacklistV2/BlacklistLoader.lua", true))()
loadstring(game:HttpGet("https://github.com/SmokeXDev/SmokeXClient/blob/main/assets/LogoLoader.lua", true))()

local GameID = tostring(game.PlaceId)
local GameLoaderV1Supported = {
    ["6872265039"] = true, --Bedwars Lobby
    ["8560631822"] = true, --Bedwars Solos, Duels 2v2
    ["6872274481"] = true, --Bedwars Doubles, Squads, LuckyBlock Squads, LuckyBlock Doubles, SkyWars Doubles
    ["8444591321"] = true, --Bedwars 30vs30
}
local GameLoaderV2Supported = {
    ["155615604"] = true, --Prison Life
    ["12359884880"] = true, --[NEW] +1 Speed Race
    ["13958693327"] = true, --Math Wall Simulator
    ["11912525919"] = true, --Every Second You Get +1
    ["815405518"] = true, --The Floor Is lava
    ["9791603388"] = true, --Underground War 2.0 ⚔️ [NUKE]
    ["9285238704"] = true --Race Clicker
}

if GameLoaderV1Supported[GameID] ~= nil then
    local scriptUrl = "https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/GameLoader/" .. GameID .. ".lua"
    loadstring(game:HttpGet(scriptUrl, true))()
elseif GameLoaderV2Supported[GameID] ~= nil then
    local scriptUrl = "https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/GameLoaderV2/" .. GameID .. ".lua"
    loadstring(game:HttpGet(scriptUrl, true))()
else
    local scriptUrl = "https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/GameLoaderV2/Universal.lua"
    loadstring(game:HttpGet(scriptUrl, true))()
end