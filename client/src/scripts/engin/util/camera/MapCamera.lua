--[[
 	MapCamera
 	public ->> 全局公开类
 	
	场景的摄像机管理
	使用方法：basescene.lua中
		-- 计算地图位移限定值
	    self.camera_ = MapCamera.new(self)
	    self.camera_:resetOffsetLimit()
		self.camera_:setMargin(0, 0, 0, 0)
]]
local MapCamera = class("MapCamera")

function MapCamera:ctor(map)
    self.map_           = map

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
end






--[[
设置最大缩放比
@param float scale
@return float
]]
function MapCamera:setMaxScale(scale)
    self.maxScale_ = scale
end

--[[
获取最小缩放比
@return float
]]
function MapCamera:getMinScale()
    return self.minScale_
end

--[[
获取最大缩放比
@return float
]]
function MapCamera:getMaxScale()
    return self.maxScale_
end




--[[
返回地图的边空
]]
function MapCamera:getMargin()
    return clone(self.margin_)
end



--[[
获取当前地图的尺寸
@return mapWidth, mapHeight
]]
function MapCamera:getMapSize()
    local mapWidth, mapHeight = self.map_:getSize()
    return mapWidth, mapHeight
end
--function MapCamera:setCenter()
--	local mapWidth, mapHeight = self:getMapSize();
--	self:moveTo(mapWidth* self.scale_ /2,mapHeight* self.scale_ /2)
--	 --self:resetOffsetLimit()
--end





--[[--
设置地图卷动的边空
]]
function MapCamera:setMargin(top, right, bottom, left)
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
function MapCamera:getScale()
    return self.scale_
end



--[[--
设置地图当前的缩放比例
]]
function MapCamera:setScale(scale)
    if self.zooming_ then return end

    self.scale_ = scale
    if scale < self.minScale_ then scale = self.minScale_ end
    self.actualScale_ = scale
    self:resetOffsetLimit()
    self:setOffset(self.offsetX_, self.offsetY_)

    local backgroundLayer = self.map_:getBackgroundLayer()
    local batchLayer      = self.map_:getBatchLayer()
    local flysLayer      = self.map_:getFlysLayer()
    local debugLayer      = self.map_:getDebugLayer()
    local floorsLayer    = self.map_:getFloorsLayer()
    local sceneLayer    = self.map_:getSceneLayer()

	if backgroundLayer then	backgroundLayer:setScale(scale)   end
    if batchLayer then batchLayer:setScale(scale) end
    if flysLayer then flysLayer:setScale(scale) end
    if debugLayer then debugLayer:setScale(scale) end
     if floorsLayer then floorsLayer:setScale(scale) end
      if sceneLayer then sceneLayer:setScale(scale) end
     
end

--[[--

动态调整摄像机的缩放比例

]]
function MapCamera:zoomTo(scale, x, y)
    self.zooming_ = true
    self.scale_ = scale
    if scale < self.minScale_ then scale = self.minScale_ end
    self.actualScale_ = scale
    self:resetOffsetLimit()

    local backgroundLayer = self.map_:getBackgroundLayer()
    local batchLayer      = self.map_:getBatchLayer()
    local flysLayer      = self.map_:getFlysLayer()
    local debugLayer      = self.map_:getDebugLayer()
      local floorsLayer    = self.map_:getFloorsLayer()

    if backgroundLayer then transition.removeAction(self.backgroundLayerAction_) end
    if batchLayer then transition.removeAction(self.batchLayerAction_) end
    if flysLayer then transition.removeAction(self.marksLayerAction_) end
    if debugLayer then transition.stopTarget(debugLayer)  end
     if floorsLayer then transition.stopTarget(floorsLayer)  end
     

  	if backgroundLayer then  self.backgroundLayerAction_ = transition.scaleTo(backgroundLayer, {scale = scale, time = MapConstants.ZOOM_TIME}) end
  	if batchLayer then  self.batchLayerAction_ = transition.scaleTo(batchLayer, {scale = scale, time = MapConstants.ZOOM_TIME})  end
    if flysLayer then  self.marksLayerAction_ = transition.scaleTo(flysLayer, {scale = scale, time = MapConstants.ZOOM_TIME})  end
     if floorsLayer then  self.marksLayerAction_ = transition.scaleTo(floorsLayer, {scale = scale, time = MapConstants.ZOOM_TIME})  end
    if debugLayer then transition.scaleTo(debugLayer, {scale = scale, time = MapConstants.ZOOM_TIME})  end
     

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

    local x, y = display.pixels(x, y)
    self.offsetX_, self.offsetY_ = x, y

    if backgroundLayer then  transition.moveTo(backgroundLayer, {x = x,y = y,time = MapConstants.ZOOM_TIME,onComplete = function() self.zooming_ = false end }) end
    if batchLayer then  transition.moveTo(batchLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME}) end
    if flysLayer then  transition.moveTo(flysLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME}) end
    if floorsLayer then  transition.moveTo(floorsLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})  end
    if debugLayer then  transition.moveTo(debugLayer, {x = x, y = y, time = MapConstants.ZOOM_TIME})  end
