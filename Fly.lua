local Input = game:GetService("UserInputService")

local Speed = 200
local Fly = false

game.Players.LocalPlayer.CharacterAdded:Connect(function() Fly = false end)

game:GetService("RunService").Heartbeat:Connect(function()
 if not Fly or not game.Players.LocalPlayer.Character then return end
 local Char = game.Players.LocalPlayer.Character
 local Root = Char.HumanoidRootPart
 local BodyV = Root:FindFirstChild("BodyVelocity")
 local BodyG = Root:FindFirstChild("BodyGyro")
 if not BodyV or not BodyG then return end
 BodyG.CFrame = workspace.CurrentCamera.CFrame
 BodyV.Velocity = Char.Humanoid.MoveDirection.Magnitude > 0 and (workspace.CurrentCamera.CFrame.LookVector * Char.Humanoid.MoveDirection:Dot(Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X, 0, workspace.CurrentCamera.CFrame.LookVector.Z).Unit) + workspace.CurrentCamera.CFrame.RightVector * Char.Humanoid.MoveDirection:Dot(Vector3.new(workspace.CurrentCamera.CFrame.RightVector.X, 0, workspace.CurrentCamera.CFrame.RightVector.Z).Unit)) * Speed or Vector3.zero
end)

Input.InputBegan:Connect(function(Key)
 if Key.KeyCode ~= Enum.KeyCode.E or not Input:IsKeyDown(Enum.KeyCode.LeftControl) then return end
 local Char = game.Players.LocalPlayer.Character
 local Root = Char.HumanoidRootPart
 Fly = not Fly
 Char.Humanoid.PlatformStand = Fly
 if Fly then
  local BodyG = Instance.new("BodyGyro", Root)
  BodyG.MaxTorque = Vector3.one * math.huge
  BodyG.CFrame = Root.CFrame
  local BodyV = Instance.new("BodyVelocity", Root)
  BodyV.MaxForce = Vector3.one * math.huge
  BodyV.Velocity = Vector3.zero
 else
  for _, V in pairs({"BodyGyro", "BodyVelocity"}) do if Root:FindFirstChild(V) then Root[V]:Destroy() end end
 end
end)
