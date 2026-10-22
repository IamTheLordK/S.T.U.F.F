local Players = game:GetService("Players")
local Char = Players.LocalPlayer.Character
local Humanoid = Char.Humanoid

local ToolN = "[Block]"

local State = "Idle"
local Anims = {}

for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do v:Stop(0) end
Char.HumanoidRootPart.Anchored = true
Humanoid.AutoRotate = false
Char.Animate.Disabled = true

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType.R6)
Dummy.Name = ""
Dummy.Parent = workspace
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5)

workspace.CurrentCamera.CameraSubject = Dummy

local Parts = Dummy:QueryDescendants("BasePart")
for _, v in pairs(Parts) do v.Transparency = 1 end

for k, v in pairs({Idle = 180435571, Walk = 180426354, Jump = 180435792, Fall = 180436148}) do
 local Animation = Instance.new("Animation")
 Animation.AnimationId = "rbxassetid://" .. v
 Anims[k] = Dummy.Humanoid:LoadAnimation(Animation)
end

Anims.Idle:Play()

local Limbs = {
 Dummy.Head,
 Dummy.Torso,
 Dummy["Left Arm"],
 Dummy["Right Arm"],
 Dummy["Left Leg"],
 Dummy["Right Leg"]
}

local Tools = {}
for _, v in pairs(Players.LocalPlayer.Backpack:QueryDescendants("Tool")) do
 if v.Name == ToolN and #Tools < 6 then table.insert(Tools, v) end
end

for _, v in pairs(Tools) do
 v.Handle.Massless = true
 v.ManualActivationOnly = true
end

task.spawn(function()
 while Humanoid.Health ~= 0 do task.wait(0.0999)
  for _, v in pairs(Tools) do v.Handle.CanCollide = false v.Parent = Players.LocalPlayer.Backpack end
  for _, v in pairs(Tools) do v.Handle.CanCollide = false v.Parent = Char end
 end
end)

while Humanoid.Health ~= 0 do game.RunService.RenderStepped:Wait()
 for _, v in pairs(Parts) do v.CanCollide = false end
 Dummy.Humanoid.Jump = Humanoid.Jump
 Dummy.Humanoid:Move(Humanoid.MoveDirection)

 local Type = Dummy.Humanoid:GetState()
 local CState = Type == Enum.HumanoidStateType.Jumping and "Jump" or Type == Enum.HumanoidStateType.Freefall and "Fall" or Type == Enum.HumanoidStateType.Running and Dummy.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle"
 if State ~= CState then
  Anims[State]:Stop(.2)
  Anims[CState]:Play()
  State = CState
 end

 local Grip = Char["Right Arm"]:FindFirstChild("RightGrip") if not Grip then continue end
 for i, v in pairs(Tools) do
  v.Grip = Limbs[i].CFrame:Inverse() * Char["Right Arm"].CFrame * Grip.C0
  v.Handle.CFrame = Limbs[i].CFrame
 end
end

Dummy:Destroy()
