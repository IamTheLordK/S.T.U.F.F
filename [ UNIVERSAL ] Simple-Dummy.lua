local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character

Char.HumanoidRootPart.Anchored = true --removable

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Player.UserId), Enum.HumanoidRigType.R15) --modifiable (R6 or R15)

Dummy.Name = ""
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)
Dummy.Parent = workspace

workspace.CurrentCamera.CameraSubject = Dummy

local R6 = Dummy.Humanoid.RigType == Enum.HumanoidRigType.R6

local Tracks = {}
local Last = "idle"

for k, v in {idle = R6 and 180435571 or 507766388, walk = R6 and 180426354 or 507777826, jump = R6 and 125750702 or 507765000, fall = R6 and 180436148 or 507767968} do
 local Animation = Instance.new("Animation")
 Animation.AnimationId = "rbxassetid://"..v
 Tracks[k] = Dummy.Humanoid:LoadAnimation(Animation)
end

Tracks.idle:Play()

task.spawn(function()
 while Char.Parent and Char.Humanoid.Health > 0 do task.wait()
  for _, v in pairs(Dummy:QueryDescendants("BasePart[CanCollide = true]")) do v.CanCollide = false end --noclip; removable

  Dummy.Humanoid.Jump = Char.Humanoid.Jump
  Dummy.Humanoid:Move(Char.Humanoid.MoveDirection)

  local State = Dummy.Humanoid:GetState()
  local Name = State == Enum.HumanoidStateType.Jumping and "jump" or State == Enum.HumanoidStateType.Freefall and "fall" or Char.Humanoid.MoveDirection.Magnitude > 0 and "walk" or "idle"

  if Name ~= Last then
   Tracks[Last]:Stop(0.1)
   Tracks[Name]:Play(0.1)
   Last = Name
  end
 end

 Dummy:BreakJoints() --removable
 task.delay(Players.RespawnTime, Dummy.Destroy, Dummy) --removable
end)

--local Limbs = {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg","HumanoidRootPart"}
--local Limbs = {"Head","UpperTorso","LowerTorso","LeftUpperArm","LeftLowerArm","LeftHand","RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot","HumanoidRootPart"}
