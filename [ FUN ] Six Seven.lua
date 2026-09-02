local Tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
Tool.RequiresHandle = false
Tool.Name = "67"

local A = Instance.new("Animation")
A.AnimationId = "rbxassetid://69932360"
local Track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(A)

local _67 = false

Tool.Equipped:Connect(function() _67 = true end)
Tool.Unequipped:Connect(function() _67 = false end)

while task.wait() do
 if _67 then
  Track:Play(0.2, 1, 2)
  task.wait(0.5)
  Track:Stop()
 end
end
