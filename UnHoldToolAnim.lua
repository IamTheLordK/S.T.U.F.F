task.spawn(function()
 while task.wait() do
  local Char = game.Players.LocalPlayer.Character
  local Animate = Char and Char:FindFirstChild("Animate")
  Animate.toolnone.ToolNoneAnim.AnimationId = ""
 end
end)
