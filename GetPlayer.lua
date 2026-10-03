local function GetPlayer(Name)
 Name = Name:lower()
 for _, v in game.Players:GetPlayers() do
  if v ~= game.Players.LocalPlayer and ((v.Name..v.DisplayName):lower():find(Name, 1, true)) then return v end
 end
end

print(GetPlayer("m"))
