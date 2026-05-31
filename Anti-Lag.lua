local function Clean(P)
 if P == workspace.Terrain then return end
 if game.Players:GetPlayerFromCharacter(P:FindFirstAncestorOfClass("Model")) then return end
 if not P:IsA("BasePart") then return end

 P.Material = Enum.Material.Plastic
 P.CastShadow = false
 P.Reflectance = 0
 P.TopSurface = Enum.SurfaceType.Smooth
 P.BottomSurface = Enum.SurfaceType.Smooth
 P.FrontSurface = Enum.SurfaceType.Smooth
 P.BackSurface = Enum.SurfaceType.Smooth
 P.LeftSurface = Enum.SurfaceType.Smooth
 P.RightSurface = Enum.SurfaceType.Smooth
end

for _, v in pairs(workspace:QueryDescendants("BasePart")) do Clean(v) end
workspace.DescendantAdded:Connect(Clean)

game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").Technology = Enum.Technology.Compatibility
