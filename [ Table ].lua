_G.F = {}

getgenv().Netless = false
getgenv().Debug = false

local function Filter(P)
 if not P:IsA("BasePart") or not P.AssemblyRootPart then return end
 if game.Players:GetPlayerFromCharacter(P.Parent) or game.Players:GetPlayerFromCharacter(P.Parent.Parent) then return end
 if P.AssemblyRootPart.Anchored then return end
 
 if P.ReceiveAge == 0 then _G.F[P] = true else spawn(function()
  repeat wait() until not P.Parent or P.ReceiveAge == 0
  if P.Parent and P.ReceiveAge == 0 then Filter(P) end
 end) end
end

for _, P in pairs(workspace:GetDescendants()) do Filter(P) end

spawn(function() while 1 > 0 do task.wait()
 for P in pairs(_G.F) do if P.ReceiveAge ~= 0 then _G.F[P] = nil end end
end end)

workspace.DescendantAdded:Connect(function(C) if C:IsA("BasePart") then if game.PlaceId == 189707 or game.PlaceId == 7057417395 then wait(1) end Filter(C) end end)

while 1 > 0 do task.wait()
 for P in pairs(_G.F) do
  if getgenv().Netless then P.Velocity = Vector3.one * 26.6565464 end
  if getgenv().Debug then P.Color = Color3.fromRGB(255, 0, 0) end
  P.RootPriority = 127
  P.Massless = true
 end
end
