local Char = game.Players.LocalPlayer.Character

for _, v in next, Char.Humanoid:GetPlayingAnimationTracks() do
 if v.Name == "ToolNoneAnim" then v:Stop() end
end

Char.Animate.toolnone.ToolNoneAnim.AnimationId = ""