end









--[[--

返回地图当前的卷动偏移量

]]
function MapCamera:getOffset()
    return self.offsetX_, self.offsetY_
end

--[[--

设置地图卷动的偏移量

]]
function MapCamera:setOffset(x, y, movingSpeed, onComplete)
    if self.zooming_ then return end


	local backgroundLayer = self.map_:getBackgroundLayer()
    local batchLayer      = self.map_:getBatchLayer()
    local flysLayer      = self.map_:getFlysLayer()
    local debugLayer      = self.map_:getDebugLayer()
    local floorsLayer    = self.map_:getFloorsLayer()

	
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



    local x, y = display.pixels(x, y)
    self.offsetX_, self.offsetY_ = x, y
    
    self:tick()
--    if backgroundLayer then
--        transition.stopTarget(backgroundLayer)
--    end
--    if batchLayer then
--        transition.stopTarget(batchLayer)
--    end
--     if flysLayer then
--        transition.stopTarget(flysLayer)
--    end
--     if floorsLayer then
--        transition.stopTarget(floorsLayer)
--    end
--    if debugLayer then
--        transition.stopTarget(debugLayer)
--    end
--    
--    
--    
--    
--    if type(movingSpeed) == "number" and movingSpeed > 0 then
--        local function moveLayer(oneLayer,callBack)
--        	if oneLayer then 
--		    	 transition.moveTo(oneLayer, {
--		            x = x,
--		            y = y,
--		            time = movingSpeed,
--		            onComplete = callBack
--		        })
--	        end
--	    end
--        
--        moveLayer(backgroundLayer,onComplete)
--        moveLayer(batchLayer)
--        moveLayer(flysLayer)
--        moveLayer(floorsLayer)
--        moveLayer(debugLayer)
--    else
--        if backgroundLayer then  self.map_:getBackgroundLayer():setPosition(x, y) end
--        if batchLayer then  batchLayer:setPosition(x, y) end
--        if flysLayer then flysLayer:setPosition(x, y) end
--        if floorsLayer then floorsLayer:setPosition(x, y) end
--        if debugLayer then debugLayer:setPosition(x, y) end
--    end
end




--[[--

返回地图的卷动限制

]]
function MapCamera:getOffsetLimit()
    return clone(self.offsetLimit_)
end

--[[--

更新地图的卷动限制

]]
function MapCamera:resetOffsetLimit()
    local mapWidth, mapHeight = self.map_:getSize()
    self.offsetLimit_ = {
        minX = display.width - self.margin_.right - mapWidth * self.actualScale_,
        maxX = self.margin_.left,
        minY = display.height - self.margin_.top - mapHeight * self.actualScale_,
        maxY = self.margin_.bottom,
    }
end


--[[--

移动指定的偏移量

]]
function MapCamera:moveOffset(offsetX, offsetY, movingSpeed)
    self:setOffset(self.offsetX_ + offsetX, self.offsetY_ + offsetY, movingSpeed)
end

--[[--
移动到指定的位置
]]
function MapCamera:moveTo(positionX, positionY)
    self:setOffset(positionX, positionY)
end
--[[--
飞行到指定的位置
]]
function MapCamera:flyTo(positionX, positionY,callback)
	if  self.handle_ then
		echoj("[MapCamera] Camera is moving,can not do this operation.");
		return;
	end
	
	--//从数学上看，左移1位等于乘以2，右移1位等于除以2，然后再取整，移位溢出的丢弃。
	--//a<<=1;  //0b00000010 a左移1位等效于a=a*2
	--//a>>=1;  //0b00000010 a左移1位等效于a=a/2
	local halfWidth = math.floor(display.width/2); --display.width>>1
	local halfHeight = math.floor(display.height/2);
    local moveStart = Jpoint(self.offsetX_-(halfWidth),self.offsetY_-(halfHeight));
    local moveEnd = Jpoint(positionX-halfWidth,positionY  - halfHeight );
    
    
    local function listener()
    	local xspeed = (moveEnd("x") - moveStart("x"))/5
    	local yspeed = (moveEnd("y") - moveStart("y"))/5
    	local moveStartX = moveStart("x") + xspeed;
    	local moveStartY = moveStart("y") + yspeed;
    	moveStart = Jpoint(moveStartX,moveStartY);
    	self:setOffset(moveStart());
    	
    	if (xspeed>-0.5 and xspeed<0.5)
    	 and (yspeed>-0.5 and yspeed<0.5) then 
    		scheduler.unscheduleGlobal(self.handle_)
    		self.handle_ = nil;
    		if(callback)then callback(); end
    	end 
    end
    self.handle_ = scheduler.scheduleUpdateGlobal(listener)
    
