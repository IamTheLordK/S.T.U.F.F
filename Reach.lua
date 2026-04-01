--may not work on all games.
local Char = game.Players.LocalPlayer.Character
local Arm = Char["Right Arm"] or Char["RightHand"]

-- // GetClosest
while Char.Humanoid.Health > 0 do task.wait()
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

-- // UnHoldToolAnim
for _, v in next, Char.Humanoid:GetPlayingAnimationTracks() do
 if v.Name == "ToolNoneAnim" then v:Stop() end
end

Char.Animate.toolnone.ToolNoneAnim.AnimationId = ""
