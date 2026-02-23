local function GetPlayer(Name)
 Name = Name:lower()
 for _, v in pairs(game.Players:GetPlayers()) do
  if v ~= game.Players.LocalPlayer and (v.Name:lower():match(Name) or v.DisplayName:lower():match(Name)) then return v end
 end
end

print(GetPlayer("m"))
