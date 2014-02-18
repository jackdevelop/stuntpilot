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
	self.model_ = FightModel.new(self.scene_.batch_);
	
	
	self:init();
end




--[[
初始化
]]
function FightController:init()
	local plane = self.model_:newObject("static", {defineId = "p1_cart"})
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
        if object.updated__ and object.sprite_ and object.viewZOrdered_ then
            self.batch_:reorderChild(object.sprite_, maxZOrder - object.y_ )
        end
	
	end
	
end


return FightController
