if game.PlaceId == 6872265039 then -- Bedwars lobby
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/BedwarsData/BedwarsLobbyLegit.lua", true))()
elseif game.PlaceId == 8560631822 or game.PlaceId == 6872274481 or game.PlaceId == 8444591321 then --Bedwars Solos, Duels 2v2, Doubles, Squads, LuckyBlock Squads, LuckyBlock Doubles, SkyWars Doubles, 30vs30
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/BedwarsData/BedwarsLegit.lua", true))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/GameLoader/Universal.lua", true))() --Universal
end