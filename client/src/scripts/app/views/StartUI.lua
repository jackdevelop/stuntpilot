
--[[--

	初始化的“战斗开始”界面

]]
local StartUI = class("StartUI", BaseSprite)



function StartUI:initView()
	
	local loginButtonParam = {
	    on ="#menu_button_play_big_png.png",
	}
	cc.ui.UICheckBoxButton.new(loginButtonParam)
        --:setButtonLabel(cc.ui.UILabel.new({text = "start", size = 24,  color = display.COLOR_WHITE}))
        --:setButtonLabelOffset(0, 40)
        --:setButtonEnabled(false)
        :setButtonLabelAlignment(display.CENTER)
        :onButtonStateChanged(function(event)
        	 PopUpManager:deletePopUp(self)
        	 
        	 local object = self.object_;
        	 object.sceneController_:resumePlay();
        	 
        end)
        :align(display.CENTER,0 ,0)
        :addTo(self)  
    
    
    	
	

	
	
end




return StartUI
