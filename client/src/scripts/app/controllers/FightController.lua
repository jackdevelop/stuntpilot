--[[
战斗控制器
]]



local FightController = class("FightController")



--[[
战斗控制器 构造函数
@param scene 场景
]]
function FightController:ctor(scene,param)
	--显示场景
	self.scene_  =  scene; 
	
	--模型
	local FightModel = require("app.model.FightModel")
	self.model_ = FightModel.new(self,param.levelData);
	
	
	self:init();
end




--[[
初始化
]]
function FightController:init()
	local state = {
		defineId = "p1_cart",
		x = display.cx,
		y = display.cy
	}
	self.plane = self.model_:newObject(BaseObject.CLASS_ID["role"], state)
end



--[[
设置飞机加油量
]]
function FightController:setPlaneFlyRadians(radians)
	local plane = self.plane_;--飞机对象
	self.plane:setPlaneFlyRadians(radians);
end




--tick帧跳
function FightController:tick(dt)
	local model = self.model_
	local allObject = model:getAllObjects();
	
	local maxZOrder = SceneConstants.MAX_OBJECT_ZORDER;
	 
	for i, object in pairs(allObject) do
		local lx, ly = object.x_, object.y_
        object:tick(dt)
        object.updated__ = lx ~= object.x_ or ly ~= object.y_

        -- 只有当对象的位置发生变化时才调整对象的 ZOrder
        if object.updated__ and object.sprite_  then
        	
        	object:updateView();
        	
        	if object.viewZOrdered_ then 
            	self.batch_:reorderChild(object.sprite_, maxZOrder - object.y_ )
            end
        end
	
	end
end


return FightController
