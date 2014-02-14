--[[
 	FilterText
 	public ->> 全局公开类
 	不可重写
 	
	滤镜文字
	使用：
	-- 文本、图片一样，这里用文本举个例子
	local filterLabel = ui.newTTFLabel({
	        text = "测试滤镜",
	        color = display.COLOR_RED,
	        size = 60,
	        align = ui.TEXT_ALIGN_CENTER,
	        x = display.cx,
	        y = display.cy + 150
	    })
	
	local  renderTexture =  FilterText:createStroke(quickLabel, 4, ccc3(0xca, 0xa5, 0x5f), 100)
	-- 设置反锯齿
	renderTexture:getSprite():getTexture():setAntiAliasTexParameters()
	self:addChild(renderTexture, filterLabel:getZOrder()-1)
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local FilterText = class("FilterText");




--[[
创建滤镜文字
 @param:node 欲描边的显示对象
 @param:strokeWidth 描边宽度
 @param:color 描边颜色
 @param:opacity 描边透明度
]]
function FilterText:createStroke(node, strokeWidth, color, opacity,x,y,size)
    local w = node:getTexture():getContentSize().width + strokeWidth * 2
    local h = node:getTexture():getContentSize().height + strokeWidth * 2
    local rt = CCRenderTexture:create(w, h)

    -- 记录原始位置
    local originX, originY = node:getPosition()
    -- 记录原始颜色RGB信息
    local originColorR = node:getColor().r
    local originColorG = node:getColor().g
    local originColorB = node:getColor().b
    -- 记录原始透明度信息
    local originOpacity = node:getOpacity()
    -- 记录原始是否显示
    local originVisibility = node:isVisible()
    -- 记录原始混合模式
    local originBlend = node:getBlendFunc()

    -- 设置颜色、透明度、显示
    node:setColor(color)
    node:setOpacity(opacity)
    node:setVisible(true)
    if size then
    	node:setScale(size)
    end
    -- 设置新的混合模式
    local blendFuc = ccBlendFunc:new()
    blendFuc.src = GL_SRC_ALPHA
    blendFuc.dst = GL_ONE
    -- blendFuc.dst = GL_ONE_MINUS_SRC_COLOR
    node:setBlendFunc(blendFuc)

    -- 这里考虑到锚点的位置，如果锚点刚好在中心处，代码可能会更好理解点
    local bottomLeftX = node:getTexture():getContentSize().width * node:getAnchorPoint().x + strokeWidth 
    local bottomLeftY = node:getTexture():getContentSize().height * node:getAnchorPoint().y + strokeWidth

    local positionOffsetX = node:getTexture():getContentSize().width * node:getAnchorPoint().x - node:getTexture():getContentSize().width / 2
    local positionOffsetY = node:getTexture():getContentSize().height * node:getAnchorPoint().y - node:getTexture():getContentSize().height / 2

    local rtPosition = ccp(originX - positionOffsetX, originY - positionOffsetY)

    rt:begin()
    -- 步进值这里为10，不同的步进值描边的精细度也不同
    for i = 0, 360, 10 do
        -- 这里解释了为什么要保存原来的初始信息
        node:setPosition(ccp(bottomLeftX +x + math.sin(Math2d.degrees2radians(i)) * strokeWidth, bottomLeftY-y + math.cos(Math2d.degrees2radians(i)) * strokeWidth))
        node:visit()
    end
    rt:endToLua()

    -- 恢复原状
    node:setPosition(originX, originY)
    node:setColor(ccc3(originColorR, originColorG, originColorB))
    node:setBlendFunc(originBlend)
    node:setVisible(originVisibility)
    node:setOpacity(originOpacity)
	if size then
    	node:setScale(size)
    end
	
    rt:setPosition(rtPosition)

    return rt
end


return FilterText
