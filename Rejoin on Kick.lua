game:GetService("GuiService").ErrorMessageChanged:Connect(function() -- fires when any error message appears kick, inactivity, etc.
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

--game.Players.LocalPlayer:Kick("Rejoining...") -- uncomment to trigger rejoin manually / just rejoin.
