
local StaticObjectsProperties = require("app.gameObject.StaticObjectsProperties")

local StaticObject = class("StaticObject", BaseObject)



function StaticObject:ctor(id, state, model)
    assert(state.defineId ~= nil, "StaticObject:ctor() - invalid state.defineId")
    local define = StaticObjectsProperties.get(state.defineId)
    for k, v in pairs(define) do
        if state[k] == nil then
            state[k] = v
        end
    end
    StaticObject.super.ctor(self, id, state, model)
end







function StaticObject:vardump()
    local state = StaticObject.super.vardump(self)
    return state
end

return StaticObject
