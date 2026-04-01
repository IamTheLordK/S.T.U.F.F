local Char = game:GetService("Players").LocalPlayer.Character
Char.Humanoid:ChangeState(11)

while Char.Parent do game:GetService("RunService").Heartbeat:Wait()
 local V = Char.HumanoidRootPart.AssemblyLinearVelocity
 Char.HumanoidRootPart.AssemblyLinearVelocity = V * 2^63
 game:GetService("RunService").RenderStepped:Wait()
 Char.HumanoidRootPart.AssemblyLinearVelocity = V
 game:GetService("RunService").Stepped:Wait()
 Char.HumanoidRootPart.AssemblyLinearVelocity = V
end
