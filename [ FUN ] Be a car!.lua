local Char = game.Players.LocalPlayer.Character
local Speed = Vector3.zero

local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://264034706"
Char.Humanoid:LoadAnimation(Animation):Play(0, 1, 0)
Char.Humanoid.HipHeight = -1.5

while Char.Parent do local v = task.wait()
 Speed = Speed:Lerp(Char.Humanoid.MoveDirection * 100, 1 - math.exp(-v))
 Char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(Speed.X, Char.HumanoidRootPart.AssemblyLinearVelocity.Y, Speed.Z)
end
