local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character
local Arm = Char["Right Arm"]


local ToolN = "Spray"


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
for _, v in pairs(Char.Humanoid:GetPlayingAnimationTracks()) do v:Stop(0) end
Char.HumanoidRootPart.Anchored = true
Char.Humanoid.AutoRotate = false
Char.Animate.Disabled = true

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Player.UserId), Enum.HumanoidRigType.R6)
Dummy.Name = ""
Dummy.Parent = workspace
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + Char.HumanoidRootPart.CFrame.LookVector * 2.5
Dummy.Humanoid.AutoRotate = true

workspace.CurrentCamera.CameraSubject = Dummy

local State = "Idle"
local Anims = {}

for S, Id in pairs({Idle=180435571,Walk=180426354,Jump=180435792,Fall=180436148}) do
 local A = Instance.new("Animation")
 A.AnimationId = "rbxassetid://" .. Id
 Anims[S] = Dummy.Humanoid:LoadAnimation(A)
end

Anims.Idle:Play()

task.spawn(function()
 while Char.Humanoid.Health ~= 0 do game:GetService("RunService").RenderStepped:Wait()
  for _, v in pairs(Dummy:QueryDescendants("BasePart")) do v.CanCollide = false end
  Dummy.Humanoid.Jump = Char.Humanoid.Jump
  Dummy.Humanoid:Move(Char.Humanoid.MoveDirection)

  local NState = Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Jumping and "Jump" or Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and "Fall" or Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Running and (Dummy.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle") or "Idle"

  if State ~= NState then
   if Anims[State] then Anims[State]:Stop(.2) end
   Anims[NState]:Play()
   State = NState
  end
 end
 Dummy:Destroy()
end)

for _, v in pairs(Dummy:QueryDescendants("BasePart")) do v.Transparency = 1 end
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


local Limbs = {
 Dummy.Head,
 Dummy.Torso,
 Dummy["Left Arm"],
 Dummy["Right Arm"],
 Dummy["Left Leg"],
 Dummy["Right Leg"]
}

local Tools = {}
for _, v in pairs(Player.Backpack:QueryDescendants("Tool")) do
 if v.Name == ToolN and #Tools < 6 then table.insert(Tools, v) end
end

for _, v in pairs(Tools) do
 v.Handle.Massless = true
 v.ManualActivationOnly = true
end

task.spawn(function()
 while Char.Humanoid.Health ~= 0 do task.wait(0.0999)
  for _, v in pairs(Tools) do v.Handle.CanCollide = false v.Parent = Player.Backpack end
  for _, v in pairs(Tools) do v.Handle.CanCollide = false v.Parent = Char end
 end
end)

task.spawn(function()
 while Char.Humanoid.Health ~= 0 do game.RunService.RenderStepped:Wait()
  if not Arm:FindFirstChild("RightGrip") then continue end
  for i, v in pairs(Tools) do
   v.Grip = Limbs[i].CFrame:Inverse() * Arm.CFrame * Arm.RightGrip.C0
   v.Handle.CFrame = Limbs[i].CFrame
  end
 end
end)
