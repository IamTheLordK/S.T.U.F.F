local Players = game:GetService("Players")
local Char = Players.LocalPlayer.Character

-- // DummyC
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
local DTransparency = 0 -- // Dummy Transparency

local ClearH = false --// Clear Handles / Hats
local AntiV = true ---// Anti Void / FallenPDH
local DDD = false ---// Destroy Dummy on Death

local RType = "R6" -- // R6 or R15

local D = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType[RType])

D.Name = ""
D.Parent = workspace
D.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)

Char.Humanoid.WalkSpeed = 0
Char.Humanoid.JumpPower = 0

workspace.CurrentCamera.CameraSubject = D.Humanoid
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Spawn = D.HumanoidRootPart.CFrame
local State = "Idle"
local Anims = {}

for S, Id in pairs(RType == "R6" and {Idle=180435571,Walk=180426354,Jump=180435792,Fall=180436148} or {Idle=507766388,Walk=507777826,Jump=507765000,Fall=507767968}) do
 local A = Instance.new("Animation")
 A.AnimationId = "rbxassetid://" .. Id
 Anims[S] = D.Humanoid:LoadAnimation(A)
end

Anims.Idle:Play()

if not DDD then Players.LocalPlayer.CharacterAdded:Connect(function(NC)
 Char = NC
 NC:WaitForChild("HumanoidRootPart", 10)
 NC.Humanoid.WalkSpeed = 0
 NC.Humanoid.JumpPower = 0
 workspace.CurrentCamera.CameraSubject = D
end) end

if ClearH then for _, v in D:QueryDescendants("BasePart") do
 v.Color = Color3.fromRGB(163, 162, 165)
 if not (v.Name == "Head" or v.Name == "Torso" or v.Name == "Left Arm" or v.Name == "Right Arm" or v.Name == "Left Leg" or v.Name == "Right Leg" or v.Name == "HumanoidRootPart") then v:Destroy() end
end

for _, v in D:QueryDescendants("Shirt", "Pants") do v:Destroy() end end

for _, v in D:QueryDescendants("BasePart") do v.Transparency = DTransparency end
if DTransparency == 0 then D.HumanoidRootPart.Transparency = 1 end

game:GetService("RunService").RenderStepped:Connect(function()
 if not D.Parent or not D:FindFirstChild("HumanoidRootPart") then return end

 if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter then
  D.HumanoidRootPart.CFrame = CFrame.new(D.HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(-workspace.CurrentCamera.CFrame.LookVector.X, -workspace.CurrentCamera.CFrame.LookVector.Z), 0)
 end

 for _, v in D:QueryDescendants("BasePart") do v.CanCollide = false end

 if AntiV and D.HumanoidRootPart.Position.Y < workspace.FallenPartsDestroyHeight + 50 then
  D.HumanoidRootPart.CFrame = Spawn
  D.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
  D.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
 end

 D.Humanoid.Jump = Char.Humanoid.Jump
 D.Humanoid:Move(Char.Humanoid.MoveDirection)

 local NState = D.Humanoid:GetState() == Enum.HumanoidStateType.Jumping and "Jump" or D.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and "Fall" or D.Humanoid:GetState() == Enum.HumanoidStateType.Running and (D.Humanoid.MoveDirection.Magnitude > 0 and "Walk" or "Idle") or "Idle"
 if State ~= NState then if Anims[State] then Anims[State]:Stop(.2) end Anims[NState]:Play() State = NState end

 if DDD and Char.Humanoid.Health == 0 then D:Destroy() end
end)
