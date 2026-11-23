--// table to string
local function Path(v)
 local Suffix = "" while v and v.Parent ~= game do Suffix = (v.Name:find("^[%a_][%w_]*$") and "."..v.Name or ("[%q]"):format(v.Name))..Suffix v = v.Parent end
 return v and ("game:GetService(%q)"):format(v.Name)..Suffix
end

local function tabletostring(Value, Ancestors)
 if type(Value) == "string" then return ("%q"):format(Value) end
 if type(Value) == "function" then return "function" end
 if typeof(Value) == "Instance" then return Path(Value) or tostring(Value) end
 if type(Value) ~= "table" then return typeof(Value):find("^[A-DF-Z]") and typeof(Value)..".new("..(typeof(Value) == "BrickColor" and ("%q"):format(tostring(Value)) or tostring(Value):gsub("[{}]", ""))..")" or tostring(Value) end
 Ancestors = Ancestors or {} if Ancestors[Value] then return "{...}" end Ancestors[Value] = true
 local Entries = {}
 for k, v in next, Value do table.insert(Entries, "["..tabletostring(k, Ancestors).."] = "..tabletostring(v, Ancestors)) end Ancestors[Value] = nil
 return "{"..table.concat(Entries, ", ").."}"
end
