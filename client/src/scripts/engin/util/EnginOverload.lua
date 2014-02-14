


--获取display的真实的像素
function display.pixels(x, y)
	local round = math.round
    local scale = 1 / display.contentScaleFactor
    if x then x = round(x / scale) * scale end
    if y then y = round(y / scale) * scale end
    return x, y
end



--获取某图像的贴图 ，位于plist上，可传入#或者不传入
function display.newSpriteFrameByFileName(filename)
	 local t = type(filename)
    if t == "userdata" then t = tolua.type(filename) end
    
	local currentTexture;
    if not filename then
        currentTexture = display.newSpriteFrame("empty.png");
    elseif t == "string" then
        if string.byte(filename) == 35 then -- first char is #
           currentTexture = display.newSpriteFrame(string.sub(filename, 2))
        else
           currentTexture = display.newSpriteFrame(filename)
        end
    elseif t == "CCSpriteFrame" then
        currentTexture = filename
    else
        echoError("display.newSprite() - invalid filename value type")
    end


    return currentTexture
end






--[[
获取贴图
]]
function display.addSpriteFramesWithFileListName(plistFileName,format,imageName)
	if plistFileName then 
		if format then
			display.setTexturePixelFormat(plistFileName, format)
		end
		
		display.addSpriteFramesWithFile(plistFileName, imageName)
	end
end

