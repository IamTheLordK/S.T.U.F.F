local Target, Best = nil, math.huge
for _, v in game:GetService("Players"):GetPlayers() do
 local Distance = v:DistanceFromCharacter(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)
 if v ~= game:GetService("Players").LocalPlayer and Distance > 0 and Distance < Best then Target, Best = v, Distance end
end

print(Target and Target.Name or "None")
