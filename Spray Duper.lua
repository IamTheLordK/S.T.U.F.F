local Char = game.Players.LocalPlayer.Character
local Amount = 50

workspace.Handle.CanCollide = false

for _ = 2, Amount do
 firetouchinterest(workspace.Handle, Char.HumanoidRootPart, 0)
 firetouchinterest(workspace.Handle, Char.HumanoidRootPart, 1)
 local T = Char.ChildAdded:Wait() task.wait(-math.huge)
 if T:IsA("Tool") then T.Parent = workspace end
end
