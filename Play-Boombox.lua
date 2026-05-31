local ID = 142376088
local Boombox = game.Players.LocalPlayer.Backpack["[Boombox]"]

Boombox.Parent = game.Players.LocalPlayer.Character
Boombox:FindFirstChildWhichIsA("RemoteEvent"):FireServer("PlaySong", ID)
Boombox.DescendantAdded:Wait() wait()

Boombox.Parent = game.Players.LocalPlayer.Backpack
local Sound = Boombox:FindFirstChildWhichIsA("Sound", true)
repeat task.wait() until not Sound.IsPlaying
Sound:Play()
