local function Clean(v)
 if not v:IsA("BasePart") then return end
 if game:GetService("Players"):GetPlayerFromCharacter(v:FindFirstAncestorOfClass("Model")) then return end
 v.Material = Enum.Material.Plastic
 v.CastShadow = false
 v.Reflectance = 0
 for _, k in Enum.NormalId:GetEnumItems() do v[k.Name.."Surface"] = Enum.SurfaceType.Smooth end
end

for _, v in workspace:QueryDescendants("BasePart:not(Terrain)") do Clean(v) end
workspace.DescendantAdded:Connect(Clean)

for _, v in game:GetService("Lighting"):QueryDescendants("PostEffect") do v.Enabled = false end
game:GetService("Lighting").GlobalShadows = false
