local GameUtil = {};


--[[
 设置sprite全屏显示
@param sprite 此sprite的图片大小最好是960*720
]]
function GameUtil.spriteFullScreen(sprite)
	local size=sprite:getContentSize();
	local screenSize=display.size;
	local scalX=screenSize.width/size.width;
	local scalY=screenSize.height/size.height;
	sprite:setScaleX(scalX);
	sprite:setScaleY(scalY);
end







--添加背景的局部函数
function GameUtil.addBackgroundImage(currentParent,currentImageName)
	if currentImageName then 
		CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGB565)
	    local sprite = display.newSprite(currentImageName)
	    CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
	    local function backGroundSpriteHandle(event)
	    	if event.name == "exit" then
	            display.removeSpriteFrameByImageName(currentImageName)
	        end
	    end
		sprite:addNodeEventListener(cc.NODE_EVENT,backGroundSpriteHandle)-- 地图对象删除时，自动从缓存里卸载地图材质
	    
	    --[[
	    if width then self.backgroundSprite_:setContentSize(CCSize(width,height)); end
		local contentSize=sprite:getContentSize();
		if not width then
			width = contentSize.width;
			height= contentSize.height;
		end
		]]
		
		sprite:align(display.LEFT_BOTTOM, 0, 0)
	    currentParent:addChild(sprite)
	   
	    return sprite;
    end
end











return GameUtil;