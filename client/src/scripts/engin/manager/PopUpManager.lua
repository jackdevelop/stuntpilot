--[[
 	PopUpManager.lua
 	public ->> 全局公开类
 	
	弹出管理类  包括弹出框以及场景弹出等
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]

local PopUpManager = class("PopUpManager");


--构造函数
function PopUpManager:ctor()
	self.arr_ = {};
end




--[[
创建一个顶级窗口，并按 z 轴顺序将其置于其他窗口上方。最好调用 removePopUp() 方法来删除使用 createPopUp() 方法创建的弹出窗口。如果该类实现了 IFocusManagerContainer，则该窗口将拥有自己的 FocusManager；因此，当用户使用 Tab 键在各个控件之间导航时，将只能访问此窗口中的控件。 
示例
pop = mx.managers.PopUpManager.createPopUp(pnl, TitleWindow, false); 
基于 TitleWindow 类创建一个弹出窗口，并使用 pnl 作为 MovieClip 来确定放置此弹出窗口的位置。此窗口将定义为非模态窗口，即其他窗口也可以接收鼠标事件

 参数 
 parent:DisplayObject — DisplayObject，用于确定要使用 SystemManager 的哪些层，以及（可选）确定居中新的顶级窗口所用的参考点。它可能并非弹出窗口的实际父项，因为所有弹出窗口都以 SystemManager 为父项。  
 className:Class — 要为弹出窗口创建的对象的类。该类必须实现 IFlexDisplayObject。  
 modal:Boolean (default = false) — 如果为 true，则该窗口为模态窗口，也就是说在删除该窗口之前，用户将无法与其他弹出窗口交互。  
 childList:String (default = null) — 要将弹出窗口添加到的子项列表。PopUpManagerChildList.APPLICATION、PopUpManagerChildList.POPUP 或 PopUpManagerChildList.PARENT（默认）中的任意一项。  
 moduleFactory:IFlexModuleFactory (default = null) — 此弹出窗口应在其中查找其嵌入字体和样式管理器的 moduleFactory。  
返回
 IFlexDisplayObject — 对新的顶级窗口的引用。  
]]
function PopUpManager:createPopUp(parent, class, modal,initobj,outsideEvents)



end



--[[
弹出顶级窗口。最好调用 removePopUp() 来删除使用 addPopUp() 方法创建的弹出窗口。如果该类实现了 IFocusManagerContainer，则该窗口将拥有自己的 FocusManager；因此，当用户使用 Tab 键在各个控件之间导航时，将只能访问此窗口中的控件。 
示例
var tw:TitleWindow = new TitleWindow();
tw.title = "My Title";
mx.managers.PopUpManager.addPopUp(tw, pnl, false);
使用 TitleWindow 类的 tw 实例创建一个弹出窗口，并使用 pnl 作为 Sprite 来确定放置此弹出窗口的位置。此窗口将定义为非模态窗口。

 参数 
 window:IFlexDisplayObject — 要弹出的 IFlexDisplayObject。  
 parent:DisplayObject — DisplayObject，用于确定要使用 SystemManager 的哪些层，以及（可选）确定居中新的顶级窗口所用的参考点。它可能并非弹出窗口的实际父项，因为所有弹出窗口都以 SystemManager 为父项。  
 modal:Boolean (default = false) — 如果为 true，则该窗口为模态窗口，也就是说在删除该窗口之前，用户将无法与其他弹出窗口交互。  
 childList:String (default = null) — 要将弹出窗口添加到其中的子项列表。PopUpManagerChildList.APPLICATION、PopUpManagerChildList.POPUP 或 PopUpManagerChildList.PARENT（默认）中的任意一项。  
 moduleFactory:IFlexModuleFactory (default = null) — 此弹出窗口应在其中查找其嵌入字体和样式管理器的 moduleFactory。  
]]
function PopUpManager:addPopUp(window, parent, modal,center, childList, moduleFactory)
	if not parent then 
		parent = app.currentScene_; --当前场景的ui层
		
		if parent.getUILayer then
			parent = parent:getUILayer();
		end
	end
	
	
	local cover;
	if modal then 
		cover = SpriteCover.createCoverSprite();
		parent:addChild(cover);
	end
	
	if center then
		PopUpManager:center(window)
	end
	
	self.arr_ [#self.arr_ + 1] = {window,cover};
	parent:addChild(window);
end



--[[
删除由 createPopUp() 或 addPopUp() 方法弹出的弹出窗口。 
 参数 
 popUp:IFlexDisplayObject — 表示弹出窗口的 IFlexDisplayObject。  
]]
function PopUpManager:deletePopUp(popUp,effetId,onComplete)
	 for i = #self.arr_, 1, -1 do
	 	local onePopup,cover = self.arr_[i][1],self.arr_[i][2];
        if onePopup  == popUp then 
        	
        	
        	local function onCompleteHandle() 
        		popUp:removeView();
        		
        		if cover then 
        			cover:removeSelf();
        		end
        	end
        	
        	
        	
        	
        	onCompleteHandle();
        	
--        	--特效
--			CCDirector:sharedDirector():setDepthTest(false)
--			--[[ 
--				作用：分多行消失特效
--				参数1：特效持续的时间
--				参数2：行数
--			]]
--			local actions = {};
--			local time = 1
--			actions[#actions + 1] = CCSplitRows:create(time, 9);
--			actions[#actions + 1] = CCCallFunc:create(onCompleteHandle);
--			local effect = transition.sequence(actions)
--		    popUp:runAction(effect)
    
        	
		 	table.remove(self.arr_, i)
		 	return;
--		else
--			table.remove(self.arr_, i)
		end
	end
end






--[[
删除全局的所有弹框
]]
function PopUpManager:deleteAllPopUp()
	 for i = #self.arr_, 1, -1 do
		 	local onePopup,cover = self.arr_[i][1],self.arr_[i][2];
	        if onePopup and not tolua.isnull(onePopup) then
				onePopup:removeSelf();
			end
			
			if cover then 
				cover:removeSelf();
			end
			
			table.remove(self.arr_, i)
	 end
end






--[[
请确保弹出窗口高于其子项列表中的其他对象。如果该弹出窗口是顶级窗口并且位于鼠标下，则 SystemManager 会自动将其设置为满足此要求；否则，您必须自行处理。 
 参数 
 popUp:IFlexDisplayObject — 表示弹出窗口的 IFlexDisplayObject。  
]]
function PopUpManager:bringToFront(popUp)
	popUp:setZOrder(SceneConstants.MAX_UI_ZORDER);
end

--居中
function PopUpManager:center(popUp)
	popUp:align(display.CENTER,display.cx ,display.cy)
end



function PopUpManager:dump()
	local arra = self.arr_;
	echo("dump 当前有多少个子窗口: " .. #arra)
end


return PopUpManager;