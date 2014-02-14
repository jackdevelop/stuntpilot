--[[
 	BaseObject
 	public ->> 全局公开类
 	
	对象的基础类 
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local BaseObject = class("BaseObject")


function BaseObject:ctor(id, state, model)
    assert(type(state) == "table", "BaseObject:ctor() - invalid state")

    for k, v in pairs(state) do
        local kn = k .. "_"
        self[kn] = v
    end

	
	self.id_         = id
	self.model_        = model --当前的模型管理者
	
    local classId, index = unpack(string.split(id, ":"))
    self.classId_    = classId
    self.classIndex_ = BaseObject.CLASS_INDEX[classId]
    self.index_      = toint(index)
    
    
    self.x_          = toint(self.x_)
    self.y_          = toint(self.y_)
    self.offsetX_    = toint(self.offsetX_)
    self.offsetY_    = toint(self.offsetY_)
    
    
    self.state_      = state
    self.play_       = false
  	--self.tag_        = 0
    self.sprite_     = nil
    
    
    if type(self.viewZOrdered_) ~= "boolean" then --是否参与排序
        self.viewZOrdered_ = true
    end
end

--function BaseObject:init()
--    if not self.behaviors_ then return end
--
--    local behaviors
--    if type(self.behaviors_) == "string" then
--        behaviors = string.split(self.behaviors_, ",")
--    else
--        behaviors = self.behaviors_
--    end
--
--    for i, behaviorName in ipairs(behaviors) do
--        behaviorName = string.trim(behaviorName)
--        if behaviorName ~= "" then self:bindBehavior(behaviorName) end
--    end
--end

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
    self.x_, self.y_ = x, y
end



function BaseObject:isViewCreated()
    return self.sprite_ ~= nil
end
function BaseObject:isViewZOrdered()
    return self.viewZOrdered_
end





function BaseObject:getView()
    return nil
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




return BaseObject
