--[[
 	SpriteButton
 	public ->> 全局公开类
 	不可重写
 	
 	sprite的按钮
	使用：
	local param = {
		imageName		  = "#ui_pub_zjm_dikuang.png",
		x     = display.left +71,
		y     = display.bottom + 70,
		isPress = false,
		imageParam = {
	    	imageName = "#ui_pub_dikuang.png",
	    	x= 54,
	    	y= 15,
	    },
	    
	    listener =function() 	
--	    		GameUtil.replaceScene("client.view.scene.TestScene")
	    end,
	    txtParam  ={
	    	text  =Language.getValueByKey(505),
	    	size=18,
	    	x = 36,
	    	y = 17,
	    }
	}
	local sptButton = SpriteButton.newButton(param)
     layer:addChild(sptButton);
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local SpriteButton = class("SpriteButton");






--[[
初始化按钮
@param param 参数
 imageName 按钮的图片地址
 txt  按钮上的文字
 isPress 是否可以长按  默认为false
 listener 点击后的回调
 swallows 有这几种方式cc.TOUCH_BEGAN -- stop event dispatching    cc.TOUCH_BEGAN_SWALLOWS --吞噬事件    cc.TOUCH_BEGAN_NO_SWALLOWS -- continue event dispatching
 
 imageParam 比如： {imageName=,x=,y=}
 txtParam 比如：{txt=,x=,y=,size=，color}
]]
function SpriteButton.newButton(param)
	if not param then param = {} end
	local imageName=param.imageName;
	local isPress = param.isPress
	local listener = param.listener;
	local x=param.x;
	local y=param.y;
	local scale = param.scale
	local graylight=param.graylight;
	local swallows = true--or  true--cc.TOUCH_BEGAN;
	
	
	local imageParam = param.imageParam;
	local txtParam = param.txtParam;

	
    local sprite ;
--    if imageName then
    	sprite = display.newSprite(imageName,x,y)
--    else	
--    	sprite = display.newColorLayer(color)
--    end
    local size = sprite:getContentSize();
	
	if scale then sprite:setScale(scale) end
	
	sprite:setCascadeOpacityEnabled(true)
	sprite:setCascadeColorEnabled(true)
	
	
	
	if imageParam then
	 	local imageParam_imageName=imageParam.imageName;
	 	local offsetX=imageParam.offsetX;
	 	local offsetY=imageParam.offsetY;
	 	local imageParam_sprite = display.newSprite(imageParam_imageName,imageParam.x,imageParam.y)
	 	imageParam_sprite:setTag(1000)
	 	sprite:addChild(imageParam_sprite);
	 	
	 	
		if not imageParam.x and not imageParam.y then --默认居中
			imageParam_sprite:setPosition(size.width/2 + checknumber(offsetX),size.height/2 + checknumber(offsetY));
		end
		
		if imageParam.scale and imageParam.scale ~= 1 then --缩放
			imageParam_sprite:setScale(imageParam.scale);
		end
		
		
		if imageParam.flipX then
			imageParam_sprite:setFlipX(true)
			imageParam_sprite:setPosition(size.width*1.5 + checknumber(imageParam.offsetX),size.height/2 + checknumber(imageParam.offsetY));
		end
		if imageParam.flipY then
			imageParam_sprite:setFlipY(true)
			imageParam_sprite:setPosition(size.width*0.5 + checknumber(imageParam.offsetX),-size.height/2 + checknumber(imageParam.offsetY));
		end
	end

	
    if txtParam then
    	txtParam.font = txtParam.font or LABEL_FONT_TTF
        local label = ui.newTTFLabel(txtParam)
        sprite:addChild(label)
        
        
    end
	
	if graylight ~= nil then
		GameUtil.graylightWithSprite(sprite,graylight)
	end
	
	
	--点击效果
	local function touchClick()
		 sprite:setOpacity(128)
	end
	
	
	--没点击的效果
	local function touchNoClick()
		sprite:setOpacity(255)
	end
	
	
	--点击监听回调事件
--	local lastTime = 0;
	local function clickOneceHandle()
--		if not isPress or math.abs(lastTime - os.time()) >4  then
			
--			if listener then 
--				lastTime = os.time();
				if listener then 
					listener()
				end
				
				
				 
--			end
--		end
	end
	
	
	local pressAction = nil;
	local dt_ = 0;
	local function clickPressHandle(flag)
		if flag then 
			if isPress and not pressAction then 
--	       		pressAction = sprite:scheduleUpdate(function(dt)
	       		pressAction = sprite:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
	       			dt_ = dt_ + dt
	       			if dt_ > 0.5 then
	       				clickOneceHandle();
	       				dt_ = 0;
	       			end
	       		end, 3)
	       		sprite:scheduleUpdate();
	       	end
	    else
	    	sprite:unscheduleUpdate();
       	end
	end
	




    sprite:setTouchEnabled(true) -- enable sprite touch
--    sprite:addTouchEventListener(function(event, x, y, prevX, prevY)
--	 int addScriptEventListener(int event, int listener, int tag = 0, int priority = 0);
    sprite:addNodeEventListener( cc.NODE_TOUCH_EVENT,function(event)
    	local x = event.x;
    	local y = event.y;
    	
    	local name = event.name
        if name == "began" then
           touchClick();
           
          clickPressHandle(true);
          
            return true--cc.TOUCH_BEGAN -- stop event dispatching
--            return cc.TOUCH_BEGAN_NO_SWALLOWS -- continue event dispatching
--          return  swallows;
--            return cc.TOUCH_BEGAN -- stop event dispatching
--			return cc.TOUCH_BEGAN_SWALLOWS --吞噬事件
--            return cc.TOUCH_BEGAN_NO_SWALLOWS -- continue event dispatching
        end

        local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
        if name == "moved" then
			if touchInSprite then 
				touchClick();
				clickPressHandle(true);
			else
				touchNoClick();
				clickPressHandle(false);
			end
			
			return cc.TOUCH_MOVED_RELEASE_OTHERS -- stop event dispatching, remove others node
                -- return cc.TOUCH_MOVED_SWALLOWS -- stop event dispatching
        elseif name == "ended" then
        	 sprite:setTouchEnabled(false)
            if touchInSprite then clickOneceHandle() end
            touchNoClick()
            clickPressHandle(false);
            sprite:performWithDelay(function()
					sprite:setTouchEnabled(true)
				end, 0.5)
        else
           touchNoClick()
           clickPressHandle(false);
        end
        
         return  swallows;
    end) 
    

    return sprite
end



return SpriteButton