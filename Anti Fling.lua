while game:GetService("RunService").Stepped:Wait() do
 for _, P in game:GetService("Players"):GetPlayers() do
  if P == game:GetService("Players").LocalPlayer or not P.Character then continue end
  pcall(function()
   for _, V in P.Character:QueryDescendants("BasePart") do
    V.CanCollide = false
    if V.Name == "Torso" or V.Name == "HumanoidRootPart" then V.Massless = true end
    V.AssemblyLinearVelocity = Vector3.zero
    V.AssemblyAngularVelocity = Vector3.zero
   end
  end)
 end
end
