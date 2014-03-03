--[[
角色的管理
]]
local RoleBehavior = class("RoleBehavior", BehaviorBase)


function RoleBehavior:ctor()
    RoleBehavior.super.ctor(self, "RoleBehavior", nil, 1)
end

function RoleBehavior:bind(object)

	--[[
		设置摄像头跟随的物件
		 只能MapCamera.lua中调用此方法 
		 因为要保存两个引用
	]]
    local function setFocus(object)
		self.focusObject_ = object; 
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
