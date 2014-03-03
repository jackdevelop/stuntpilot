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
	param.height = levelData.height;
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






--[[--
	触摸事件 
]]
function FightScene:onTouch(event, x, y)
	if event == "began" then
		self.startJpoint = Jpoint(x,y);
		
		return true
	elseif event == "moved" then
	else
--		local endOffestY  = y - self.startY;
--		if endOffestY > 10 then --向上
--			self.sceneOil_ = 1;
--		elseif endOffestY < 10 then --向下
--			self.sceneOil_ = -1;
--			self.sceneOil_ = Jpoint(-1,0);
--			self.sceneController_:setPlaneFlyDirection(,up);
--		end
		
		local radians = Math2d.radians4point(self.startJpoint(), x, y)
		self.sceneController_:setPlaneFlyRadians(radians);
		self.startJpoint = nil
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
