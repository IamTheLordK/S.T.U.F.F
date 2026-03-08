local Input = game:GetService("UserInputService")
local Players = game:GetService("Players")

local TeamCheck = true -- // ctrl + r to toggle
local Enabled = true -- // mousebutton3 to toggle

local Method = "1" -- // method 1 → workspace.CurrentCamera | Method 2 → mousemoverel
local MaxD = 500 -- // max distance

local Ray = RaycastParams.new()
Ray.FilterType = Enum.RaycastFilterType.Blacklist

game.StarterGui:SetCore("SendNotification", {Title = "[ LordK ]", Text = "Auto Lock", Duration = 5})

Input.InputBegan:Connect(function(Key)
if Key.UserInputType == Enum.UserInputType.MouseButton3 then Enabled = not Enabled
 if Method == "2" then Input.MouseBehavior = Enabled and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default end
 game.StarterGui:SetCore("SendNotification", {Title = "[ Auto Lock ]", Text = Enabled and "Enabled" or "Disabled", Duration = 1})
 if not Enabled then mouse1release() end
elseif Key.KeyCode == Enum.KeyCode.R and Input:IsKeyDown(Enum.KeyCode.LeftControl) then TeamCheck = not TeamCheck
 game.StarterGui:SetCore("SendNotification", {Title = "[ Team Check ]", Text = TeamCheck and "Enabled" or "Disabled", Duration = 1})
end
end)

while game:GetService("RunService").RenderStepped:Wait() do
local Char = Players.LocalPlayer.Character
if not Char or not Char:FindFirstChild("Head") then continue end

Ray.FilterDescendantsInstances = {Char}
local Target, MinD = nil, math.huge

for _, P in ipairs(Players:GetPlayers()) do
 if P ~= Players.LocalPlayer and (not TeamCheck or P.Team ~= Players.LocalPlayer.Team) and P.Character and P.Character:FindFirstChild("Head") then
  local D = P:DistanceFromCharacter(Char.Head.Position)
  if D > 0 and D <= MaxD and D < MinD - 5 then
   local Hit = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, P.Character.Head.Position - workspace.CurrentCamera.CFrame.Position, Ray)
   if not Hit or Hit.Instance:IsDescendantOf(P.Character) then Target, MinD = P.Character, D end
  end
 end
end

if not Target then mouse1release() continue end

local Screen = workspace.CurrentCamera:WorldToViewportPoint(Target.Head.Position)
local X = Screen.X - Input:GetMouseLocation().X
local Y = Screen.Y - Input:GetMouseLocation().Y

if Enabled then
 if Method == "1" then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Target.Head.Position)
 else mousemoverel(Screen.Z > 0 and X or -X, Screen.Z > 0 and Y or -Y) end
end

if Enabled and X^2 + Y^2 <= 400 then mouse1press() else mouse1release() end
end
