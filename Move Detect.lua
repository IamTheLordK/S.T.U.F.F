local Humanoid = game.Players.LocalPlayer.Character.Humanoid

Humanoid.Changed:Connect(function()
 if Humanoid.MoveDirection.Magnitude > 0 then print("Moving") else print("Idle") end
end)
