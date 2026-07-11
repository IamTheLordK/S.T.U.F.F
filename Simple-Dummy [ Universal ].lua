local Players = game:GetService("Players")
local Char = Players.LocalPlayer.Character
Char.HumanoidRootPart.Anchored = true --removable

local D = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType.R6) --or R15


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
D.Name = ""
D.Parent = workspace
D.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + Char.HumanoidRootPart.CFrame.LookVector * 2.5
D.HumanoidRootPart.Transparency = 1
D.Humanoid.AutoRotate = true --enable shiftlock
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


workspace.CurrentCamera.CameraSubject = D

local State = "Idle"
local Anims = {}

for S, Id in pairs({Idle=180435571,Walk=180426354,Jump=180435792,Fall=180436148}) do
 local A = Instance.new("Animation")
 A.AnimationId = "rbxassetid://" .. Id
 Anims[S] = D.Humanoid:LoadAnimation(A)
end

Anims.Idle:Play()

while Char.Humanoid.Health > 0 do game:GetService("RunService").RenderStepped:Wait()

 --noclip; removable
 for _, v in D:QueryDescendants("BasePart") do v.CanCollide = false end

 --movement
 D.Humanoid.Jump = Char.Humanoid.Jump
 D.Humanoid:Move(Char.Humanoid.MoveDirection)

 local NState = D.Humanoid:GetState() == Enum.HumanoidStateType.Jumping and "Jump" or D.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and "Fall" or D.Humanoid:GetState() == Enum.HumanoidStateType.Running and (D.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle") or "Idle"
 if State ~= NState then if Anims[State] then Anims[State]:Stop(.2) end Anims[NState]:Play() State = NState end
end

wait(Players.RespawnTime) --removable
D:Destroy() --destroy dummy on death
