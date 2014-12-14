--[[
战斗场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)






	
function FightScene:ctor(param)
	local levelData = param.levelData;
	
	--param.sceneSound = GameSoundProperties[levelData.sceneSound](); --GameSoundProperties.bg_sound();
	param.backgroundImageName = levelData.backgroundImageName;
	param.parallax = levelData.parallax;
	param.width = levelData.width;
	param.height = display.height*1.2;
	param.batchNodeImage = levelData.batchNodeImage;
	param.touchEnabled = true
	FightScene.super.ctor(self,param)
    
    
    
    
    
    
    --添加远景 近景的层次
    local parallax = levelData.parallax;
    local function createTiledNode(tileUrl)
		local tiledMap=CCTMXTiledMap:create(tileUrl);
	   return tiledMap
	end
    --远景
    local spt = GameUtil.addBackgroundImage(self.parallaxLayer_far_,parallax.parallaxLayer_far_ImageName);
	GameUtil.spriteFullScreen(spt)
	--中景
    self.parallaxLayer_in_:addChild(createTiledNode("map/tile/a1levmg.tmx"));
    --近景
    self.backgroundLayer_:addChild(createTiledNode("map/tile/0_0jg.tmx"));
    self.tiledMap_ = createTiledNode("map/tile/0_0.tmx");
    self.backgroundLayer_:addChild(self.tiledMap_);
    
    
    
    
    
    
--    --添加ui
--    local FightSceneUI = require("app.views.FightSceneUI")
--    local fightSceneUI = FightSceneUI.new(self:getUILayer(),self);
--    fightSceneUI:initView();
--    
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






















function FightScene:tick(dt)
	FightScene.super.tick(self,dt);
	
--	self.sceneController_:tick(dt);
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
