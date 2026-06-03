local Char = game.Players.LocalPlayer.Character
local Run = game:GetService("RunService")

setscriptable(Char.Humanoid, "MoveDirectionInternal", true)

while Char == game.Players.LocalPlayer.Character do
 Run.Heartbeat:Wait()
 local D = Char.Humanoid.MoveDirectionInternal
 Char.Humanoid.MoveDirectionInternal = Vector3.one * 0/0
 Run.PreSimulation:Wait()
 Char.Humanoid.MoveDirectionInternal = D
end
