
local PlaneBehavior = class("PlaneBehavior", BehaviorBase)

function PlaneBehavior:ctor()
    PlaneBehavior.super.ctor(self, "PlaneBehavior", nil, 1)
end




function PlaneBehavior:bind(object)
	

    
    
    
    
    local function updateView(object)	
    	local animation = object:getAnimation();
    	animation:setDisplayFrameIndex(toint(object.flyDegrees_));
        --local sprite = object.sprite_;
        --sprite:setRotation(tonum(object.flyDegrees_));
    end
    object:bindMethod(self, "updateView", updateView)
end

function PlaneBehavior:unbind(object)
end

function PlaneBehavior:reset(object)
end

return PlaneBehavior
