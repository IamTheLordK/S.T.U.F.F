while game.RunService.Stepped:Wait() do
 for _, v in game:GetService("Players"):GetPlayers() do
  if v ~= game:GetService("Players").LocalPlayer and v.Character then
   for _, k in v.Character:QueryDescendants("BasePart[CanCollide = true]") do k.CanCollide = false end
  end
 end
end
