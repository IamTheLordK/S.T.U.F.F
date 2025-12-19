_G.F, _G.U, _G.A = {}, {}, {}

local function Filter(P)
 if not P.AssemblyRootPart or game.Players:GetPlayerFromCharacter(P.Parent) or game.Players:GetPlayerFromCharacter(P.Parent.Parent) then return end
 if P.AssemblyRootPart.Anchored then _G.A[P] = true elseif P.ReceiveAge == 0 then _G.F[P] = true else _G.U[P] = true end
end

for _, v in pairs(workspace:QueryDescendants("BasePart")) do Filter(v) end

workspace.DescendantAdded:Connect(function(v) if v:IsA("BasePart") then if game.PlaceId == 189707 or game.PlaceId == 7057417395 then wait(1) end Filter(v) end end)
workspace.DescendantRemoving:Connect(function(v) _G.F[v], _G.U[v], _G.A[v] = nil, nil, nil end)

game:GetService("RunService").PostSimulation:Connect(function()
 for v in pairs(_G.F) do if v.ReceiveAge ~= 0 then _G.F[v], _G.U[v] = nil, true end end
 for v in pairs(_G.U) do if v.ReceiveAge == 0 then _G.U[v], _G.F[v] = nil, true end end
 for v in pairs(_G.A) do if not v.AssemblyRootPart.Anchored then _G.A[v] = nil Filter(v) end end
end)
