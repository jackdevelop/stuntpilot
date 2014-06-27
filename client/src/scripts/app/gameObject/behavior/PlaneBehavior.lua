
local PlaneBehavior = class("PlaneBehavior", BehaviorBase)

function PlaneBehavior:ctor()
    PlaneBehavior.super.ctor(self, "PlaneBehavior", nil, 1)
end




function PlaneBehavior:bind(object)
	

    
    
    
    
    local function updateView(object)	
    	local animation = object:getAnimation();
    	animation:setDisplayFrameIndex(checkint(object.flyDegrees_));
        --local sprite = object.sprite_;
        --sprite:setRotation(checknumber(object.flyDegrees_));
    end
    object:bindMethod(self, "updateView", updateView)
end

function PlaneBehavior:unbind(object)
end

function PlaneBehavior:reset(object)
end

return PlaneBehavior
