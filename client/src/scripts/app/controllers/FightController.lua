--[[
战斗控制器
]]

local FlyDegreesData = require("app.data.FlyDegreesData")

local FightController = class("FightController")



--[[
战斗控制器 构造函数
@param scene 场景
]]
function FightController:ctor(scene,levelData)
	--显示场景
	self.scene_  =  scene; 
	
	--模型
	local FightModel = require("app.model.FightModel")
	self.model_ = FightModel.new(self,levelData);
	
	
	self:init();
end




--[[
初始化
]]
function FightController:init()
	--初始化地图
	local levelData = self.model_.levelData_;
	local staticData = levelData.static;
	for id,v in pairs(staticData) do
		self.model_:newObject(BaseObject.CLASS_ID["static"], v,id)
	end
	


	local state = {
		defineId = "p1_cart",
		x = 0,--display.width,
		y = display.cy
	}
	self.plane = self.model_:newObject(BaseObject.CLASS_ID["role"], state)
	self:setFocus();
end



--[[
设置飞机加油量
]]
function FightController:setFocus()
	local plane = self.plane_;--飞机对象
	--self.plane:setPlaneFlyDegrees(radians);
	local mapCamera = self.scene_:getCamera()
	mapCamera:setFocus(self.plane)
end







--tick帧跳
function FightController:tick(dt)
	local model = self.model_
	local allObject = model:getAllObjects();
	
	if model.over_  then return end;
	
	
	--检测碰撞相关
	for i, object in pairs(allObject) do
		if object ~= self.plane then 
			local collision = SearchAlgorithm.checkCollision(object,self.plane)
			if collision then 
				model.over_ = true;
				return;
			end
		end
	end
	
	
	

	local maxZOrder = SceneConstants.MAX_OBJECT_ZORDER;
	for i, object in pairs(allObject) do
		local lx, ly = object.x_, object.y_
        object:tick(dt)
        object.updated__ = lx ~= object.x_ or ly ~= object.y_

        -- 只有当对象的位置发生变化时才调整对象的 ZOrder
        if object.sprite_  then
        	object:updateView();
        	
        	if object.viewZOrdered_ then 
        		local batch = self.scene_:getBatchLayer();
            	batch:reorderChild(object.sprite_, maxZOrder - object.y_ )
            end
        end
	
	end
	
	
	
	
	--飞机行走	
	local x,y = self.plane:getPosition();
	local flyDegrees = self.plane:getPlaneFlyDegrees();
    local vectorX,vectorY = FlyDegreesData[toint(flyDegrees)]();
--    echoj("角度:",flyDegrees,"向量：".."("..vectorX,vectorY,")");
	self.plane:setPosition(x+vectorX,y+vectorY);
	
	
end


return FightController
