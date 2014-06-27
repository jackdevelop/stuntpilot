--[[
 	CCSButton
 	public ->> 全局公开类
 	不可重写
 	
 	ccs的按钮
	使用：
 	local colseButton =	self.ccsPanel_:getWidgetByName("Button_close");
	if colseButton then
		CCSButton.registerEventScript(colseButton,false,function() self:dispose(MapConstants.CLOSE_BTN) end);
	end
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local CCSButton = class("CCSButton");





--[[
@param imageName 按钮的图片地址
@param txt  按钮上的文字
@param isPress 是否可以长按  默认为false
@param listener 任何点击后的回调
]]
function CCSButton.registerEventScript(button,isPress, clickListener,listener)
	--点击效果
--	local function touchClick()
--		 button:setOpacity(128)
--	end
	
--	--没点击的效果
--	local function touchNoClick()
--		button:setOpacity(255)
--	end
	
	
	--点击监听回调事件
	local function clickOneceHandle()
		if clickListener then 
			clickListener()
		end
	end
	
	
	local pressAction = nil;
	local dt_ = 0;
	local function clickPressHandle(flag)
		if flag then 
			if isPress and not pressAction then 
--	       		pressAction = node:scheduleUpdate(function(dt) --schedule
	       		pressAction = scheduler.scheduleGlobal(function(dt)
	       			dt_ = dt_ + dt
	       			if dt_ > 0.5 then
	       				clickOneceHandle();
	       				dt_ = 0;
	       			end
	       		end, 3)
	       	end
	    else
	    	--node:unscheduleUpdate();
	    	print("取消长按");
	    	if pressAction then
		    	scheduler.unscheduleGlobal(pressAction);
		    	pressAction = nil
	    	end
       	end
	end
	
	button:addTouchEventListener(function(object,event)
--	button:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
--	button:addTouchEventListener(function(object,event)
		local name =event-- event.name;
		if name == TOUCH_EVENT_BEGAN then --点击下去
			clickPressHandle(true);
		elseif name == TOUCH_EVENT_MOVED then --移动
		elseif name == TOUCH_EVENT_CANCELED then --当触发move后  已经移出到其他部位上去了   然后在up弹起
			clickPressHandle(false);
		elseif name == TOUCH_EVENT_ENDED then --点击放开后
			clickPressHandle(false);
			clickOneceHandle();
		end
		
		if listener then
			listener(event,object);
		end
	end);
	


--	button:registerEventScript(function(event,object)
--		if event == "changeToPressed" then --鼠标到当前按钮上面
--			
--		elseif event == "pushDown" then --点击下去
--			clickPressHandle(true);
--		elseif event == "move" then --移动
--		elseif event == "changeToNormal" then --当触发move后  已经移出到其他部位上去了 
--			clickPressHandle(false);
--		elseif event == "cancelUp" then --当触发move后  已经移出到其他部位上去了   然后在up弹起
--		elseif event == "releaseUp" then --点击放开后
--			clickPressHandle(false);
--			clickOneceHandle();
--		end
--		
--		if listener then
--			listener(event,object);
--		end
--	end);
    return button
end



return CCSButton