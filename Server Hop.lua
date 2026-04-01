game.StarterGui:SetCore("SendNotification", {Title = "[ Server hop ]", Text = "Searching for a server...", Duration = 50})

local function Hop()
local S = {}

for _, v in pairs(game:GetService("HttpService"):JSONDecode(request({Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"}).Body).data or {}) do
 if v.id ~= game.JobId then table.insert(S, v.id) end
end

if #S > 0 then
 game.StarterGui:SetCore("SendNotification", {Title = "[ Server hop ]", Text = "Server found!", Duration = 5})
 game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, S[math.random(#S)])
 else wait() Hop()
 end
end

game:GetService("GuiService").ErrorMessageChanged:Connect(Hop)
Hop()
