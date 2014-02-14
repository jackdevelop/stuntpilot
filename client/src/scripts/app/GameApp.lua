
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

require("engin.config.EnginInit")
require("app.config.init")

local UIDemoApp = class("UIDemoApp", cc.mvc.AppBase)




function UIDemoApp:ctor()
    UIDemoApp.super.ctor(self)
end






function UIDemoApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene(SceneConstants.FightLoadingScene)
  	--self:enterScene(SceneConstants.FightLoadingScene, nil, "flipy")
end






--[[
进入某个场景
]]
function UIDemoApp:enterScene(sceneName, param,...)
	if not param then param = {} end
	param.sceneName = sceneName;
    UIDemoApp.super.enterScene(self, sceneName,param, ...)
    
    self.previousSceneName_ = self.currentSceneName_;
    self.currentSceneName_ = sceneName;
    self.currentScene_ = display.getRunningScene();
end

return UIDemoApp
