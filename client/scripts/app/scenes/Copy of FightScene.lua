--[[
战斗场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor(param)
	param.sceneSound = GameSoundProperties.bg_sound();
--	FightScene.super.ctor(self,param)
	 
	
	-- mapLayer 包含地图的整个视图
    self.mapLayer = display.newNode()
    self.mapLayer:align(display.LEFT_BOTTOM, 0, 0)
    self:addChild(self.mapLayer)
    
    
    self.touchLayer_ = display.newLayer()
    self:addChild(self.touchLayer_)-- touchLayer 用于接收触摸事
    
    
    self:createCCParallax();
      
    
    self.uiLayer_ = display.newLayer();
    self.mapLayer:addChild(self.uiLayer_);--ui层
    
	 
	--控制器
	local FightController = require("app.controllers.FightController")
	self.sceneController_ = FightController.new(self);
end






--[[
创建CCParallaxNode 
]]
function FightScene:createCCParallax()	
	--创建一个批量渲染层
    self.backgroundSprite_ = CCParallaxNode:create()
    self.mapLayer:addChild( self.backgroundSprite_ )
    
    --远景
    local background = display.newSprite("#background.png")
    GameUtil.spriteFullScreen(background)
	--第一个参数不用废话了，第二个参数就是正常的zOrder，第三个参数是比例，例如你设置为(0.1,0.9),若你的层或者说是CCParallaxNode的实例x轴移动1，y轴移动1，则你添加的这个精灵x轴移动0.1（1*0.1），y轴移动0.9（1*0.9），这是移动对精灵的处理，但是在位置设置的时候也是有影响的。子节点的位置是这么设置的：
    --第四个参数想设置要什么位置就设置什么位置,原理在我绕了一个大弯路讲解之后大家应该明白了吧！
--	 刚刚开始研究CCParallaxNode习惯性设置位置，所以导致自己郁闷了好久，先与大家分析一下，讲解一下原理，望大家不要再走我的弯路……
--	至于为什么我添加四个节点都是屏幕中间位置，那是我为了让大家更好的明白这个位置问题，之后我贴出的代码有注释了的，注释了的为设置了CCParallaxNode的实例的位置，大家开启比较一下，会更加明白的。
--	 对了，还有一点就是关于这个移动，你移动CCParallaxNode的实例也行，移动层也行，看需求。
    self.backgroundSprite_:addChild(background, -1, ccp(0,0), ccp(display.cx,display.cy))
    
    
    
    --中景
    --local background_mountain = display.newBatchNode(image, capacity)
    local background_mountain = display.newNode();
     background_mountain:align(display.LEFT_BOTTOM, 0, 0)
--    local background_mountain = display.newSprite("res/fight/background_mountain.png")
--    display.align(background_mountain,display.LEFT_CENTER)
	local spt = display.newSprite("#background_mountain.png");
	 spt:align(display.LEFT_BOTTOM, 0, 0)
    background_mountain:addChild(spt) 
--     local background_mountain2 = display.newSprite("res/fight/background_mountain.png")
--      display.align(background_mountain2,display.LEFT_CENTER)
	local spt = display.newSprite("#background_mountain.png");
	 spt:align(display.LEFT_BOTTOM, 800, 0)
    background_mountain:addChild(spt) 
--    background_mountain:addChild(display.newSprite("res/fight/background_mountain.png",800,0));
     self.backgroundSprite_:addChild(background_mountain, 1, ccp(0.1,0), ccp(0,84)) 
     
     
     
     --近景
--     local background_mountain = display.newBatchNode(image, capacity)
     local ground = display.newNode();
      ground:align(display.LEFT_BOTTOM, 0, 0)
      local spt = display.newSprite("#ground.png");
	 spt:align(display.LEFT_BOTTOM, 0, 0)
    ground:addChild(spt) 
     local spt = display.newSprite("#ground.png");
	 spt:align(display.LEFT_BOTTOM, 1150, 0)
    ground:addChild(spt) 
--     self.backgroundSprite_:addChild( self.ground_, 2, ccp(0.3,0), ccp(0,60))
     
--     self.ground2_ = display.newSprite("res/fight/ground.png")
--     display.align( self.ground2_,display.LEFT_CENTER)
     self.backgroundSprite_:addChild(ground, 2, ccp(0.2,0), ccp(0,60))
     
     
     
     
      self.batch_=display.newNode()
      self.batch_:align(display.LEFT_BOTTOM, 0, 0)
      self.backgroundSprite_:addChild(self.batch_, 3, ccp(0.2,0), ccp(0,0))
--    self.mapLayer:addChild(self.batch_)--渲染层
--     self.backgroundSprite_:setPosition(-1200,0);
     
     --默认的地图走向
     self.addNum_ = -10;
     
     
 
--     echoj(    self.batch_:getBoundingBox(),self.batch_:getContentSize());
     --
--     self.backgroundSprite_ :setVisible(false);
--    echoj(self.batch_:get);
    
    
    self.backgroundSprite_:setVisible(false);
    self.scrollSprite111_ = require("engin.components.ScrollSpriteByAllGeneration").new();
    self.scrollSprite111_:initData("#ground.png",nil,Jpoint(-1,0),Jpoint(2,2))
    self.scrollSprite111_:initView()
    self:addChild(self.scrollSprite111_);
   
    
    
    --运转动画
--    local  go = CCMoveBy:create(10, ccp(-2700,0) )
--    local  goBack = go:reverse()
--    local arr = CCArray:create()
--    arr:addObject(go)
--    arr:addObject(goBack)
--    local  seq = CCSequence:create(arr)
--    self.backgroundSprite_:runAction( (CCRepeatForever:create(seq) ))
end









----添加移动的子节点
--function FightScene:addCCParallaxChild(child,zorder,parallaxRatio,positionOffset)	
--	if not zorder then zorder = 0 end
--	if not parallaxRatio then parallaxRatio = ccp(0,0) end
--	if not positionOffset then positionOffset = ccp(0,0) end
--	
--	self.backgroundSprite_:addChild(child, zorder,parallaxRatio,positionOffset)
--end










function FightScene:tick(dt)
	local positionX = self.backgroundSprite_:getPosition();
	if positionX < -6600 then 
		self.addNum_ = 10; 
		 self.scrollSprite111_:setMovingDistance(Jpoint(1,0))
	elseif positionX > 0 then 
		self.addNum_ = -10; 
	end
	
	self.backgroundSprite_:setPosition(positionX+self.addNum_,0);
	
	self.sceneController_:tick(dt);
	
	 self.scrollSprite111_ :tick();
end




--触摸
function FightScene:multiTouchHandle(event, points)

end
return FightScene
