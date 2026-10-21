--// table to string
local function Path(v)
 local Tail = ""
 while v and v.Parent ~= game do
  Tail = string.format("[%q]", v.Name)..Tail
  v = v.Parent
 end
 return v and string.format("game:GetService(%q)", v.Name)..Tail
end

local function tabletostring(Value, Seen)
 local Type = typeof(Value)
 if Type == "string" then return string.format("%q", Value) end
 if Type == "function" then return "function" end
 if Type == "Instance" then return Path(Value) or tostring(Value) end
 if Type == "BrickColor" then return "BrickColor.new("..string.format("%q", tostring(Value))..")" end
 if Type ~= "table" then return Type:find("^%u") and Type ~= "EnumItem" and Type..".new("..tostring(Value):gsub("[{}]", "")..")" or tostring(Value) end
 Seen = Seen or {}
 if Seen[Value] then return "{...}" end
 Seen[Value] = true
 local Result = {}
 for k, v in next, Value do table.insert(Result, "["..tabletostring(k, Seen).."] = "..tabletostring(v, Seen)) end
 Seen[Value] = nil
 return "{"..table.concat(Result, ", ").."}"
end



--// scan
local Dump = ""

for _, v in game:GetService("ReplicatedStorage"):QueryDescendants("ModuleScript") do
 local Thread = coroutine.create(require)
 local Ok, Export = coroutine.resume(Thread, v)
 if coroutine.status(Thread) ~= "dead" then
  task.delay(1, task.cancel, Thread)
  continue
 end
 if not Ok or type(Export) ~= "table" then continue end
 local Body = ""
 for k, v in Export do
  if tostring(k):sub(1, 2) ~= "__" then Body ..= tostring(k)..(type(v) == "function" and "()\n" or " = "..tabletostring(v).."\n") end
 end
 if Body == "" then continue end
 Dump ..= "-- // "..v:GetFullName().."\nsetclipboard(decompile("..Path(v).."))\n"..("-"):rep(100).."\n"..Body.."\n"
end

Dump ..= "-- // Scripts\n"..("-"):rep(100).."\n"
for _, v in game:QueryDescendants("Script") do Dump ..= (v.ClassName == "Script" and v.RunContext ~= Enum.RunContext.Client and "%s\n" or "setclipboard(decompile(%s))\n"):format(Path(v)) end

Dump ..= "\n-- // Remotes\n"..("-"):rep(100).."\n"
for _, v in game:QueryDescendants("RemoteEvent") do Dump ..= Path(v)..":FireServer()\n" end
for _, v in game:QueryDescendants("UnreliableRemoteEvent") do Dump ..= Path(v)..":FireServer() -- unreliable\n" end
for _, v in game:QueryDescendants("RemoteFunction") do Dump ..= Path(v)..":InvokeServer()\n" end

setclipboard(Dump)
warn("Success")
