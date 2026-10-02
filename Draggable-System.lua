local Frame = Instance.new("Frame", Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui))

Frame.Parent.ResetOnSpawn = false
Frame.Size = UDim2.new(0,150,0,150)
Frame.Position = UDim2.new(0.5,-150,0.5,-100)
Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)

local M = game.Players.LocalPlayer:GetMouse()

Frame.InputBegan:Connect(function(i)
if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
local Touch = i.UserInputType == Enum.UserInputType.Touch
local P = Touch and i.Position or Vector2.new(M.X,M.Y)
local OffX = Frame.AbsolutePosition.X - P.X
local OffY = Frame.AbsolutePosition.Y - P.Y
 while i.UserInputState ~= Enum.UserInputState.End do task.wait()
  P = Touch and i.Position or Vector2.new(M.X,M.Y)
  Frame.Position = Frame.Position:Lerp(UDim2.new(0,P.X+OffX,0,P.Y+OffY),0.1)
 end
end)
