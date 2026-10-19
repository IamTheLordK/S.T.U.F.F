-- "E" for impulse.
local Char = game.Players.LocalPlayer.Character
local Root = Char.HumanoidRootPart
local Clone = Root:Clone()
local Speed = Vector3.zero

Root.Parent = Clone
Root.RootJoint.Part0 = nil
Clone.Parent = Char
Char.Humanoid.AutoRotate = false
Char.Humanoid.HipHeight = -1.5

local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://42070810"
local Track = Char.Humanoid:LoadAnimation(Animation)
Track:Play(0, 1, 0)
Track.TimePosition = 1

game:GetService("UserInputService").InputBegan:Connect(function(v, p)
 if p or v.KeyCode ~= Enum.KeyCode.E then return end
 Speed += ((game.Players.LocalPlayer:GetMouse().Hit.Position - Clone.Position) * Vector3.new(1,0,1)).Unit * 100
end)

while Char.Parent do local v = game.RunService.PostSimulation:Wait()
 local Axis = Vector3.yAxis:Cross(Clone.AssemblyLinearVelocity)
 if Axis.Magnitude > 0.1 then Clone.RootJoint.C0 = Clone.CFrame.Rotation:Inverse() * CFrame.fromAxisAngle(Axis.Unit, Axis.Magnitude * v / 3) * Clone.CFrame.Rotation * Clone.RootJoint.C0 end

 Speed = Speed:Lerp(Char.Humanoid.MoveDirection * 30, 1 - math.exp(-5 * v))
 Clone.AssemblyLinearVelocity = Vector3.new(Speed.X, Clone.AssemblyLinearVelocity.Y, Speed.Z)

 Root.CFrame = Char.Torso.CFrame
 Root.AssemblyLinearVelocity = Clone.AssemblyLinearVelocity
end
