--allows using a continuous nitro when pressing E, E to toggle.
local Speed = 250

local Box = Instance.new("TextBox", Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")))

Box.Parent.ResetOnSpawn = false
Box.Size = UDim2.new(0,100,0,25)
Box.Position = UDim2.new(0,10,0,10)
Box.BackgroundColor3 = Color3.fromRGB(15,15,15)
Box.TextColor3 = Color3.fromRGB(200,200,200)
Box.Font = Enum.Font.Code
Box.TextSize = 14
Box.Text = tostring(Speed)
Box.PlaceholderText = "Speed"

Box.FocusLost:Connect(function() Speed = tonumber(Box.Text) or Speed end)

game:GetService("UserInputService").InputBegan:Connect(function(v)
 if v.KeyCode ~= Enum.KeyCode.E then return end
 local Char = game:GetService("Players").LocalPlayer.Character if not Char then return end
 local Humanoid = Char:FindFirstChild("Humanoid") if not Humanoid then return end
 local Seat = Humanoid.SeatPart if not Seat then return end
 if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightControl) then return end
 if Seat:FindFirstChild("BodyVelocity") then Seat.BodyVelocity:Destroy() return end

 local BodyV = Instance.new("BodyVelocity", Seat)
 BodyV.MaxForce = Vector3.new(9e9,0,9e9)
 while BodyV.Parent do task.wait()
  BodyV.Velocity = Seat.CFrame.LookVector * Speed
 end
end)
