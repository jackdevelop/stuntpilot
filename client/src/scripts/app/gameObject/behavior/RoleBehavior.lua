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
    local function setFocus(object,enable)
		object.isFocus_ = enable; 
		
		if enable == true then
			object.map_:setFocusObject(object);
		end
    end
    object:bindMethod(self, "setFocus", setFocus)
    
    
     local function isFocus(object)
		return object.isFocus_ ; 
    end
    object:bindMethod(self, "isFocus", isFocus)

end

function RoleBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
end

function RoleBehavior:reset(object)
end

return RoleBehavior
