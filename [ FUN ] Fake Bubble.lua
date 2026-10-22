for _, v in game:GetService("Players"):GetPlayers() do
 local Char = v.Character if not Char then continue end
 game:GetService("TextChatService"):DisplayBubble(Char, "I love "..game:GetService("Players").LocalPlayer.DisplayName)
end
