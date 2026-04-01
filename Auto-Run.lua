--queue_on_teleport: schedules a lua string to auto-run after teleport / rejoin

if queue_on_teleport then

 --option 1: remote script (fetches and runs from url)
 queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/IamTheLordK/S.T.U.F.F/refs/heads/main/Vehicle%20Boost.lua'))()")

 --option 2: inline code
 --queue_on_teleport("game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50")

 --option 3: multiline inline via [[ ]] (cleaner for bigger code
 --queue_on_teleport([[
 --print("rejoined!")
 --game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
 --]])

end
