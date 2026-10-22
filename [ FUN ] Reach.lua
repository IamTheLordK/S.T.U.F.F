--may not work on all games.
while task.wait() do
 local Char = game:GetService("Players").LocalPlayer.Character if not Char then continue end
 local Humanoid = Char:FindFirstChild("Humanoid") if not Humanoid then continue end
 local Root = Humanoid.RootPart if not Root then continue end
 local Arm = Char:FindFirstChild("Right Arm") or Char:FindFirstChild("RightHand") if not Arm then continue end
 local Grip = Arm:FindFirstChild("RightGrip") if not Grip then continue end

 local Target, Best = nil, math.huge
 for _, v in game:GetService("Players"):GetPlayers() do
  local Distance = v:DistanceFromCharacter(Root.Position)
  if v ~= game:GetService("Players").LocalPlayer and Distance > 0 and Distance < Best then Target, Best = v, Distance end
 end

 if not Target then continue end
 local TRoot = Target.Character:FindFirstChild("HumanoidRootPart") if not TRoot then continue end

 for _, v in pairs(Char:GetChildren()) do
  if v:IsA("Tool") and v:FindFirstChild("Handle") then v.Handle.Massless = true
   v.Grip = TRoot.CFrame:Inverse() * Arm.CFrame * Grip.C0
  end
 end
end
