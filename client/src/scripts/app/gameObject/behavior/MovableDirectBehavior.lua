--[[
移动方向管理
]]
local MovableDirectBehavior = class("MovableDirectBehavior", BehaviorBase)


function MovableDirectBehavior:ctor()
    MovableDirectBehavior.super.ctor(self, "MovableDirectBehavior", nil, 1)
end

function MovableDirectBehavior:bind(object)

	
	--[[
	设置发行的角度
	正右为0度   顺时针旋转 度数增加
	]]
    local function setPlaneFlyRadians(object,flyRadians)
    	object.flyRadians_ = flyRadians;
    end
    object:bindMethod(self, "setPlaneFlyRadians", setPlaneFlyRadians)



	
    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
end

function MovableDirectBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
    object:unbindMethod(self, "setPlaneFlyRadians")
end

function MovableDirectBehavior:reset(object)
end

return MovableDirectBehavior
