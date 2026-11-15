local function FindPlayer(Name)
 Name = Name:lower()
 for _, v in game:GetService("Players"):GetPlayers() do
  if v ~= game:GetService("Players").LocalPlayer and (v.Name.." "..v.DisplayName):lower():find(Name, 1, true) then return v end
 end
end

print(FindPlayer("m"))
