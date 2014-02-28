--[[
角色的管理
]]
local RoleBehavior = class("RoleBehavior", BehaviorBase)


function RoleBehavior:ctor()
    RoleBehavior.super.ctor(self, "RoleBehavior", nil, 1)
end

function RoleBehavior:bind(object)

	--[[
	]]
    local function setFocus(object,focusObject)
		self.focusObject_ = focusObject; 
    end
    object:bindMethod(self, "setFocus", setFocus)
    
    
     local function getFocus(object)
		return self.focusObject_ ; 
    end
    object:bindMethod(self, "getFocus", getFocus)

end

function RoleBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
end

function RoleBehavior:reset(object)
end

return RoleBehavior
