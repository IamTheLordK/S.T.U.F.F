local Players = game:GetService("Players")

local Char = Players.LocalPlayer.Character
local Humanoid = Char and Char:FindFirstChild("Humanoid")
local Root = Char and Char:FindFirstChild("HumanoidRootPart")
if not Char or not Humanoid or not Root then return end

Root.Anchored = true --removable

local Dummy = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType.R6) --or R15


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
Dummy.Name = ""
Dummy.Parent = workspace
Dummy.HumanoidRootPart.CFrame = Root.CFrame + Root.CFrame.LookVector * 2.5
Dummy.HumanoidRootPart.Transparency = 1
Dummy.Humanoid.AutoRotate = true --enable shiftlock
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


workspace.CurrentCamera.CameraSubject = Dummy

local State = "Idle"
local Anims = {}

for S, Id in pairs({Idle=180435571,Walk=180426354,Jump=180435792,Fall=180436148}) do
 local A = Instance.new("Animation")
 A.AnimationId = "rbxassetid://" .. Id
 Anims[S] = Dummy.Humanoid:LoadAnimation(A)
end

Anims.Idle:Play()

while Humanoid.Health > 0 do game:GetService("RunService").RenderStepped:Wait()

 --noclip; removable
 for _, v in pairs(Dummy:QueryDescendants("BasePart")) do v.CanCollide = false end

 --movement
 Dummy.Humanoid.Jump = Humanoid.Jump
 Dummy.Humanoid:Move(Humanoid.MoveDirection)

 local NState = Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Jumping and "Jump" or Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and "Fall" or Dummy.Humanoid:GetState() == Enum.HumanoidStateType.Running and (Dummy.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle") or "Idle"
 if State ~= NState then if Anims[State] then Anims[State]:Stop(.2) end Anims[NState]:Play() State = NState end
end

wait(Players.RespawnTime) --removable
Dummy:Destroy() --destroy dummy on death; removable
