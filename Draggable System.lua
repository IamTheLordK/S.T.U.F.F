local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Parent = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)

local M = game.Players.LocalPlayer:GetMouse()
local Drag, OffX, OffY = false, 0, 0

Frame.InputBegan:Connect(function(i)
 if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
 Drag = true
 OffX = Frame.AbsolutePosition.X - M.X
 OffY = Frame.AbsolutePosition.Y - M.Y
 
 while Drag do task.wait()
  Frame.Position = Frame.Position:Lerp(UDim2.new(0, M.X + OffX, 0, M.Y + OffY), 0.1)
 end
end)

Frame.InputEnded:Connect(function(i)
 if i.UserInputType == Enum.UserInputType.MouseButton1 then Drag = false end
end)
