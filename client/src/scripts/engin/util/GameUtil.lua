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






--[[
截图功能
@param string filename 文件名
@return bool 返回是否截图成功
]]
function GameUtil.screenshot(filename)
    local texture = CCRenderTexture:create(display.width,display.height)
    texture:setPosition(ccp(display.cx, display.cy))
    texture:begin()
    display.getRunningScene():visit()
    texture:endToLua()
    return texture:saveToFile(filename)
end















return GameUtil;