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
--		if currentV > 360 then 
--			currentV = currentV - 360;
--		elseif currentV < -360 then
--			currentV = currentV + 360;
--		end
		
		if currentV < 0 then 
			currentV = 360 + currentV;
		elseif currentV > 360 then 
			currentV = currentV  - 360;
		end
		
		
		object.flyDegrees_ = currentV;
    end
    object:bindMethod(self, "decreasePlaneFlyDegrees", decreasePlaneFlyDegrees)
    
    
	
	--[[
	设置发行的角度
	正右为0度   顺时针旋转 度数增加
	]]
    local function getPlaneFlyDegrees(object)
    	return object.flyDegrees_;
    end
    object:bindMethod(self, "getPlaneFlyDegrees", getPlaneFlyDegrees)
    
    
    
    
    local function updateView(object)		
        local sprite = object.sprite_;
        sprite:setRotation(tonum(object.flyRadians_));
    end
    object:bindMethod(self, "updateView", updateView)
    
    
	
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
