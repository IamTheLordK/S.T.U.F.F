local Char = game.Players.LocalPlayer.Character

local Target, Distance = nil, math.huge
for _, v in pairs(game.Players:GetPlayers()) do
 if v == game.Players.LocalPlayer then continue end
 local D = v:DistanceFromCharacter(Char.HumanoidRootPart.Position)
 if D > 0 and D < Distance then Target, Distance = v, D end
end

print(Player and Player.Name or "None")
