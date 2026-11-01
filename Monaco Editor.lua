local Background = Instance.new("Frame", Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")))
local Header = Instance.new("Frame", Background)
local Scroll = Instance.new("ScrollingFrame", Background)
local Lines = Instance.new("TextLabel", Scroll)
local Code = Instance.new("TextBox", Scroll)

Background.Parent.ResetOnSpawn = false
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,-275,0.5,-188)
Background.Size = UDim2.new(0,550,0,376)

Header.BackgroundColor3 = Color3.fromRGB(22,22,22)
Header.Size = UDim2.new(0,550,0,26)

Scroll.BackgroundColor3 = Color3.fromRGB(15,15,15)
Scroll.Position = UDim2.new(0,0,0,26)
Scroll.Size = UDim2.new(0,550,0,350)
Scroll.ScrollBarThickness = 10
Scroll.ScrollBarImageColor3 = Color3.fromRGB(135,135,135)
Scroll.TopImage = Scroll.MidImage
Scroll.BottomImage = Scroll.MidImage
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.XY
Scroll.CanvasSize = UDim2.new()

Lines.BackgroundColor3 = Color3.fromRGB(15,15,15)
Lines.Size = UDim2.new(0,30,0,350)
Lines.AutomaticSize = Enum.AutomaticSize.Y
Lines.Font = Enum.Font.Code
Lines.TextColor3 = Color3.fromRGB(150,150,150)
Lines.TextSize = 15
Lines.TextYAlignment = Enum.TextYAlignment.Top
Lines.Text = "1"

Code.BackgroundTransparency = 1
Code.Position = UDim2.new(0,35,0,0)
Code.Size = UDim2.new(0,500,0,350)
Code.AutomaticSize = Enum.AutomaticSize.XY
Code.Font = Enum.Font.Code
Code.TextColor3 = Color3.fromRGB(255,255,255)
Code.TextSize = 15
Code.TextXAlignment = Enum.TextXAlignment.Left
Code.TextYAlignment = Enum.TextYAlignment.Top
Code.ClearTextOnFocus = false
Code.MultiLine = true
Code.Text = ""

Code:GetPropertyChangedSignal("Text"):Connect(function()
 local Clean = Code.Text:gsub("\r", ""):gsub("\t", "    ")
 if Clean ~= Code.Text then Code.Text = Clean return end; local N = 1
 Lines.Text = "1" .. Clean:gsub("[^\n]", ""):gsub("\n", function() N += 1 return "\n" .. N end)
end)

Header.InputBegan:Connect(function(i)
 if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
 local Offset; while i.UserInputState ~= Enum.UserInputState.End do task.wait()
  local Position = i.UserInputType == Enum.UserInputType.Touch and i.Position or game:GetService("UserInputService"):GetMouseLocation()
  Offset = Offset or Background.Position - UDim2.fromOffset(Position.X,Position.Y)
  Background.Position = Background.Position:Lerp(Offset + UDim2.fromOffset(Position.X,Position.Y), 0.125)
 end
end)
