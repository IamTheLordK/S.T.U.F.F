for _, v in game:GetService("Players"):GetPlayers() do
 if v ~= game.Players.LocalPlayer then game.Players.LocalPlayer:RequestFriendship(v) end
end
