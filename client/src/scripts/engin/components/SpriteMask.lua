--[[
 	SpriteMask
 	public ->> 全局公开类
 	不可重写
 	
 	创建遮罩的显示sprite
	使用：
	local c = SpriteMask.createMaskByImageName("ui/PinkScale9Block.png","ui/RadioButtonOn.png")
     self:addChild(c);
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local SpriteMask = {}--class("SpriteMask");


--[[
创建遮罩  使用sprite
@param showSpt 显示的图片
@param maskSpt	用来遮罩的片，形状
]]
function SpriteMask.createMaskBySprite(showSpt,maskSpt)
	local size = display.size;
	--创建干净的画板
	local pRt = CCRenderTexture:create(display.width,display.height);
	maskSpt:setPosition(maskSpt:getContentSize().width/2, maskSpt:getContentSize().height/2);
--	showSpt:setPosition(display.width/2,display.height/2);
	
	
	--先设置好 遮罩精灵 和 被遮罩精灵 在被渲染的时候采用什么样的颜色混合法则
	local maskBlend = {GL_ONE, GL_ZERO};
	local flowerBlend = {GL_DST_ALPHA, GL_ZERO};
	 
	local maskBlend = ccBlendFunc()
	maskBlend.src = GL_ONE
	maskBlend.dst = GL_ZERO
	
	 local flowerBlend = ccBlendFunc()
	flowerBlend.src = GL_DST_ALPHA
	flowerBlend.dst = GL_ZERO
	 
	maskSpt:setBlendFunc(maskBlend);
	showSpt:setBlendFunc(flowerBlend); --开始把各种精灵渲染到画板上
	pRt:begin();
	 --先渲染遮罩精灵。但是因为有个画板先被渲染。所以pMask是第二个被渲染的，即后被渲染。
	--所以在这一刻pMask是源颜色。调用pMask->visit()的时候吧精灵pMask上的每个像素的RGBA分量和1.0相乘。
	--所以遮罩图片被元模原样的渲染出来.
	maskSpt:visit();
	 --再渲染被遮罩的精灵.在这一刻,之前先有pMask被渲染。所以pFlower后被渲染。pFlower就是源颜色。之前的pMask就是目标颜色。
	  --调用pFlower->visit()的时候,精灵pFlower上的对应像素的RGBA分量和pMask上的对应像素的A分量相乘.因为前面设置了GL_DST_ALPHA。
	showSpt:visit();
	 --停止渲染到画板
	pRt:endToLua()
	
	
	return pRt
end





--[[
创建遮罩  使用 imageName
@param showImageName 显示的图片
@param maskImageName	用来遮罩的片，形状
]]
function SpriteMask:createMaskByImageName(showImageName,maskImageName)
	local showSpt,maskSpt = display.newSprite(showImageName),display.newSprite(maskImageName);
	local pRt = SpriteMask.createMaskBySprite(showSpt,maskSpt)
	return pRt
end


return SpriteMask