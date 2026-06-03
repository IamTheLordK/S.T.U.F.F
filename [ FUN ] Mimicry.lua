local TChar = game.Players["Here..."].Character
local Root = game.Players.LocalPlayer.Character.HumanoidRootPart
local TRoot = TChar.HumanoidRootPart

Root.Parent.Humanoid.AutoRotate = false
Root.CFrame = TRoot.CFrame

while Root.Parent and TRoot do game:GetService("RunService").RenderStepped:Wait()
 Root.Parent.Humanoid:Move(TChar.Humanoid.MoveDirection, false)
 Root.CFrame = CFrame.Angles(0, math.atan2(-TRoot.CFrame.LookVector.X, -TRoot.CFrame.LookVector.Z), 0) + Root.Position
end
