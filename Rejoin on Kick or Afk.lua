game:GetService("GuiService").ErrorMessageChanged:Connect(function()
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

--game.Players.LocalPlayer:Kick("\nRejoining...") -- uncomment to trigger rejoin manually / just rejoin.
