local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local Moving = false

Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
 if (Humanoid.MoveDirection.Magnitude > 0) ~= Moving then Moving = not Moving print(Moving and "Moving" or "Idle") end
end)
