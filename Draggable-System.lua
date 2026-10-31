local Frame = Instance.new("Frame", Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")))

Frame.Parent.ResetOnSpawn = false
Frame.Size = UDim2.fromOffset(150,150)
Frame.Position = UDim2.new(0.5,-150,0.5,-100)
Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)

Frame.InputBegan:Connect(function(i)
 if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
 local Offset; while i.UserInputState ~= Enum.UserInputState.End do task.wait()
  local Position = i.UserInputType == Enum.UserInputType.Touch and i.Position or game:GetService("UserInputService"):GetMouseLocation()
  Offset = Offset or Frame.Position - UDim2.fromOffset(Position.X,Position.Y)
  Frame.Position = Frame.Position:Lerp(Offset + UDim2.fromOffset(Position.X,Position.Y), 0.5)
 end
end)
