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
























return GameUtil;