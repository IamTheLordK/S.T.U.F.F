local Count = 0

for _, v in pairs(game.Players.LocalPlayer.Backpack:QueryDescendants("Tool")) do
 v.Parent = game.Players.LocalPlayer.Character
 if Count == 0 then v.Grip = CFrame.new(-2, 1.75, 0.8) * CFrame.Angles(0, 3.175, 0)
 elseif Count == 1 then v.Grip = CFrame.new(-1, 1.75, 0.8) * CFrame.Angles(0, 3.175, 0)
 else v.Grip = CFrame.new(-1.5, 1.75, 1.25 - Count * 0.2) * CFrame.Angles(0, 3.175, 0) end
 Count += 1
end
