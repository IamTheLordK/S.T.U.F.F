local S = {}

for _, v in pairs(game:GetService("HttpService"):JSONDecode(request({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"}).Body).data) do
 if v.id ~= game.JobId then table.insert(S, v.id) end
end

if #S > 0 then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, S[math.random(1, #S)]) end
