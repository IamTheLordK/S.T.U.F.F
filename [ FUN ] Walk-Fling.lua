local Char = game:GetService("Players").LocalPlayer.Character

while Char.Parent do game.RunService.Heartbeat:Wait()
 local V = Char.HumanoidRootPart.AssemblyLinearVelocity
 Char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.one * 2^63
 game:GetService("RunService").RenderStepped:Wait()
 Char.HumanoidRootPart.AssemblyLinearVelocity = V
end
