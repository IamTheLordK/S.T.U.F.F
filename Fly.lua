local Speed = 200

game:GetService("UserInputService").InputBegan:Connect(function(v)
 if v.KeyCode ~= Enum.KeyCode.E or not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
 local Char = game:GetService("Players").LocalPlayer.Character if not Char then return end
 local Root = Char:FindFirstChild("HumanoidRootPart") if not Root then return end
 local BodyV = Root:FindFirstChild("BodyVelocity")
 Char.Humanoid.PlatformStand = not BodyV
 if BodyV then
  BodyV:Destroy()
  Root.BodyGyro:Destroy()
  Root.CFrame = CFrame.lookAt(Root.Position, Root.Position + Root.CFrame.LookVector * Vector3.new(1,0,1))
  return end
 BodyV = Instance.new("BodyVelocity", Root)
 BodyV.MaxForce = Vector3.one * math.huge
 local BodyG = Instance.new("BodyGyro", Root)
 BodyG.MaxTorque = Vector3.one * math.huge
 BodyG.CFrame = Root.CFrame
 while BodyV:IsDescendantOf(workspace) do task.wait()
  Root.Velocity = Vector3.zero
  Root.AssemblyLinearVelocity = Vector3.zero
  Root.AssemblyAngularVelocity = Vector3.zero
  BodyG.CFrame = workspace.CurrentCamera.CFrame
  BodyV.Velocity = CFrame.fromAxisAngle(workspace.CurrentCamera.CFrame.RightVector, math.asin(workspace.CurrentCamera.CFrame.LookVector.Y)) * Char.Humanoid.MoveDirection * Speed
 end
end)
