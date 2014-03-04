--[[
战斗场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor(param)
	local levelData = param.levelData;
	
	
	param.sceneSound = GameSoundProperties[levelData.sceneSound](); --GameSoundProperties.bg_sound();
	param.backgroundImageName = levelData.backgroundImageName;
	param.width = levelData.width;
	param.height = display.height;
	FightScene.super.ctor(self,param)
    GameUtil.spriteFullScreen(self.backgroundSprite_)
    
    
    
    
    self:createCCParallax();
    
    
    --控制器
    local FightController = require("app.controllers.FightController")
	self.sceneController_ = FightController.new(self,levelData);
	
end






--[[
创建CCParallaxNode 
]]
function FightScene:createCCParallax()	
	--远处山
--	local backgroundMountain = require("engin.components.HorizontalScrollSpriteByAllGeneration").new();
--    backgroundMountain:initData("#background_mountain.png",nil,Jpoint(-1,0),Jpoint(2,0))
--    backgroundMountain:initView()
--    self.backgroundSprite_:addChild(backgroundMountain);
--    self.backgroundMountain_ = backgroundMountain;
    
--    --近处
--    local ground = require("engin.components.HorizontalScrollSpriteByAllGeneration").new();
--    ground:initData("#ground.png",nil,Jpoint(-2,0),Jpoint(2,0))
--    ground:initView()
--    self.ground_ = ground;
--    self.batch_:addChild(ground);
    
--    最简单的算法是
--	 三层移动速度都是一样的
--	 不过
--	 背景层.scaleX = 背景层.scaleY = 0.8
--	地面层不动
--	 前景层.scaleX = 前景层.scaley = 1.2

	local spt = display.newSprite("#ground.png",display.cx,display.cy);
	self.batch_:addChild(spt);
end















function FightScene:tick(dt)
	FightScene.super.tick(self,dt);
	
	self.sceneController_:tick(dt);
	--测试
--	self.ground_:tick(dt);
--	self.backgroundMountain_:tick(dt);
end





--[[
根据起点和终点返回方向 1：向上，2：向下，3：向左，4：向右,0：未滑动
]]
local function GetSlideDirection(startX, startY, endX, endY)
	local dy = startY - endY;
	local dx =  endX - startX;
	local result = 0;
	
	--如果滑动距离太短
--	if (math.abs(dx) < 2 and math.abs(dy) < 2) then
--        return result;
--    end
    
    
--     local radians = Math2d.radians4point(0, 0, 4, 3)
--     local angle = Math2d.radians2degrees(radians)
	local radians = Math2d.radians4point(0, display.height, endX, endY)
--    local radians = Math2d.radians4point(startX, startY, endX, endY)
    local angle = Math2d.radians2degrees(radians)
    
    
    echoj(radians,angle,"角度：");
    if (angle >= -45 and angle < 45) then
        result = 4;
    elseif (angle >= 45 and angle < 135)  then
        result = 1;
    elseif (angle >= -135 and angle < -45) then
        result = 2;
    elseif ((angle >= 135 and angle <= 180) or (angle >= -180 and angle < -135))  then
        result = 3;
    end
    
    return result;
end







--[[--
	触摸事件 
]]
function FightScene:onTouch(event, x, y)
	if event == "began" then
--		self.startY = y;
		if x > display.cx then --向上
			self.sceneController_.plane:decreasePlaneFlyRadians(-1);
		elseif x < display.cx then --向下
			self.sceneController_.plane:decreasePlaneFlyRadians(1);
		end
		
		return true
	elseif event == "moved" then
	else
--		local endOffestY  = math.floor((y - self.startY));
--		if endOffestY > 2 then --向上
--			self.sceneController_.plane:decreasePlaneFlyRadians(-1);
--		elseif endOffestY < -2 then --向下
--			self.sceneController_.plane:decreasePlaneFlyRadians(1);
--		end
--		self.startY = nil;
	end
end


--function FightScene:touchBegan(event, x, y)
--	echoj(event,x,y);
--end
--function FightScene:touchMoved(event, x, y)
--	echoj(event,x,y);
--end
--function FightScene:touchCancle(event, x, y)
--	echoj(event,x,y);
--end



return FightScene
