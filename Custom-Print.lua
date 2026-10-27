cprint = function(Text, R, G, B)
 game.StarterGui:SetCore("DevConsoleVisible", true) -- removable.
 print(string.format("@cp|%02X%02X%02X|%s", R or 255, G or 0, B or 0, Text))
end

game.CoreGui.DescendantAdded:Connect(function(v)
 if v.Name ~= "msg" or not v:FindFirstAncestor("ClientLog") then return end
 local Hex, Text = v.Text:match("@cp|(%x+)|(.*)") if not Text then return end
 v.Text = Text
 v.TextColor3 = Color3.fromHex(Hex)
end)

cprint("ERROR", 255, 50, 50)
