local Root = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart

while Root.Parent do game.RunService.PostSimulation:Wait()
 local V = Root.Velocity
 Root.Velocity = Vector3.one * 2^63
 game.RunService.PreRender:Wait()
 Root.Velocity = V
end
