--[[
角度管理
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
    local function setPlaneFlyDegrees(object,flyDegrees)
    	object.flyDegrees_ = flyDegrees;
    end
    object:bindMethod(self, "setPlaneFlyDegrees", setPlaneFlyDegrees)

	
	
	--[[
	增加减少度数
	]]
	local function decreasePlaneFlyDegrees(object,value)
		local aad = 1;
		local currentV = object.flyDegrees_ + aad * value;
		
		if currentV < 1 then 
			currentV = 32 + currentV;
		elseif currentV > 32 then 
			currentV = currentV  - 32;
		end
		
		
		object.flyDegrees_ = currentV;
    end
    object:bindMethod(self, "decreasePlaneFlyDegrees", decreasePlaneFlyDegrees)
    
    
	
	--[[
	设置发行的角度
	正右为0度   顺时针旋转 度数增加
	]]
    local function getPlaneFlyDegrees(object)
    	return checkint(object.flyDegrees_);
    end
    object:bindMethod(self, "getPlaneFlyDegrees", getPlaneFlyDegrees)
    
	
	
	
    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
end

function MovableDirectBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
    object:unbindMethod(self, "getPlaneFlyDegrees")
end

function MovableDirectBehavior:reset(object)
end

return MovableDirectBehavior
