--[[
相关计算
]]
local DistanceCalculateBehavior = class("DistanceCalculateBehavior", BehaviorBase)


function DistanceCalculateBehavior:ctor()
    DistanceCalculateBehavior.super.ctor(self, "DistanceCalculateBehavior", nil, 1)
end



function DistanceCalculateBehavior:bind(object)

	
	--[[
	当前点(x,y)是否在当前的对象内
	]]
    local function checkPointIn(object, x, y)
    	return SearchAlgorithm:checkPointInTarget(object, x, y)
    end
    object:bindMethod(self, "checkPointIn", checkPointIn)
	
    
    
	
    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
end

function DistanceCalculateBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
end

function DistanceCalculateBehavior:reset(object)
end

return DistanceCalculateBehavior
