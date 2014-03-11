--[[
 	SpriteButton
 	public ->> 全局公开类
 	不可重写
 	
 	sprite的按钮
	使用：
	local c = SpriteButton:newButton(imageName, name,isPress, listener)
     self:addChild(c);
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local SpriteButton = class("SpriteButton");




--function TouchMenu:inSprite(x,y)
--	local touchInSprite
--	for k,v in ipairs(self.items) do
--		touchInSprite = v:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
--		if touchInSprite then
--			return k
--		end
--	end
--	return 0
--end


--[[
@param imageName 按钮的图片地址
@param name  按钮上的文字
@param isPress 是否可以长按  默认为false
@param listener 点击后的回调
]]
function SpriteButton:newButton(imageName, name,isPress, listener)
    local sprite = display.newSprite(imageName)

    if name then
        local cs = sprite:getContentSize()
        local label = ui.newTTFLabel({text = name, color = display.COLOR_BLACK})
        label:setPosition(cs.width / 2, cs.height / 2)
        sprite:addChild(label)
    end
	--sprite:setCascadeBoundingBox(CCRect(0, 0, display.width, display.height))
	
	--点击效果
	local function touchClick()
		 sprite:setOpacity(128)
	end
	
	
	--没点击的效果
	local function touchNoClick()
		sprite:setOpacity(255)
	end
	
	
	--点击监听回调事件
	local function clickOneceHandle()
		if listener then 
			listener()
		end
	end
	
	
	local pressAction = nil;
	local dt_ = 0;
	local function clickPressHandle(flag)
		if flag then 
			if isPress and not pressAction then 
	       		pressAction = sprite:scheduleUpdate(function(dt)
	       			dt_ = dt_ + dt
	       			if dt_ > 0.5 then
	       				clickOneceHandle();
	       				dt_ = 0;
	       			end
	       		end, 3)
	       	end
	    else
	    	sprite:unscheduleUpdate();
       	end
	end
	




    sprite:setTouchEnabled(true) -- enable sprite touch
    sprite:addTouchEventListener(function(event, x, y, prevX, prevY)
        if event == "began" then
           touchClick();
           
          clickPressHandle(true);
            return cc.TOUCH_BEGAN -- stop event dispatching
--			return cc.TOUCH_BEGAN_SWALLOWS --吞噬事件
--            return cc.TOUCH_BEGAN_NO_SWALLOWS -- continue event dispatching
        end

        local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
        if event == "moved" then
			if touchInSprite then 
				touchClick();
				clickPressHandle(true);
			else
				touchNoClick();
				clickPressHandle(false);
			end
			
        elseif event == "ended" then
            if touchInSprite then clickOneceHandle() end
            touchNoClick()
            clickPressHandle(false);
        else
           touchNoClick()
           clickPressHandle(false);
        end
    end, cc.MULTI_TOUCHES_ON) 

    return sprite
end



return SpriteButton