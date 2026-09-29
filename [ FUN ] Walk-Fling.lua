local Root = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart

while Root.Parent do 
 game.RunService.PostSimulation:Wait()
 local V = Root.AssemblyLinearVelocity
 Root.AssemblyLinearVelocity = Vector3.one * 2^63
 game.RunService.PreRender:Wait()
 Root.AssemblyLinearVelocity = V
end
