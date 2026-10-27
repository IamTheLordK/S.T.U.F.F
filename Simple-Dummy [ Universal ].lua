local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character

Char.HumanoidRootPart.Anchored = true --removable

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Player.UserId), Char.Humanoid.RigType)

Dummy.Name = ""
Dummy.Parent = Char --LocalScripts only run inside your Character
Dummy.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)

local Animate = Char.Animate:Clone()
Animate.Parent = Dummy
task.wait(1) --Animate caches script.Parent on start
Animate.Parent = Char
Dummy.Parent = workspace

workspace.CurrentCamera.CameraSubject = Dummy

task.spawn(function()
 while Char.Parent and Char.Humanoid.Health > 0 do task.wait()
  for _, v in pairs(Dummy:QueryDescendants("BasePart[CanCollide = true]")) do v.CanCollide = false end --noclip; removable

  Dummy.Humanoid.Jump = Char.Humanoid.Jump
  Dummy.Humanoid:Move(Char.Humanoid.MoveDirection)
 end

 Dummy:BreakJoints() --removable
 task.delay(Players.RespawnTime, Dummy.Destroy, Dummy) --removable
end)
