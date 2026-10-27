local function Hop()
 while task.wait() do
  local Servers = {}
  for _, v in pairs(game:GetService("HttpService"):JSONDecode(request({Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"}).Body).data or {}) do
   if v.id ~= game.JobId then table.insert(Servers, v.id) end
  end
  if #Servers > 0 then
   game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Server hop ]", Text = "Server found!", Duration = 5})
   game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Servers[math.random(#Servers)])
   return
  end
 end
end

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Server hop ]", Text = "Searching for a server...", Duration = 50})
game:GetService("GuiService").ErrorMessageChanged:Connect(Hop)
Hop()
