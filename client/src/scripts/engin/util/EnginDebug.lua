--[[
 	EnginDebug.lua
 	public ->> 全局公开类
 	
	 积累引擎调试的一些基础库
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]




local print = print
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next


--[[
可以树形打印table 方便调试
比如：
	a = {}
	a.a = { 
		hello = { 
			alpha = 1 ,
			beta = 2,
		},
		world =  {
			foo = "ooxx",
			bar = "haha",
			root = a,
		},
	}
	a.b = { 
		test = a.a 
	}
	a.c = a.a.hello
	 
	print_r(a)
	打印结果：
		+a+hello+alpha [1]
		| |     +beta [2]
		| +world+root {.}
		|       +bar [haha]
		|       +foo [ooxx]
		+c {.a.hello}
		+b+test {.a}
]]
function print_r(root)
	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"+" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				tinsert(temp,"+" .. key .. " [" .. tostring(v).."]")
			end
		end
		return tconcat(temp,"\n"..space)
	end
	print(_dump(root, "",""))
end





--[[
输出table的json解析库
@param ...
]]
function echoj(...)
    local argc = select("#", ...)
    local argv = {...}
    local arr = {}
    for i = 1, argc do
        if type(argv[i]) == "table" then
            local status, str = pcall(json.encode, argv[i])
            if not status or str == nil then
                str = tostring(argv[i])
            end
            arr[#arr + 1] = str
        else
            arr[#arr + 1] = getObjectVal(argv[i])
        end
    end
    print(table.concat(arr, ", "))
end









----------------------------------内置方法----------------------------------------------------------

--[[
获取对象的值
@param userdata obj
@return string
]]
function getObjectVal(obj)
    if type(obj) == "table" then
        local status, jsonStr = pcall(json.encode, obj)
        if status and jsonStr ~= nil then
            return jsonStr
        elseif jsonStr == nil then
            local arr = {}
            for k, v in pairs(obj) do
                if type(v) ~= "boolean" and type(v) ~= "number" and type(v) ~= "string" then
                    arr[k] = tostring(v)
                else
                    arr[k] = v
                end
            end
            return json.encode(arr)
        else
            return tostring(obj)
        end
    end
    if tolua == nil then
        return tostring(obj)
    end
    local type_ = tolua.type(obj)
    local arr
    if type_ == "CCPoint" then
        arr = {x = obj.x, y = obj.y}
    elseif type_ == "CCSize" then
        arr = {width = obj.width, height = obj.height}
    elseif type_ == "CCRect" then
        arr = {
            origin = {x = obj.origin.x, y = obj.origin.y},
            size = {width = obj.size.width, height = obj.size.height},
        }
    elseif type_ == "ccColor3B" then
        arr = {r = obj.r, g = obj.g, b = obj.b}
    elseif type_ == "ccColor4B" or type_ == "ccColor4F" then
        arr = {r = obj.r, g = obj.g, b = obj.b, a = obj.a}
    else
        return tostring(obj)
    end
    arr.type = type_
    return json.encode(arr)
end
--function print_r(sth)
-- if type(sth) ~= "table" then
-- print(sth)
-- return
-- end
--
--local space, deep = string.rep(' ', 4), 0
-- local function _dump(t)
-- local temp = {}
-- for k,v in pairs(t) do
-- local key = tostring(k)
--
--if type(v) == "table" then
-- deep = deep + 2
-- print(string.format("%s[%s] => Table\n%s(",
-- string.rep(space, deep - 1),
-- key,
-- string.rep(space, deep)
-- )
-- ) --print.
-- _dump(v)
--
--print(string.format("%s)",string.rep(space, deep)))
-- deep = deep - 2
-- else
-- print(string.format("%s[%s] => %s",
-- string.rep(space, deep + 1),
-- key,
-- v
-- )
-- ) --print.
-- end 
-- end 
-- end
--
--print(string.format("Table\n("))
-- _dump(sth)
-- print(string.format(")"))
--end

