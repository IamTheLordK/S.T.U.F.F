local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://252557606"

local Track = Humanoid.Animator:LoadAnimation(Anim)

Humanoid.Running:Connect(function(v)
 if v > 0 then if not Track.IsPlaying then Track:Play() end else Track:Stop() end
end)
