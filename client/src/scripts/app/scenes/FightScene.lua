--[[
战斗场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor(param)
	local levelData = param.levelData;
	
	param.sceneSound = GameSoundProperties[levelData.sceneSound](); --GameSoundProperties.bg_sound();
	param.backgroundImageName = levelData.backgroundImageName;
	param.parallaxImageName = levelData.parallaxImageName;
	param.width = levelData.width;
	param.height = display.height;
	param.batchNodeImage = levelData.batchNodeImage;
	param.touchEnabled = true
	FightScene.super.ctor(self,param)
    
    
    
    
    self:createCCParallax();
    --添加ui
    local FightSceneUI = require("app.views.FightSceneUI")
    local fightSceneUI = FightSceneUI.new(self:getUILayer(),self);
    fightSceneUI:initView();
    
    --控制器
    local FightController = require("app.controllers.FightController")
	self.sceneController_ = FightController.new(self,levelData);
	
end



function FightScene:initViewOnEnter()
	--添加暂停开始的ui
	local StartUI = require("app.views.StartUI");
	local startUI = StartUI.new(nil,self);
	startUI:initView();
	PopUpManager:addPopUp(startUI,nil,true,true)
end








--[[
创建CCParallaxNode 
]]
function FightScene:createCCParallax()	
	local batch = self:getBatchLayer();
	
	--调试
	local c = display.newSprite("#balloon_path_png.png")
    batch:addChild(c);
    c:setPosition(display.width,display.cy);
    
    local c = display.newSprite("#balloon_path_png.png")
    batch:addChild(c);
    c:setPosition(2*display.width,display.cy);
    
    local c = display.newSprite("#balloon_path_png.png")
    batch:addChild(c);
    c:setPosition(3*display.width,display.cy);
	--调试
	
	
	display.newSprite("#land_png.png")
	:align(display.LEFT_BOTTOM, 0, 0)
	:addTo(batch)
	
	display.newSprite("#land_png.png")
	:align(display.LEFT_BOTTOM, 800, 0)
	:addTo(batch)
	
	display.newSprite("#land_png.png")
	:align(display.LEFT_BOTTOM, 800*2, 0)
	:addTo(batch)
	
	
	
	
	display.newSprite("#ground_png.png")
	:align(display.LEFT_BOTTOM, 0, 0)
	:addTo(batch)
	
	display.newSprite("#ground_png.png")
	:align(display.LEFT_BOTTOM, 1150, 0)
	:addTo(batch)
	
	display.newSprite("#ground_png.png")
	:align(display.LEFT_BOTTOM, 1150*2, 0)
	:addTo(batch)
	
	
	
end















function FightScene:tick(dt)
	FightScene.super.tick(self,dt);
	
	self.sceneController_:tick(dt);
end





----[[
--根据起点和终点返回方向 1：向上，2：向下，3：向左，4：向右,0：未滑动
--]]
--local function GetSlideDirection(startX, startY, endX, endY)
--	local dy = startY - endY;
--	local dx =  endX - startX;
--	local result = 0;
--	
--	--如果滑动距离太短
----	if (math.abs(dx) < 2 and math.abs(dy) < 2) then
----        return result;
----    end
--    
--    
----     local radians = Math2d.radians4point(0, 0, 4, 3)
----     local angle = Math2d.radians2degrees(radians)
--	local radians = Math2d.radians4point(0, display.height, endX, endY)
----    local radians = Math2d.radians4point(startX, startY, endX, endY)
--    local angle = Math2d.radians2degrees(radians)
--    
--    
--    echoj(radians,angle,"角度：");
--    if (angle >= -45 and angle < 45) then
--        result = 4;
--    elseif (angle >= 45 and angle < 135)  then
--        result = 1;
--    elseif (angle >= -135 and angle < -45) then
--        result = 2;
--    elseif ((angle >= 135 and angle <= 180) or (angle >= -180 and angle < -135))  then
--        result = 3;
--    end
--    
--    return result;
--end







----[[--
--	触摸事件 
--]]
--function FightScene:onTouch(event, x, y)
--	if event == "began" then
----		self.startY = y;
--		if x > display.cx then --向上
--			self.sceneController_.plane:decreasePlaneFlyRadians(-1);
--		elseif x < display.cx then --向下
--			self.sceneController_.plane:decreasePlaneFlyRadians(1);
--		end
--		
--		return true
--	elseif event == "moved" then
--	else
--	end
--end




return FightScene
