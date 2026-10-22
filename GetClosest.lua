local Target, Best = nil, math.huge
for _, v in game.Players:GetPlayers() do
 local Distance = v:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
 if v ~= game.Players.LocalPlayer and Distance > 0 and Distance < Best then Target, Best = v, Distance end
end

print(Target and Target.Name or "None")
