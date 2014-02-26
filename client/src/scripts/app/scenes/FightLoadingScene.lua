--[[
战斗的loading场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightLoadingScene = class("FightLoadingScene", BaseScene)



function FightLoadingScene:ctor(param)
--	self.currentSceneName_ = GameSoundProperties.bg_sound;
--	audio.playBackgroundMusic(self.currentSceneName_());
	
	
	self.stepIndex   = 0

    self.steps = {}
    
    
    self.steps[#self.steps + 1] = function()
       --加载数据
       local level = param.level;--地图
       local levelModuleName    = string.format("app.data.level.Lv%s_map", level)
	   local ok, data = pcall(function() return require(levelModuleName) end)
	   if not ok or type(data) ~= "table" then
	   		ok, data = pcall(function() return require("app.data.level.Lv1000_map") end)
	   end
	   
	   self.param_ = {levelData = data};
	   
    end
    
    
    self.steps[#self.steps + 1] = function()
        display.addSpriteFramesWithFileListName(GamePlistProperties.Sheet_Map());
    end
end




function FightLoadingScene:tick()
    local count = #self.steps
    if self.stepIndex < count then
    	self.stepIndex = self.stepIndex + 1
	    local ok, err = pcall(self.steps[self.stepIndex])
	    if ok then
	        echoj("加载进度：",self.stepIndex / count * 100)
	    else
	        echoError(err)
	    end
    elseif self.stepIndex >= count then
        self:unscheduleUpdate()
        self:performWithDelay(function()
        	local sceneName,backScaneName = SceneConstants.FightScene()
        	app:enterScene(sceneName,backScaneName,self.param_)
        end, 0.1)
    end
end



function FightLoadingScene:onTouch(event, x, y)
end


function FightLoadingScene:onCleanup()
end


return FightLoadingScene
