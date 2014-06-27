
local DestroyedBehavior = class("DestroyedBehavior", BehaviorBase)

function DestroyedBehavior:ctor()
    DestroyedBehavior.super.ctor(self, "DestroyedBehavior", nil, 1)
end

function DestroyedBehavior:bind(object)
	
    local function isDestroyed(object)
        return object.destroyed_
    end
    object:bindMethod(self, "isDestroyed", isDestroyed)

	
	local function setDestroyed(object,destroyed)
        object.destroyed_ = destroyed;
        
        if destroyed then 	
        	
        	object:setPlaneFlyDegrees(9);
        	object:setSpeed(checknumber(object.state_.speed * 2))
        	object:enforcePlay();
        end
    end
    object:bindMethod(self, "setDestroyed", setDestroyed)
    
    
    
    
    
    
    
    
    
end

function DestroyedBehavior:unbind(object)
	object.destroyed_ = nil;
    object:unbindMethod(self, "isDestroyed")
    object:unbindMethod(self, "setDestroyed")
end

function DestroyedBehavior:reset(object)
end

return DestroyedBehavior
