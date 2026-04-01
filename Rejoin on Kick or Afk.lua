game:GetService("GuiService").ErrorMessageChanged:Connect(function()
if #game.Players:GetPlayers() <= 1 then
 game.Players.LocalPlayer:Kick("\nRejoining...")
 wait()
 game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
else
 game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end
end)
--game.Players.LocalPlayer:Kick() -- uncomment to trigger rejoin manually / just rejoin.
