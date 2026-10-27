local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character
local Humanoid = Char.Humanoid

local ToolN = "[Block]"

local Animate = Char.Animate:Clone()

for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do v:Stop(0) end
Char.HumanoidRootPart.Anchored = true
Humanoid.AutoRotate = false
Char.Animate.Disabled = true

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Player.UserId), Enum.HumanoidRigType.R6)

Dummy.Name = ""
Dummy.Parent = Char
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)

for _, v in pairs(Dummy:QueryDescendants("BasePart")) do v.Transparency = 1 end

Animate.Parent = Dummy
task.wait(1)
Animate.Parent = Char
Dummy.Parent = workspace

workspace.CurrentCamera.CameraSubject = Dummy

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
 while Char.Parent and Humanoid.Health > 0 do task.wait(0.0999)
  for _, v in pairs(Tools) do
   v.Handle.CanCollide = false
   v.Parent = Player.Backpack
  end
  for _, v in pairs(Tools) do
   v.Handle.CanCollide = false
   v.Parent = Char
  end
 end
end)

while Char.Parent and Humanoid.Health > 0 do game.RunService.RenderStepped:Wait()
 for _, v in pairs(Dummy:QueryDescendants("BasePart[CanCollide = true]")) do v.CanCollide = false end

 Dummy.Humanoid.Jump = Humanoid.Jump
 Dummy.Humanoid:Move(Humanoid.MoveDirection)

 local Grip = Char["Right Arm"]:FindFirstChild("RightGrip") if not Grip then continue end
 for i, v in pairs(Tools) do
  v.Grip = Limbs[i].CFrame:Inverse() * Char["Right Arm"].CFrame * Grip.C0
  v.Handle.CFrame = Limbs[i].CFrame
 end
end

Dummy:Destroy()
