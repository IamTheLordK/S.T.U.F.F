_G.F, _G.A = {}, {}

local function Filter(P)
 if not P:IsDescendantOf(workspace) or P:IsA("Terrain") or not P.AssemblyRootPart or game:GetService("Players"):GetPlayerFromCharacter(P:FindFirstAncestorOfClass("Model")) then return end
 if P.AssemblyRootPart.Anchored or P.AssemblyRootPart:IsGrounded() then _G.A[P] = true else _G.F[P] = true end
end

for _, v in pairs(workspace:QueryDescendants("BasePart")) do Filter(v) end

workspace.DescendantAdded:Connect(function(v) if v:IsA("BasePart") then if game.PlaceId == 189707 or game.PlaceId == 7057417395 then task.wait(1) end Filter(v) end end)
workspace.DescendantRemoving:Connect(function(v) _G.F[v], _G.A[v] = nil, nil end)

game.RunService.PostSimulation:Connect(function()
 for v in pairs(_G.A) do if not v.AssemblyRootPart.Anchored and not v.AssemblyRootPart:IsGrounded() then _G.A[v] = nil Filter(v) end end
end)
