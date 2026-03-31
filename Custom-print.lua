cprint = function(Text, R, G, B)
game.StarterGui:SetCore("DevConsoleVisible", true) -- removable.
local Id, Color = tostring(os.clock()), Color3.fromRGB(R or 255, G or 0, B or 0)
print(Text .. " -- " .. Id)

task.spawn(function() while task.wait() do pcall(function()
 for _, F in game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren() do
  local M = F:FindFirstChild("msg") if not M then continue end
  if M.Text:find(Id, 1, true) then F.Name = Id end
  if F.Name == Id then M.Text = Text M.TextColor3 = Color end
 end
end) end end)
end

cprint("error", 255, 50, 50)
