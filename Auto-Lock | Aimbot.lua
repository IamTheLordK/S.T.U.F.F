local Players = game:GetService("Players")

local TeamCheck = true -- // ctrl + r to toggle
local Method = "1" -- // method 1 → workspace.CurrentCamera | Method 2 → mousemoverel

local Enabled = true -- // mousebutton3 to toggle

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ LordK ]", Text = "Auto Lock", Duration = 5})

game:GetService("UserInputService").InputBegan:Connect(function(v)
 if v.UserInputType == Enum.UserInputType.MouseButton3 then Enabled = not Enabled
  if Method == "2" then game:GetService("UserInputService").MouseBehavior = Enabled and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default end
  game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Auto Lock ]", Text = Enabled and "Enabled" or "Disabled", Duration = 1})
  if not Enabled then mouse1release() end
 elseif v.KeyCode == Enum.KeyCode.R and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then TeamCheck = not TeamCheck
  game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[ Team Check ]", Text = TeamCheck and "Enabled" or "Disabled", Duration = 1})
 end
end)

while game.RunService.RenderStepped:Wait() do if not Enabled then continue end
 if not Players.LocalPlayer.Character then continue end

 local Target, MinD, Ignore = nil, 500, {} -- // max distance
 for _, v in Players:GetPlayers() do Ignore[#Ignore + 1] = v.Character end

 for _, v in Players:GetPlayers() do
  if v == Players.LocalPlayer then continue end
  if TeamCheck and v.Team ~= nil and v.Team == Players.LocalPlayer.Team then continue end
  local TChar = v.Character if not TChar then continue end
  local THead = TChar:FindFirstChild("Head") if not THead then continue end
  local THumanoid = TChar:FindFirstChildOfClass("Humanoid") if not THumanoid then continue end
  if THumanoid.Health <= 0.001 or TChar:FindFirstChildOfClass("ForceField") then continue end
  local Distance = Players.LocalPlayer:DistanceFromCharacter(THead.Position) if Distance >= MinD then continue end
  if #workspace.CurrentCamera:GetPartsObscuringTarget({THead.Position}, Ignore) == 0 then Target, MinD = THead, Distance end
 end

 if not Target then mouse1release() continue end

 local Screen = workspace.CurrentCamera:WorldToViewportPoint(Target.Position)
 local Delta = (Vector2.new(Screen.X, Screen.Y) - game:GetService("UserInputService"):GetMouseLocation()) * (Screen.Z > 0 and 1 or -1)

 if Method == "1" then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Target.Position)
 else mousemoverel(Delta.X / 2, Delta.Y / 2) end -- // lerp

 if Screen.Z > 0 and Delta.Magnitude <= 20 then mouse1press() else mouse1release() end
end
