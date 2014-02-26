
local StaticObject = require("app.gameObject.StaticObject")

local ObjectFactory = {}

function ObjectFactory.newObject(classId, id, state, map)
    local object

    if classId == "static" then
        object = StaticObject.new(id, state, map)
        object:init()
    elseif classId == "role" then
        object = StaticObject.new(id, state, map)
        object:init()
    else
        assert(false, format("ObjectFactory:newObject() - invalid classId %s", tostring(classId)))
    end

    return object
end

return ObjectFactory
