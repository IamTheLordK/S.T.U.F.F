local Char = game.Players.LocalPlayer.Character

local Player, Dist = nil, math.huge
for _, v in pairs(game.Players:GetPlayers()) do
 if v == game.Players.LocalPlayer then continue end
 local D = v:DistanceFromCharacter(Char.HumanoidRootPart.Position)
 if D > 0 and D < Dist then Player, Dist = v, D end
end

print(Player and Player.Name or "None")
