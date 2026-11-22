local Keyword = ("Coin, Shoot"):lower() -- Keywords, comma-separated (one or more)

local Hint = Instance.new("Hint", workspace)
local Dump, Left = {}, 0

for _, v in game:QueryDescendants(":not(:not(ModuleScript, Script, BaseRemoteEvent, RemoteFunction, BindableEvent, BindableFunction, ValueBase, Workspace >> PVInstance), Chat >> Instance, CoreGui >> Instance, CorePackages >> Instance, RobloxReplicatedStorage >> Instance, ReplicatedStorage > #DefaultChatSystemChatEvents >> Instance)") do if table.find({"BubbleChat", "ChatScript", "PlayerModule", "PlayerScriptsLoader", "RbxCharacterSounds"}, v:GetFullName():match("PlayerScripts%.([^.]+)")) then continue end
 Left += 1
 task.spawn(function()
  local Lines = ""
  for n, L in (v.ClassName ~= "Script" and v:IsA("LuaSourceContainer") and select(2, pcall(decompile, v)) or v.Name):split("\n") do
   for K in Keyword:gmatch("[^,%s][^,]*") do
    if L:lower():find(K, 1, true) then
     Lines ..= "\n-- "..n.."  "..L:gsub("^%s+", "")
     break
    end
   end
  end
  Left -= 1
  Hint.Text = "Grepping... "..Left.." objects remaining"
  if Lines == "" then return end
  local Tail, Ancestor = "", v
  repeat
   Tail = (Ancestor.Parent == game and "game:GetService(%q)" or "[%q]"):format(Ancestor.Name)..Tail
   Ancestor = Ancestor.Parent
  until Ancestor == game
  local Key = v.ClassName.."\n"..v:GetFullName():gsub("^Players%.[^.]+%.", ""):gsub("^StarterPlayer%.Starter", ""):gsub("^StarterGui", "PlayerGui"):gsub("^StarterPack", "Backpack")..Lines
  Dump[Key] = Dump[Key] or {Count = 0, Head = "-- // "..v:GetFullName(), Body = "\n"..(v.ClassName ~= "Script" and v:IsA("LuaSourceContainer") and "setclipboard(decompile("..Tail.."))" or Tail)..Lines}
  Dump[Key].Count += 1
 end)
end

while Left > 0 do task.wait() end

for K in Keyword:gmatch("[^,%s][^,]*") do
 for _, v in game:GetService("CollectionService"):GetAllTags() do
  if v:lower():find(K, 1, true) then Dump["Tag\n"..v] = {Count = #game:GetService("CollectionService"):GetTagged(v), Head = "-- // "..v, Body = ('\ngame:GetService("CollectionService"):GetTagged(%q)'):format(v)} end
 end
end

local Result, Last = {}, ""
for Key in Dump do table.insert(Result, Key) end
table.sort(Result)
for i, v in Result do
 local Entry, Class = Dump[v], v:match("^[^\n]+")
 Result[i] = (Class == Last and "" or "\n-- // "..Class.."\n\n")..Entry.Head..(Entry.Count > 1 and " x"..Entry.Count or "")..Entry.Body
 Last = Class
end
if #Result > 0 then setclipboard('-- // All matches for "'..Keyword..'" in '..game:GetService("MarketplaceService"):GetProductInfoAsync(game.PlaceId).Name.."\n"..table.concat(Result, "\n\n")) end
Hint.Text = #Result..' results for "'..Keyword..'"'
game:GetService("Debris"):AddItem(Hint)
