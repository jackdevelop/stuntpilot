--[[
 	BaseObject
 	public ->> 全局公开类
 	
	对象的基础类 
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local BaseObject = class("BaseObject")



BaseObject.CLASS_INDEX = {
    static     = 0,
    role       = 1,
}

BaseObject.CLASS_ID = {
    static     = "static",
    role	   = "role",
}


function BaseObject:ctor(id, state, model)
    assert(type(state) == "table", "BaseObject:ctor() - invalid state")

    for k, v in pairs(state) do
        local kn = k .. "_"
        self[kn] = v
    end

	
	self.id_         = id
	self.model_        = model --当前的模型管理者
	
    local classId, index = unpack(string.split(id, ":"))
    self.classId_    = BaseObject.CLASS_ID[classId]
    self.classIndex_ = BaseObject.CLASS_INDEX[classId]
    self.index_      = checkint(index)
    
    
    self.x_          = checkint(self.x_)
    self.y_          = checkint(self.y_)
    self.offsetX_    = checkint(self.offsetX_)
    self.offsetY_    = checkint(self.offsetY_)
    
    --半径
    self.radius_  = checkint(self.radius_)
    
    
    self.state_      = state
    self.play_       = false
  	--self.tag_        = 0
    self.sprite_     = nil
    
    
    if type(self.viewZOrdered_) ~= "boolean" then --是否参与排序
        self.viewZOrdered_ = true
    end
end

function BaseObject:init()
    if not self.behaviors_ then return end

    local behaviors
    if type(self.behaviors_) == "string" then
        behaviors = string.split(self.behaviors_, ",")
    else
        behaviors = self.behaviors_
    end

    for i, behaviorName in ipairs(behaviors) do
        behaviorName = string.trim(behaviorName)
        if behaviorName ~= "" then self:bindBehavior(behaviorName) end
    end
end




function BaseObject:getId()
    return self.id_
end

function BaseObject:getClassId()
    return self.classId_
end

function BaseObject:getIndex()
    return self.index_
end






--tag
function BaseObject:getTag()
    return self.tag_
end
function BaseObject:setTag(tag)
    self.tag_ = tag
end


--坐标postion
function BaseObject:getPosition()
    return self.x_, self.y_
end
function BaseObject:setPosition(x, y)
--    self.x_, self.y_ = x, y
end



function BaseObject:isViewCreated()
    return self.sprite_ ~= nil
end
function BaseObject:isViewZOrdered()
    return self.viewZOrdered_
end





function BaseObject:getView()
    return self.sprite_ 
end
function BaseObject:createView(batch, floorsLayer,flysLayer, debugLayer)
    assert(self.batch_ == nil, "BaseObject:createView() - view already created")
    self.batch_      = batch
    self.floorsLayer_ = floorsLayer
     self.flysLayer_ = flysLayer
    self.debugLayer_ = debugLayer
end

function BaseObject:removeView()
    assert(self.batch_ ~= nil, "BaseObject:removeView() - view not exists")
    self.batch_      = nil
     self.floorsLayer_ = nil
     self.flysLayer_ = nil
    self.debugLayer_ = nil
end
function BaseObject:updateView()
end

function BaseObject:tick()
end





function BaseObject:preparePlay()
end

function BaseObject:startPlay()
    self.play_ = true
end

function BaseObject:stopPlay()
    self.play_ = false
end
function BaseObject:isPlay()
    return self.play_
end


































function BaseObject:hasBehavior(behaviorName)
    return self.behaviorObjects_ and self.behaviorObjects_[behaviorName] ~= nil
end

function BaseObject:bindBehavior(behaviorName)
    if not self.behaviorObjects_ then self.behaviorObjects_ = {} end
    if self.behaviorObjects_[behaviorName] then return end

    local behavior = BehaviorFactory.createBehavior(behaviorName)
    for i, dependBehaviorName in pairs(behavior:getDepends()) do
        self:bindBehavior(dependBehaviorName)

        if not self.behaviorDepends_ then
            self.behaviorDepends_ = {}
        end
        if not self.behaviorDepends_[dependBehaviorName] then
            self.behaviorDepends_[dependBehaviorName] = {}
        end
        table.insert(self.behaviorDepends_[dependBehaviorName], behaviorName)
    end

    behavior:bind(self)
    self.behaviorObjects_[behaviorName] = behavior
    self:resetAllBehaviors()
end

function BaseObject:unbindBehavior(behaviorName)
    assert(self.behaviorObjects_ and self.behaviorObjects_[behaviorName] ~= nil,
           format("ObjectBase:unbindBehavior() - behavior %s not binding", behaviorName))
    assert(not self.behaviorDepends_ or not self.behaviorDepends_[behaviorName],
           format("ObjectBase:unbindBehavior() - behavior %s depends by other binding", behaviorName))

    local behavior = self.behaviorObjects_[behaviorName]
    for i, dependBehaviorName in pairs(behavior:getDepends()) do
        for j, name in ipairs(self.behaviorDepends_[dependBehaviorName]) do
            if name == behaviorName then
                table.remove(self.behaviorDepends_[dependBehaviorName], j)
                if #self.behaviorDepends_[dependBehaviorName] < 1 then
                    self.behaviorDepends_[dependBehaviorName] = nil
                end
                break
            end
        end
    end

    behavior:unbind(self)
    self.behaviorObjects_[behaviorName] = nil
end

function BaseObject:resetAllBehaviors()
    if not self.behaviorObjects_ then return end

    local behaviors = {}
    for i, behavior in pairs(self.behaviorObjects_) do
        behaviors[#behaviors + 1] = behavior
    end
    table.sort(behaviors, function(a, b)
        return a:getPriority() > b:getPriority()
    end)
    for i, behavior in ipairs(behaviors) do
        behavior:reset(self)
    end
end

function BaseObject:bindMethod(behavior, methodName, method, callOriginMethodLast)
    local originMethod = self[methodName]
    if not originMethod then
        self[methodName] = method
        return
    end

    if not self.bindingMethods_ then self.bindingMethods_ = {} end
    if not self.bindingMethods_[methodName] then self.bindingMethods_[methodName] = {} end

    local chain = {behavior, originMethod}
    local newMethod
    if callOriginMethodLast then
        newMethod = function(...)
            method(...)
            chain[2](...)
        end
    else
        newMethod = function(...)
            local ret = chain[2](...)
            if ret then
                local args = {...}
                args[#args + 1] = ret
                return method(unpack(args))
            else
                return method(...)
            end
        end
    end

    self[methodName] = newMethod
    chain[3] = newMethod
    table.insert(self.bindingMethods_[methodName], chain)

    -- print(format("[%s]:bindMethod(%s, %s)", tostring(self), behavior:getName(), methodName))
    -- for i, chain in ipairs(self.bindingMethods_[methodName]) do
    --     print(format("  index: %d, origin: %s, new: %s", i, tostring(chain[2]), tostring(chain[3])))
    -- end
    -- print(format("  current: %s", tostring(self[methodName])))
end

function BaseObject:unbindMethod(behavior, methodName)
    if not self.bindingMethods_ or not self.bindingMethods_[methodName] then
        self[methodName] = nil
        return
    end

    local methods = self.bindingMethods_[methodName]
    local count = #methods
    for i = count, 1, -1 do
        local chain = methods[i]

        if chain[1] == behavior then
            -- print(format("[%s]:unbindMethod(%s, %s)", tostring(self), behavior:getName(), methodName))
            if i < count then
                -- 如果移除了中间的节点，则将后一个节点的 origin 指向前一个节点的 origin
                -- 并且对象的方法引用的函数不变
                -- print(format("  remove method from index %d", i))
                methods[i + 1][2] = chain[2]
            elseif count > 1 then
                -- 如果移除尾部的节点，则对象的方法引用的函数指向前一个节点的 new
                self[methodName] = methods[i - 1][3]
            elseif count == 1 then
                -- 如果移除了最后一个节点，则将对象的方法指向节点的 origin
                self[methodName] = chain[2]
                self.bindingMethods_[methodName] = nil
            end

            -- 移除节点
            table.remove(methods, i)

            -- if self.bindingMethods_[methodName] then
            --     for i, chain in ipairs(self.bindingMethods_[methodName]) do
            --         print(format("  index: %d, origin: %s, new: %s", i, tostring(chain[2]), tostring(chain[3])))
            --     end
            -- end
            -- print(format("  current: %s", tostring(self[methodName])))

            break
        end
    end
end

function BaseObject:vardump()
    local state = {
        x   = self.x_,
        y   = self.y_,
        tag = self.tag_,
    }

    if self.behaviorObjects_ then
        local behaviors = table.keys(self.behaviorObjects_)
        for i = #behaviors, 1, -1 do
            if not BehaviorFactory.isStaticObjectBehavior(behaviors[i]) then
                table.remove(behaviors, i)
            end
        end
        if #behaviors > 0 then
            table.sort(behaviors)
            state.behaviors = behaviors
        end
    end

    return state
end

return BaseObject
