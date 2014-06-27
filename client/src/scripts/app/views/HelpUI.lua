
--[[--

	帮组的ui

]]
local HelpUI = class("HelpUI", BaseSprite)



function HelpUI:initView()
--	 cc.ui.UIImage.new("#instructions.png")
----        :align(display.CENTER, display.cx, display.cy)
--        :addTo(self)
        
        
        
        local param = {
			imageName		  = "#instructions.png",
--			x     = display.width-100,
--			y     = display.bottom + 50,
		    listener =function() 	
		    	 local object = self.object_;
		    	 object.sceneController_:resumePlay();
		    	 
		    	 
				 PopUpManager:deletePopUp(self)
		    end
		}
	 SpriteButton.newButton(param)
	 :addTo(self)
end




return HelpUI
