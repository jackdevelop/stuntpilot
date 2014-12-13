local SceneMapCamera = class("SceneMapCamera")

function SceneMapCamera:ctor(map)
    self.map_           = map

	self.parallaxScale_ = self.map_.parallaxScale_ or 0.5 --中景移动的频率比
    self.zooming_       = false
    self.scale_         = 1
    self.actualScale_   = 1
    self.offsetX_       = 0
    self.offsetY_       = 0
    self.offsetLimit_   = nil --地图的卷动限制
    self.margin_        = {top = 0, right = 0, bottom = 0, left = 0} --地图的边空


	--最小  最大放大倍数
    local width, height = map:getSize() --地图的尺寸
    local minScaleV     = display.height / height
    local minScaleH     = display.width / width

	local minScale      = minScaleV
    if minScaleH > minScale then minScale = minScaleH end
    self.minScale_ = minScale
    self.maxScale_ = 99 --最大默认为99
    
    
    self.parallaxLayer_in_ = self.map_:getParallaxLayer_in() --中景
    self.backgroundLayer_ = self.map_:getBackgroundLayer() --近景
    self.floorsLayer_    = self.map_:getFloorsLayer()
    self.batchLayer_       = self.map_:getBatchLayer()
    self.flysLayer_      = self.map_:getFlysLayer()
    self.debugLayer_      = self.map_:getDebugLayer()
end





--[[
设置最大缩放比
@param float scale
@return float
]]
function SceneMapCamera:setMaxScale(scale)
    self.maxScale_ = scale
end

--[[
获取最小缩放比
@return float
]]
function SceneMapCamera:getMinScale()
    return self.minScale_
end

--[[
获取最大缩放比
@return float
]]
function SceneMapCamera:getMaxScale()
    return self.maxScale_
end


--[[--

返回地图的边空

]]
function SceneMapCamera:getMargin()
    return clone(self.margin_)
end

--[[--

设置地图卷动的边空

]]
function SceneMapCamera:setMargin(top, right, bottom, left)
    if self.zooming_ then return end

    if type(top)    == "number" then self.margin_.top = top end
    if type(right)  == "number" then self.margin_.right = right end
    if type(bottom) == "number" then self.margin_.bottom = bottom end
    if type(left)   == "number" then self.margin_.left = left end
    self:resetOffsetLimit()
end

--[[--

返回地图当前的缩放比例

]]
function SceneMapCamera:getScale()
    return self.scale_
end

--[[--

设置地图当前的缩放比例

]]
function SceneMapCamera:setScale(scale)
    if self.zooming_ then return end

    self.scale_ = scale
    if scale < self.minScale_ then scale = self.minScale_ end
    self.actualScale_ = scale
    self:resetOffsetLimit()
    self:setOffset(self.offsetX_, self.offsetY_)

	local parallaxLayer_in_ = self.parallaxLayer_in_
    local backgroundLayer = self.backgroundLayer_
    local floorsLayer = self.floorsLayer_
    local batchLayer      =  self.batchLayer_
    local flysLayer      = self.flysLayer_ 
    local debugLayer      =  self.debugLayer_

	parallaxLayer_in_:setScale(scale)
    backgroundLayer:setScale(scale)
    floorsLayer:setScale(scale)
    batchLayer:setScale(scale)
    flysLayer:setScale(scale)
    if debugLayer then debugLayer:setScale(scale) end
end

--[[--

动态调整摄像机的缩放比例

]]
function SceneMapCamera:zoomTo(scale, x, y)
    self.zooming_ = true
    self.scale_ = scale
    if scale < self.minScale_ then scale = self.minScale_ end
    self.actualScale_ = scale
    self:resetOffsetLimit()

    
	local parallaxLayer_in_ = self.parallaxLayer_in_
    local backgroundLayer = self.backgroundLayer_
    local floorsLayer = self.floorsLayer_
    local batchLayer      =  self.batchLayer_
    local flysLayer      = self.flysLayer_ 
    local debugLayer      =  self.debugLayer_

	transition.removeAction(self.parallaxLayer_in_Action_)
    transition.removeAction(self.backgroundLayerAction_)
    transition.removeAction(self.floorsLayerAction_)
    transition.removeAction(self.batchLayerAction_)
    transition.removeAction(self.flysLayerAction_)
    if debugLayer then
        transition.stopTarget(debugLayer)
    end

	self.parallaxLayer_in_Action_ = transition.scaleTo(parallaxLayer_in_, {scale = scale, time = MapConstants.ZOOM_TIME})
    self.backgroundLayerAction_ = transition.scaleTo(backgroundLayer, {scale = scale, time = MapConstants.ZOOM_TIME})
    self.floorsLayerAction_ = transition.scaleTo(floorsLayer, {scale = scale, time = MapConstants.ZOOM_TIME})
    self.batchLayerAction_ = transition.scaleTo(batchLayer, {scale = scale, time = MapConstants.ZOOM_TIME})
    self.flysLayerAction_ = transition.scaleTo(flysLayer, {scale = scale, time = MapConstants.ZOOM_TIME})
    if debugLayer then
        transition.scaleTo(debugLayer, {scale = scale, time = MapConstants.ZOOM_TIME})
    end

    if type(x) ~= "number" then return end

    if x < self.offsetLimit_.minX then
        x = self.offsetLimit_.minX
    end
    if x > self.offsetLimit_.maxX then
        x = self.offsetLimit_.maxX
    end
    if y < self.offsetLimit_.minY then
        y = self.offsetLimit_.minY
    end
    if y > self.offsetLimit_.maxY then
        y = self.offsetLimit_.maxY
    end

