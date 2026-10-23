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
 if Type ~= "table" then return Type:find("^%u") and not Type:find("^Enum") and Type..".new("..tostring(Value):gsub("[{}]", "")..")" or tostring(Value) end
 Seen = Seen or {}
 if Seen[Value] then return "{...}" end
 Seen[Value] = true
 local Result = {}
 for k, v in next, Value do table.insert(Result, "["..tabletostring(k, Seen).."] = "..tabletostring(v, Seen)) end
 Seen[Value] = nil
 return "{"..table.concat(Result, ", ").."}"
end
