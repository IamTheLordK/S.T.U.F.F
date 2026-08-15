local Dump = ""

local function Path(Obj)
 return Obj:GetFullName():gsub("^([^.]+)",'game:GetService("%1")'):gsub("%.([^.]+)",'["%1"]')
end

local function Serialize(Value, Depth, Seen)
 if Depth > 4 then return "..." end
 local Type = typeof(Value)
 if Type == "string" then return '"'..Value:gsub('"','\\"'):gsub('\n','\\n')..'"'
 elseif Type == "boolean" or Type == "number" then return tostring(Value)
 elseif Type == "function" then return "function"
 elseif Type == "CFrame" then return ("CFrame.new(%g,%g,%g)"):format(Value.X,Value.Y,Value.Z)
 elseif Type == "Vector3" then return ("Vector3.new(%g,%g,%g)"):format(Value.X,Value.Y,Value.Z)
 elseif Type == "Color3" then return ("Color3.fromRGB(%d,%d,%d)"):format(Value.R*255,Value.G*255,Value.B*255)
 elseif Type == "UDim2" then return ("UDim2.new(%g,%g,%g,%g)"):format(Value.X.Scale,Value.X.Offset,Value.Y.Scale,Value.Y.Offset)
 elseif Type == "UDim" then return ("UDim.new(%g,%g)"):format(Value.Scale,Value.Offset)
 elseif Type == "EnumItem" then return tostring(Value)
 elseif Type == "Instance" then return Value:GetFullName()
 elseif Type == "DateTime" then return ("DateTime.fromUnixTimestamp(%d)"):format(Value.UnixTimestamp)
 elseif Type ~= "table" then return tostring(Value) end
 if not next(Value) then return "{}" end
 if Seen[Value] then return "{...}" end
 Seen[Value] = true
 local Result = {}
 for K, W in Value do
  Result[#Result+1] = tostring(K).." = "..Serialize(W,Depth+1,Seen)
 end
 Seen[Value] = nil
 return "{"..table.concat(Result,", ").."}"
end

for _, M in game:GetService("ReplicatedStorage"):QueryDescendants("ModuleScript") do
 local Coroutine = coroutine.create(require)
 local Ok, Export = coroutine.resume(Coroutine, M)
 if coroutine.status(Coroutine) ~= "dead" then
  task.delay(1, task.cancel, Coroutine)
  continue
 end
 if not Ok or type(Export) ~= "table" then continue end
 local Body = ""
 for K, V in Export do
  if tostring(K):sub(1,2) ~= "__" then Body ..= tostring(K)..(type(V) == "function" and "()\n" or " = "..Serialize(V,0,{}).."\n") end
 end
 if Body == "" then continue end
 Dump ..= "-- // "..M:GetFullName().."\nsetclipboard(decompile("..Path(M).."))\n"..("-"):rep(100).."\n"..Body.."\n"
end

for _, S in game:QueryDescendants("Script") do
 Dump ..= "-- // "..S:GetFullName().."\nsetclipboard(decompile("..Path(S).."))\n\n"
end

Dump ..= "-- // Remotes\n"..("-"):rep(100).."\n"
for _, R in game:QueryDescendants("RemoteEvent") do
 Dump ..= Path(R)..":FireServer()\n"
end
for _, R in game:QueryDescendants("UnreliableRemoteEvent") do
 Dump ..= Path(R)..":FireServer() -- unreliable\n"
end
for _, R in game:QueryDescendants("RemoteFunction") do
 Dump ..= Path(R)..":InvokeServer()\n"
end

setclipboard(Dump)
warn("Success")