end







--[[
设置镜头的跟随对象
]]
function MapCamera:setFocus(focusObject)
--	local focusObject = self.map_.sceneController_.model_:getFocusObject()
	self.focusObject_ = focusObject;
end
function MapCamera:getFocusObject()
	return self.focusObject_;
end


--[[
更新
]]
function MapCamera:tick(dt)
	local focusObject = self:getFocusObject();
	if  focusObject then 
		--获取偏离中心点多远
		local _zeroX = focusObject.x_ - math.floor(display.width/2);
		local _zeroY = focusObject.y_ - math.floor(display.height/2);
		
		--宽度计算不能超过最大最小的值
		local width,height = self:getMapSize();
		local value = width - display.width;
		if _zeroX<0 then _zeroX = 0 end
		if _zeroX>value then _zeroX = value  end
		
		--高度计算不能超过最大最小的值
		local value = height - display.height;
		if _zeroY<0 then _zeroY = 0 end
		if _zeroY>value then _zeroY = value  end
		
		self:setOffset(-_zeroX, -_zeroY);
	end
	
	
	
	
	local backgroundLayer = self.map_:getBackgroundLayer()
    local batchLayer      = self.map_:getBatchLayer()
    local flysLayer      = self.map_:getFlysLayer()
    local debugLayer      = self.map_:getDebugLayer()
    local floorsLayer    = self.map_:getFloorsLayer()
	
	
	local x,y = self.offsetX_, self.offsetY_;
	local currentX , currentY = batchLayer:getPosition()
	if x  == currentX and y == currentY then 
		return;
	end
	
	
    if backgroundLayer then
        transition.stopTarget(backgroundLayer)
    end
    if batchLayer then
        transition.stopTarget(batchLayer)
    end
     if flysLayer then
        transition.stopTarget(flysLayer)
    end
     if floorsLayer then
        transition.stopTarget(floorsLayer)
    end
    if debugLayer then
        transition.stopTarget(debugLayer)
    end
	
    if backgroundLayer then backgroundLayer:setPosition(x, y) end
    if batchLayer then  batchLayer:setPosition(x, y) end
    if flysLayer then flysLayer:setPosition(x, y) end
    if floorsLayer then floorsLayer:setPosition(x, y) end
    if debugLayer then debugLayer:setPosition(x, y) end
    
--	self:setOffset(x, y);--, movingSpeed, onComplete)
end


--public function update():void
--		{
--			if(_focus)
--			{
--				_zeroX = _focus.PosX - (Global.W>>1);
--				_zeroY = _focus.PosY - (Global.H>>1);
--				
--				var value:Number = Global.MAPSIZE.x-Global.W;
--				_zeroX = _zeroX<0 ? 0 : _zeroX;
--				_zeroX = _zeroX>value ? value : _zeroX;
--				
--				value = Global.MAPSIZE.y-Global.H;
--				_zeroY = _zeroY<0 ? 0 : _zeroY;
--				_zeroY = _zeroY>value ? value : _zeroY;
--			}
--			
--			_cameraView.x = _zeroX;
--			_cameraView.y = _zeroY;
--			
--			_cameraView.width = Global.W;
--			_cameraView.height = Global.H;
--		}















--[[--

将屏幕坐标转换为地图坐标

]]
function MapCamera:convertToMapPosition(x, y)
    return (x - self.offsetX_) / self.actualScale_, (y - self.offsetY_) / self.actualScale_
end

--[[--

将地图坐标转换为屏幕坐标 

]]
--function MapCamera:convertToWorldPosition(x, y)
--    return x * self.actualScale_ + self.offsetX_, y * self.actualScale_ + self.offsetY_
--end
function MapCamera:convertToScreenPosition(x, y)
    return x * self.actualScale_ + self.offsetX_, y * self.actualScale_ + self.offsetY_
end


--[[--

将指定的地图坐标转换为摄像机坐标
 这个是加上上下左右一个留空的卷轴 

]]
function MapCamera:convertToCameraPosition(x, y)
    local left = -(x - (display.width - self.margin_.left - self.margin_.right) / 2)
    local bottom = -(y - (display.height - self.margin_.top - self.margin_.bottom) / 2)
    return left, bottom
end

return MapCamera
