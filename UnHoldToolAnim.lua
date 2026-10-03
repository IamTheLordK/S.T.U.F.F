while task.wait() do
 local Char = game.Players.LocalPlayer.Character if not Char then continue end
 local Animate = Char:FindFirstChild("Animate") if not Animate then continue end
 Animate.toolnone.ToolNoneAnim.AnimationId = ""
end
