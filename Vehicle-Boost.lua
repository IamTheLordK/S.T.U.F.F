-- allows using a continuous nitro when pressing E, E to toggle.
local Speed = 250

local S = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
S.ResetOnSpawn = false

local Box = Instance.new("TextBox", S)
Box.Size = UDim2.new(0, 100, 0, 26)
Box.Position = UDim2.new(0, 8, 0, 8)
Box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Box.TextColor3 = Color3.fromRGB(200, 200, 200)
Box.Font = Enum.Font.Code
Box.TextSize = 14
Box.Text = tostring(Speed)
Box.PlaceholderText = "Speed"


Box:GetPropertyChangedSignal("Text"):Connect(function()
 Speed = tonumber(Box.Text) or Speed
end)

game:GetService("UserInputService").InputBegan:Connect(function(Key)
 if Key.KeyCode ~= Enum.KeyCode.E then return end
 local Seat = game.Players.LocalPlayer.Character.Humanoid.SeatPart
 if not Seat then return end
 if Seat:FindFirstChild("BodyVelocity") then Seat.BodyVelocity:Destroy() return end

 local BodyV = Instance.new("BodyVelocity", Seat)
 BodyV.MaxForce = Vector3.new(9e9, 0, 9e9)
 while BodyV.Parent do game:GetService("RunService").RenderStepped:Wait()
  BodyV.Velocity = Seat.CFrame.LookVector * Speed
 end
end)
