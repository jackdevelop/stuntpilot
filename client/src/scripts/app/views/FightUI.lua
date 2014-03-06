--[[
战斗场景
]]
local FightUI = class("FightUI", Base)


	
function FightUI:initView()
	local batch = self:getBatch();
	
	
	
	local txt =  cc.ui.UILabel.new({text = "角度：0", size = 24, color = display.COLOR_BLACK})
        :align(display.CENTER, display.cx, display.top - 20)
        :addTo(batch)
        
        
	
	 --向下
	 SpriteButton:newButton("fight/Button02.png", "↓",true, function()
		local plane = self.object_.sceneController_.plane;--飞机
        plane:decreasePlaneFlyRadians(1);
        
        local radians = plane:getPlaneFlyRadians();
        txt:setString("度数："..radians);
	end)
	:align(display.CENTER,display.cx - 100, display.bottom + 50)
	:addTo(batch)
	
	--向上
	SpriteButton:newButton("fight/Button02.png", "↑",true, function()
		local plane = self.object_.sceneController_.plane;--飞机
        plane:decreasePlaneFlyRadians(-1);
        
        local radians = plane:getPlaneFlyRadians();
        txt:setString("度数："..radians);
	end)
	:align(display.CENTER,display.cx + 100, display.bottom + 50)
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




return FightUI
