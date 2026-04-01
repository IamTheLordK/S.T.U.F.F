local TChar = game.Players["Here..."].Character
local Root = game.Players.LocalPlayer.Character.HumanoidRootPart

setscriptable(Root.Parent.Humanoid, "WalkDirection", true)

while Root.Parent and TChar.HumanoidRootPart do game:GetService("RunService").RenderStepped:Wait()
 Root.Parent.Humanoid.WalkDirection = TChar.Humanoid.MoveDirection
 Root.CFrame = CFrame.Angles(0, math.atan2(-TChar.HumanoidRootPart.CFrame.LookVector.X, -TChar.HumanoidRootPart.CFrame.LookVector.Z), 0) + Root.Position
end
