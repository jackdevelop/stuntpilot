--[[
战斗场景
]]
local FightSceneUI = class("FightSceneUI", Base)


	
function FightSceneUI:initView()
	local batch = self:getBatch();
	
	
	
--	local txt =  cc.ui.UILabel.new({text = "角度：0", size = 24, color = display.COLOR_BLACK})
--        :align(display.CENTER, display.cx, display.top - 20)
--        :addTo(batch)
        
--    local vectorTxt =  cc.ui.UILabel.new({text = "向量：(1,0)", size = 24, color = display.COLOR_BLACK})
--        :align(display.CENTER, display.cx, display.top - 40)
--        :addTo(batch)
       
        
	
	 --向下
--	 SpriteButton:newButton("#NagScreen_lastGame.png", "↓",true, function()
	 SpriteButton:newButton("#NagScreen_lastGame.png", "↓",true, function()
		local plane = self.object_.sceneController_.plane;--飞机
        plane:decreasePlaneFlyDegrees(1);
        
--        local radians = plane:getPlaneFlyDegrees();
--        txt:setString("度数："..radians);
        
--        local vectorX = math.cos(360-radians)*2;
--        local vectorY = math.sin(radians)*2;
--        vectorTxt:setString("向量："..vectorX..","..vectorY);
	end)
	:align(display.CENTER,display.cx - 100, display.bottom + 50)
	:addTo(batch)
	
	--向上
--	SpriteButton:newButton("#NagScreen_nextGame.png", "↑",true, function()
	SpriteButton:newButton("#NagScreen_nextGame.png", "↑",true, function()
		local plane = self.object_.sceneController_.plane;--飞机
        plane:decreasePlaneFlyDegrees(-1);
        
--        local radians = plane:getPlaneFlyDegrees();
--        txt:setString("度数："..radians);
        
--        local vectorX = math.cos(360-radians)*2;
--        local vectorY = math.sin(radians)*2;
--        vectorTxt:setString("向量："..vectorX..","..vectorY);
	end)
	:align(display.CENTER,display.cx + 100, display.bottom + 50)
	:addTo(batch)
	
	
	
	
	SpriteButton:newButton("#cannon_foot_png.png", "HELP",false, function()
		local object = self.object_;
    	object.sceneController_:pausePlay();
		
		--添加暂停开始的ui
		local HelpUI = require("app.views.HelpUI");
		local helpUI = HelpUI.new(nil,object);
		helpUI:initView();
		PopUpManager:addPopUp(helpUI,nil,true,true)
		
	end)
	:align(display.CENTER,display.width-100, display.bottom + 50)
	:addTo(batch)
	
	
	
	
	
	
--	local loginButtonParam = {
--	    on ="fight/Button02.png",
--	}
--	cc.ui.UICheckBoxButton.new(loginButtonParam)
--        :setButtonLabel(cc.ui.UILabel.new({text = "↓", size = 16,  color = display.COLOR_BLUE}))
--        --:setButtonLabelOffset(0, 40)
--        --:setButtonEnabled(false)
--        :setButtonLabelAlignment(display.CENTER)
--        :onButtonStateChanged(function(event)
--        	local plane = self.object_.sceneController_.plane;--飞机
--            plane:decreasePlaneFlyRadians(1);
--            
--            local radians = plane:getPlaneFlyRadians();
--            txt:setString("度数："..radians);
--        end)
--        :align(display.CENTER,display.cx - 100, display.bottom + 50)
--        :addTo(batch)
	
--	 --向上
--	local loginButtonParam = {
--	    on ="fight/Button02.png",
--	}
--	cc.ui.UICheckBoxButton.new(loginButtonParam)
--        :setButtonLabel(cc.ui.UILabel.new({text = "↑", size = 16,  color = display.COLOR_BLUE}))
--        --:setButtonLabelOffset(0, 40)
--        --:setButtonEnabled(false)
--        :setButtonLabelAlignment(display.CENTER)
--        :onButtonStateChanged(function(event)
--        	local plane = self.object_.sceneController_.plane;--飞机
--            plane:decreasePlaneFlyRadians(-1);
--            
--            local radians = plane:getPlaneFlyRadians();
--            txt:setString("度数："..radians);
--        end)
--        :align(display.CENTER,display.cx + 100, display.bottom + 50)
--        :addTo(batch)
	
end




return FightSceneUI
