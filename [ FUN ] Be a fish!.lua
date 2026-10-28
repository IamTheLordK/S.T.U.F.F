local Char = game.Players.LocalPlayer.Character
Char.Humanoid.EvaluateStateMachine = false

for _, v in Char:QueryDescendants("BasePart") do
 v.CustomPhysicalProperties = PhysicalProperties.new(0.7,0.3,1,1,100)
end

local Animation = Char.Humanoid.Animator:LoadAnimation(Char.Animate.walk.WalkAnim)
Animation.Looped = true
Animation:Play(0.1,1,10)

local BodyG = Instance.new("BodyGyro", Char.HumanoidRootPart)
BodyG.MaxTorque = Vector3.one * 1e5
BodyG.P = 5000

local Params = RaycastParams.new()
Params.FilterDescendantsInstances = {Char}

while BodyG.Parent do task.wait()
 BodyG.CFrame = CFrame.Angles(math.rad(90 + math.random(-40,40)), math.rad(math.random(-40,40)), math.rad(math.random(-40,40)))
 local Root = BodyG.Parent if not Root then continue end
 local Move = Root.Parent.Humanoid.MoveDirection
 Root.AssemblyLinearVelocity = Vector3.new(Move.X * 25 + math.random(-3,3), math.random(1,20) == 1 and workspace:Raycast(Root.Position, Vector3.new(0,-3,0), Params) and 40 or Root.AssemblyLinearVelocity.Y, Move.Z * 25 + math.random(-3,3))
end
