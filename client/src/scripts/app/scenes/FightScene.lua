--[[
战斗场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor(param)
	local levelData = param.levelData;
	
	param.sceneSound = GameSoundProperties[levelData.sceneSound](); --GameSoundProperties.bg_sound();
	param.backgroundImageName = levelData.backgroundImageName;
	param.width = 2048;
	param.height = 2048;
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
	local backgroundMountain = require("engin.components.HorizontalScrollSpriteByAllGeneration").new();
    backgroundMountain:initData("#background_mountain.png",nil,Jpoint(-1,0),Jpoint(2,0))
    backgroundMountain:initView()
    self.backgroundSprite_:addChild(backgroundMountain);
    self.backgroundMountain_ = backgroundMountain;
    
    --近处
    local ground = require("engin.components.HorizontalScrollSpriteByAllGeneration").new();
    ground:initData("#ground.png",nil,Jpoint(-2,0),Jpoint(2,0))
    ground:initView()
    self.ground_ = ground;
    self.batch_:addChild(ground);
end















function FightScene:tick(dt)
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
