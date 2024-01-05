repeat task.wait() until game:IsLoaded()

loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeUsers/main/Blacklist.lua", true))()

local Success, Error = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeXClient/main/GamesMobile/"..game.PlaceId..".lua", true))() end)
if Success then
    -- Loaded
elseif Error then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xysimdev/SmokeXClient/main/GamesMobile/Universal.lua", true))()
end