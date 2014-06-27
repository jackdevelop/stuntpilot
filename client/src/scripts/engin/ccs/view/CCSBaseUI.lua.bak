--[[
]]
local CCSBaseUI = class("CCSBaseUI",function()
      return display.newNode();
end);



--[[

@param  ccsName  ccs的面板名称
@param  plistArr  plist的响应资源 数组
]]
function CCSBaseUI:ctor(ccsPanelName,plistArr)
--	EventProtocol.extend(self);
	cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
	
	--显示panel
	self.ccsPanel_ = ccs.loadLayer(ccsPanelName);
	self:addChild(self.ccsPanel_);
	
	
	--加载plsit的ui资源
--	if plistArr then
--		for k,v in pairs(plistArr) do
--			display.addSpriteFramesWithFile(v);
--		end
--	end
	
	
	--背景
	local panel = self.ccsPanel_:getWidgetByName("Panel_bg")
	panel:setAnchorPoint(ccp(0.5,0.5))
	panel:setPosition(ccp(display.cx,display.cy))
	
	
	--关闭
	local colseButton =	self.ccsPanel_:getWidgetByName("Button_close");
	if colseButton then
		CCSButton:registerEventScript(colseButton,false,function() self:dispose(MapConstants.CLOSE_BTN) end);
	end
	
	--返回按钮
	local cancelButton =	self.ccsPanel_:getWidgetByName("Button_cancel");
	if cancelButton then
		cancelButton:setTouchEnabled(false)
		CCSButton:registerEventScript(cancelButton,false,function() self:dispose(MapConstants.CLOSE_BTN) end);
		--没有使用到的首先隐藏
		cancelButton:setVisible(false)
		
	end
end





--[[
 获取当前ccs的layer
]]
function CCSBaseUI:getCCSPanel()
	return self.ccsPanel_;
end







--[[
关闭
当是点击x的时候  closeId 为0
当是点击返回按钮的时候  closeId 为1
其他情况自定
其他为自定义
]]
function CCSBaseUI:dispose(closeId)
	self:dispatchEvent({name = "close",data={closeId = closeId}})	
	PopUpManager:deletePopUp(self,"0")
--	PopUpManager:deletePopUp(self.imageBg_,"0")
end




return CCSBaseUI
