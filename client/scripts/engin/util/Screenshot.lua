local Screenshot = {};








--[[
截图功能
@param string filename 文件名
@return bool 返回是否截图成功
]]
function GameUtil.screenshotByFullScreen(filename)
    local texture = CCRenderTexture:create(display.width,display.height)
    texture:setPosition(ccp(display.cx, display.cy))
    texture:begin()
    display.getRunningScene():visit()
    texture:endToLua()
    return texture:saveToFile(filename)
end





--[[
保存sprite的图片
]]
function Screenshot.screenshotBySprite(mySprite,filename,w,h)
	-- mySprite
	if not w then 
 		w = mySprite:getContentSize().width
		h = mySprite:getContentSize().height
	end
	
	local toSaveTexture = CCRenderTexture:create(w, h)
	toSaveTexture:begin()
	mySprite:visit()
	toSaveTexture:endToLua()
	
	--local path = CCFileUtils:sharedFileUtils():getWritablePath() .. "/" .. "mySprite.png"
	--toSaveTexture:saveToFile(path, kCCImageFormatPNG)
	return toSaveTexture:saveToFile(filename,kCCImageFormatPNG)
end












return Screenshot;