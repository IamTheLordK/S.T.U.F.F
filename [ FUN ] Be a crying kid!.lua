game.Players.LocalPlayer.Character.Humanoid.EvaluateStateMachine = false

for _, v in game.Players.LocalPlayer.Character:QueryDescendants("BasePart") do
 v.CustomPhysicalProperties = PhysicalProperties.new(0.7,0.3,1,1,100)
end

local Animation = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.Players.LocalPlayer.Character.Animate.walk.WalkAnim)
Animation.Looped = true
Animation:Play(0.1,1,10)

local BodyG = Instance.new("BodyGyro", game.Players.LocalPlayer.Character.HumanoidRootPart)
BodyG.MaxTorque = Vector3.one * 1e5
BodyG.P = 2000

while BodyG.Parent do task.wait()
 BodyG.CFrame = CFrame.Angles(math.rad(90 + math.random(-30,30)), math.rad(math.random(-30,30)), math.rad(math.random(-30,30)))
end