--    local x, y = display.pixels(x, y)
    self.offsetX_, self.offsetY_ = x, y



	
	transition.moveTo(parallaxLayer_in_, {x = x*self.parallaxScale_ , y = y*self.parallaxScale_ , time = MapConstants.ZOOM_TIME})
    transition.moveTo(backgroundLayer, {
        x = x,
        y = y,
        time = MapConstants.ZOOM_TIME,
        onComplete = function()
            self.zooming_ = false
        end
    })
    transition.moveTo(floorsLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})
    transition.moveTo(batchLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})
    transition.moveTo(flysLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})
    if debugLayer then
        transition.moveTo(debugLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})
    end
end

--[[--

返回地图当前的卷动偏移量

]]
function SceneMapCamera:getOffset()
    return self.offsetX_, self.offsetY_
end

--[[--

设置地图卷动的偏移量

]]
function SceneMapCamera:setOffset(x, y, movingSpeed, onComplete)
    if self.zooming_ then return end

    if x < self.offsetLimit_.minX then
        x = self.offsetLimit_.minX
    end
    if x > self.offsetLimit_.maxX then
        x = self.offsetLimit_.maxX
    end
    if y < self.offsetLimit_.minY then
        y = self.offsetLimit_.minY
    end
    if y > self.offsetLimit_.maxY then
        y = self.offsetLimit_.maxY
    end
	
--    local x, y = display.pixels(x, y)
    self.offsetX_, self.offsetY_ = x, y

	
	
	local parallaxLayer_in_ = self.parallaxLayer_in_
	local backgroundLayer = self.backgroundLayer_
    local floorsLayer = self.floorsLayer_
    local batchLayer      =  self.batchLayer_
    local flysLayer      = self.flysLayer_ 
    local debugLayer      =  self.debugLayer_
    
    

    if type(movingSpeed) == "number" and movingSpeed > 0 then
    	transition.stopTarget(parallaxLayer_in_)
        transition.stopTarget(backgroundLayer)
        transition.stopTarget(floorsLayer)
        transition.stopTarget(batchLayer)
        transition.stopTarget(flysLayer)
        if debugLayer then
            transition.stopTarget(debugLayer)
        end

        local cx, cy = backgroundLayer:getPosition()
        local mtx = cx / movingSpeed
        local mty = cy / movingSpeed
        local movingTime
        if mtx > mty then
            movingTime = mtx
        else
            movingTime = mty
        end


		transition.moveTo(parallaxLayer_in_, {x*self.parallaxScale_ , y*self.parallaxScale_ , time = movingTime})
        transition.moveTo(backgroundLayer, {
            x = x,
            y = y,
            time = movingTime,
            onComplete = onComplete
        })
        transition.moveTo(floorsLayer, {x = x, y = y, time = movingTime})
        transition.moveTo(batchLayer, {x = x, y = y, time = movingTime})
        transition.moveTo(flysLayer, {x = x, y = y, time = movingTime})
        if debugLayer then
            transition.moveTo(debugLayer, {x = x, y = y, time = movingTime})
        end
    else
--        x, y = display.pixels(x, y)
        parallaxLayer_in_:setPosition(x*self.parallaxScale_ , y*self.parallaxScale_ )
        backgroundLayer:setPosition(x, y)
        floorsLayer:setPosition(x, y)
        batchLayer:setPosition(x, y)
        flysLayer:setPosition(x, y)
        if debugLayer then debugLayer:setPosition(x, y) end
    end
end

--[[--

移动指定的偏移量

]]
function SceneMapCamera:moveOffset(offsetX, offsetY)
    self:setOffset(self.offsetX_ + offsetX, self.offsetY_ + offsetY)
end

--[[--

返回地图的卷动限制

]]
function SceneMapCamera:getOffsetLimit()
    return clone(self.offsetLimit_)
end

--[[--

更新地图的卷动限制

]]
function SceneMapCamera:resetOffsetLimit()
    local mapWidth, mapHeight = self.map_:getSize()
    self.offsetLimit_ = {
        minX = display.width - self.margin_.right - mapWidth * self.actualScale_,
        maxX = self.margin_.left,
        minY = display.height - self.margin_.top - mapHeight * self.actualScale_,
        maxY = self.margin_.bottom,
    }
end













--[[--

将屏幕坐标转换为地图坐标

]]
function SceneMapCamera:convertToMapPosition(x, y)
    return (x - self.offsetX_) / self.actualScale_, (y - self.offsetY_) / self.actualScale_
end

--[[--

将地图坐标转换为屏幕坐标 

]]
--function SceneMapCamera:convertToWorldPosition(x, y)
--    return x * self.actualScale_ + self.offsetX_, y * self.actualScale_ + self.offsetY_
--end
function SceneMapCamera:convertToScreenPosition(x, y)
    return x * self.actualScale_ + self.offsetX_, y * self.actualScale_ + self.offsetY_
end


--[[--

将指定的地图坐标转换为摄像机坐标
 这个是加上上下左右一个留空的卷轴 

]]
function SceneMapCamera:convertToCameraPosition(x, y)
    local left = -(x - (display.width - self.margin_.left - self.margin_.right) / 2)
    local bottom = -(y - (display.height - self.margin_.top - self.margin_.bottom) / 2)
    return left, bottom
end


return SceneMapCamera
