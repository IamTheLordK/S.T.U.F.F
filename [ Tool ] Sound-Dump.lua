local Ids = ""
for K, V in game:GetService("SoundService"):GetSoundMemoryData() do
if not K:find("rbxasset://sounds/") then Ids ..= K.."\n" end
end
setclipboard(Ids)
