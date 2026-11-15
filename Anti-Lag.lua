local function Clean(v)
 if v:IsA("BasePart") then
  if game:GetService("Players"):GetPlayerFromCharacter(v:FindFirstAncestorOfClass("Model")) then return end
  v.Material = Enum.Material.Plastic
  v.CastShadow = false
  v.Reflectance = 0
  for _, k in Enum.NormalId:GetEnumItems() do v[k.Name.."Surface"] = Enum.SurfaceType.Smooth end
 elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false
 end
end

for _, v in workspace:QueryDescendants("BasePart:not(Terrain), ParticleEmitter, Trail, Beam, Fire, Smoke, Sparkles") do Clean(v) end
workspace.DescendantAdded:Connect(Clean)

for _, v in game:GetService("Lighting"):QueryDescendants("PostEffect") do v.Enabled = false end
game:GetService("Lighting").GlobalShadows = false
