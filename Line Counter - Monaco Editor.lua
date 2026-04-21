local Scroll = Instance.new("ScrollingFrame", Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui")))
Scroll.ScrollingDirection = Enum.ScrollingDirection.XY
Scroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Scroll.Position = UDim2.new(0.5, -275, 0.5, -175)
Scroll.Size = UDim2.new(0, 550, 0, 350)
Scroll.Parent.ResetOnSpawn = false
Scroll.ScrollBarThickness = 7.5

local Lines = Instance.new("TextLabel", Scroll)
Lines.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Lines.Size = UDim2.new(0, 30, 0, 20)
Lines.Font = Enum.Font.Code
Lines.TextColor3 = Color3.fromRGB(150, 150, 150)
Lines.TextSize = 15
Lines.TextYAlignment = Enum.TextYAlignment.Top

local Code = Instance.new("TextBox", Scroll)
Code.BackgroundTransparency = 1
Code.Text = ""
Code.Position = UDim2.new(0, 35, 0, 0)
Code.Font = Enum.Font.Code
Code.TextColor3 = Color3.fromRGB(255, 255, 255)
Code.TextSize = 15
Code.TextXAlignment = Enum.TextXAlignment.Left
Code.TextYAlignment = Enum.TextYAlignment.Top
Code.ClearTextOnFocus = false
Code.MultiLine = true
Code.TextWrapped = false

game:GetService("UserInputService").InputBegan:Connect(function(i)
if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
local P, Abs = i.Position, Scroll.AbsolutePosition
 if P.X >= Abs.X and P.X <= Abs.X + Scroll.AbsoluteSize.X and P.Y >= Abs.Y and P.Y <= Abs.Y + Scroll.AbsoluteSize.Y then Code:CaptureFocus()
 end
end)

local function Count()
local Clean = Code.Text:gsub("\13", ""):gsub("\t", "    ")
if Clean ~= Code.Text then Code.Text = Clean return end
local N = select(2, Clean:gsub("\n", "")) + 1
local T = table.create(N)
for i = 1, N do T[i] = i end
Lines.Text = table.concat(T, "\n")
local H = game:GetService("TextService"):GetTextSize(Clean == "" and " " or Clean, 15, Enum.Font.Code, Vector2.new(math.huge, math.huge)).Y
Lines.Size = UDim2.new(0, 30, 0, H)
Code.Size = UDim2.new(0, 2000, 0, H)
Scroll.CanvasSize = UDim2.new(0, 2000, 0, H)
Scroll.CanvasPosition = Vector2.new(Scroll.CanvasPosition.X, math.min(Scroll.CanvasPosition.Y, math.max(0, H - Scroll.AbsoluteSize.Y)))
end

Code:GetPropertyChangedSignal("Text"):Connect(Count)
Count()
