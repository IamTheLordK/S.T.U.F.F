local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character
local Humanoid = Char.Humanoid

local ToolN = "Spray"
local Rig = "R15"

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Player.UserId), Enum.HumanoidRigType[Rig])

Dummy.Name = ""
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)
Dummy.Parent = workspace

Dummy.Humanoid.HipHeight = 2.75 -- modifiable

workspace.CurrentCamera.CameraSubject = Dummy

local R6 = Rig == "R6"

local Tracks = {}
local Last = "idle"

for k, v in {idle = R6 and 180435571 or 507766388, walk = R6 and 180426354 or 507777826, jump = R6 and 125750702 or 507765000, fall = R6 and 180436148 or 507767968} do
 local Animation = Instance.new("Animation")
 Animation.AnimationId = "rbxassetid://"..v
 Tracks[k] = Dummy.Humanoid:LoadAnimation(Animation)
end

Tracks.idle:Play()

task.spawn(function()
 while Char.Parent and Humanoid.Health > 0 do task.wait()
  for _, v in pairs(Dummy:QueryDescendants("BasePart[CanCollide = true]")) do v.CanCollide = false end

  Dummy.Humanoid.Jump = Humanoid.Jump
  Dummy.Humanoid:Move(Humanoid.MoveDirection)

  local State = Dummy.Humanoid:GetState()
  local Name = State == Enum.HumanoidStateType.Jumping and "jump" or State == Enum.HumanoidStateType.Freefall and "fall" or Humanoid.MoveDirection.Magnitude > 0 and "walk" or "idle"

  if Name ~= Last then
   Tracks[Last]:Stop(0.1)
   Tracks[Name]:Play(0.1)
   Last = Name
  end
 end

 Dummy:BreakJoints()
 task.delay(Players.RespawnTime, Dummy.Destroy, Dummy)
end)


for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do v:Stop(0) end
Char.HumanoidRootPart.Anchored = true
Humanoid.AutoRotate = false
Char.Animate.Disabled = true

for _, v in pairs(Dummy:QueryDescendants("BasePart")) do v.Transparency = 1 end

local Limbs = Dummy:QueryDescendants("> BasePart:not(#HumanoidRootPart)")

local Tools = {}
for _, v in pairs(Player.Backpack:QueryDescendants("Tool")) do
 if v.Name == ToolN and #Tools < #Limbs then table.insert(Tools, v) end
end

for _, v in pairs(Tools) do
 v.Handle.Massless = true
 v.Handle.CanCollide = false
 v.ManualActivationOnly = true
 v.Handle:GetPropertyChangedSignal("CanCollide"):Connect(function() v.Handle.CanCollide = false end)
end

task.spawn(function()
 while Char.Parent do task.wait(0.0999)
  for _, v in pairs(Tools) do v.Parent = Player.Backpack end
  for _, v in pairs(Tools) do v.Parent = Char end
 end
end)

while Char.Parent do game.RunService.PostSimulation:Wait()
 local Grip = Char:FindFirstChild("RightGrip", true) if not Grip then continue end
 for i, v in pairs(Tools) do
  v.Grip = Limbs[i].CFrame:Inverse() * Grip.Part0.CFrame * Grip.C0
  v.Handle.CFrame = Limbs[i].CFrame
 end
end
