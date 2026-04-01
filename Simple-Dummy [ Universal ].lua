local Players = game:GetService("Players")
local Char = Players.LocalPlayer.Character
Char.Head.Anchored = true

local D = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType.R6)

D.Name = ""
D.Parent = workspace
D.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
D.HumanoidRootPart.Transparency = 1

workspace.CurrentCamera.CameraSubject = D.Humanoid

local State = "Idle"
local Anims = {}

for S, Id in pairs({Idle=180435571,Walk=180426354,Jump=180435792,Fall=180436148}) do
 local A = Instance.new("Animation")
 A.AnimationId = "rbxassetid://" .. Id
 Anims[S] = D.Humanoid:LoadAnimation(A)
end

Anims.Idle:Play()

while Char.Humanoid.Health > 0 do game:GetService("RunService").RenderStepped:Wait()
 
 if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter then
  D.HumanoidRootPart.CFrame = CFrame.new(D.HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(-workspace.CurrentCamera.CFrame.LookVector.X, -workspace.CurrentCamera.CFrame.LookVector.Z), 0)
 end

 for _, v in D:QueryDescendants("BasePart") do v.CanCollide = false end

 D.Humanoid.Jump = Char.Humanoid.Jump
 D.Humanoid:Move(Char.Humanoid.MoveDirection)

 local NState = D.Humanoid:GetState() == Enum.HumanoidStateType.Jumping and "Jump" or D.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and "Fall" or D.Humanoid:GetState() == Enum.HumanoidStateType.Running and (D.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle") or "Idle"
 if State ~= NState then if Anims[State] then Anims[State]:Stop(.2) end Anims[NState]:Play() State = NState end
end

D:Destroy() -- Destroy Dummy on Death
