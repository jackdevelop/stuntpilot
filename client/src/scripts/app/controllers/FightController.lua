--[[
战斗控制器
]]


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
	
	--控制的数据
    self.over_ = false; 
	self.pause_ = true;
	
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
	local mapCamera = self.scene_:getCamera()
	mapCamera:setFocus(self.plane)
end












--暂停 
function FightController:pausePlay()
	if self.pause_ then return end
	
	self.pause_ = true;
	
	local model = self.model_
	local allObject = model:getAllObjects();
	
	for k,obj in pairs(allObject) do 
		obj:stopMovingNow();
		obj:pausePlay();
	end
end
--播放
function FightController:resumePlay()
	if not self.pause_ then return end
	
	
	self.pause_ = false;
	
	local model = self.model_
	local allObject = model:getAllObjects();
	
	
	for k,obj in pairs(allObject) do 
			obj:startMovingNow();
			obj:resumePlay();
	end
end













--tick帧跳
function FightController:tick(dt)
	local model = self.model_
	local allObject = model:getAllObjects();
	
	if  self.pause_  then return end;
	
	
	if not self.over_ then 
		--检测碰撞相关
		for i, object in pairs(allObject) do
			if object ~= self.plane then 
				local collision = SearchAlgorithm.checkCollision(object,self.plane)
				if collision then 
					self.over_ = true;
					
					--播放死忙特效
					object:setDestroyed(true);
					
					return;
				end
			end
		end
	end
	
	

	local maxZOrder = SceneConstants.MAX_OBJECT_ZORDER;
	for i, object in pairs(allObject) do
		local lx, ly = object.x_, object.y_
        object:tick(dt)
        object.updated__ = lx ~= object.x_ or ly ~= object.y_

        -- 只有当对象的位置发生变化时才调整对象的 ZOrder
        if object.sprite_ and object.updated__ then
        	object:updateView();
        	
        	if object.viewZOrdered_ then 
        		local batch = self.scene_:getBatchLayer();
            	batch:reorderChild(object.sprite_, maxZOrder - object.y_ )
            end
        end
	
	end
end


return FightController
