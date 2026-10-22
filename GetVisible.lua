local Target = workspace.LordTerry --change.

print(#workspace.CurrentCamera:GetPartsObscuringTarget({Target.Head.Position}, {game:GetService("Players").LocalPlayer.Character, Target}) == 0 and "Visible" or "Obscured") --change, obviously.
