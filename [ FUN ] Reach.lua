--may not work on all games.
-- // GetClosest
while task.wait() do
 local Char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
 if not Char:FindFirstChild("Humanoid") or Char.Humanoid.Health <= 0 then continue end
 local Arm = Char["Right Arm"] or Char["RightHand"]
 local Target, Distance = nil, math.huge

 for _, v in pairs(game.Players:GetPlayers()) do
  if v == game.Players.LocalPlayer then continue end
  local D = v:DistanceFromCharacter(Char.HumanoidRootPart.Position)
  if D > 0 and D < Distance then Target, Distance = v, D end
 end

 -- // Grip to CFrame
 if not (Target and Target.Character) then continue end
 for _, Tool in pairs(Char:GetChildren()) do
  if Tool:IsA("Tool") and Tool:FindFirstChild("Handle") and Arm:FindFirstChild("RightGrip") then
   Tool.Handle.Massless = true
   Tool.Grip = Target.Character.HumanoidRootPart.CFrame:Inverse() * Arm.CFrame * Arm.RightGrip.C0
  end
 end
end
