--[[
 	BaseScene
 	private ->> 全局不公开类，调用时需要import
 	
	游戏的场景基类
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local MapCamera = require("engin.util.camera.MapCamera")

local BaseScene = class("BaseScene", function()
    return display.newScene("BaseScene")
end)




--[[
BaseScene的构造函数
 backgroundImageName 背景地图
 touchMode 0不支持触摸,1单点触摸，2多点触摸
 width 当前场景的宽度      为nil时  自动读取背景地图的宽度
 height 当前场景的高度     为nil时  自动读取背景地图的宽度
 backgroundMusicArr 背景音乐，是个table{},默认只播放第table的第一个   但 退出table的所有都dou会自动释放并卸载
]]
function BaseScene:ctor(param)
	if not param then param = {} end
	local backgroundImageName = param.backgroundImageName;--近景的背景图片
	local parallaxImageName = param.parallaxImageName;--远景的图片
	local width = param.width;
	local height = param.height;
	local sceneName = param.sceneName;
	local touchMode =param.touchMode;
	local batchNodeImage = param.batchNodeImage;
	 
	self.sceneSound_ = param.sceneSound --当前场景的声音
	self.currentSceneName_ = sceneName;--场景名称
	self.touchMode_=touchMode;--触摸flag   多点 cc.TOUCH_MODE_ALL_AT_ONCE               cc.TOUCH_MODE_ONE_BY_ONE 单点触摸


	--播放场景的背景音乐
	if self.sceneSound_ then
		audio.playMusic(self.sceneSound_);
	end
	
	
	
	--添加背景的局部函数
	local function addImage(currentParent,currentImageName)
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
	
		
	
	-- mapLayer 包含地图的整个视图
    self.mapLayer = display.newNode()
    self.mapLayer:align(display.LEFT_BOTTOM, 0, 0)
    self:addChild(self.mapLayer)

	
	
	--远景  中景  不可移动的层 可以加到这一层 
	self.parallaxLayer_ = display.newNode(); 
	self.mapLayer:addChild(self.parallaxLayer_); 
	local spt = addImage(self.parallaxLayer_,parallaxImageName);
	GameUtil.spriteFullScreen(spt)
	 

	
	--背景
	self.backgroundLayer_ = display.newNode();
	self.mapLayer:addChild(self.backgroundLayer_); 
    
    
    
    --设置当前尺寸
	self.width_=width or display.width;
	self.height_=height or display.height;
	
	
	
	
	
    self.touchLayer_ = display.newLayer()
    self.mapLayer:addChild(self.touchLayer_)-- touchLayer 用于接收触摸事
    
	
   
    self.floorsLayer_=display.newNode()
    self.mapLayer:addChild(self.floorsLayer_)--底层 
    
    
   
	if batchNodeImage then
    	self.batch_ = display.newBatchNode(batchNodeImage)
    else
    	self.batch_=display.newNode()
    end
    self.mapLayer:addChild(self.batch_)--渲染层
    
    
    
    self.flysLayer_ = display.newNode() --飞行层
	self.mapLayer:addChild(self.flysLayer_)
    
    
    
    
--    if DEBUG ~= 0 then
--		if not self.debugLayer_ then 
--			self.debugLayer_=display.newNode()-- .newLayer();
--		end
--    end
--  self.mapLayer:addChild(debug);
    
    
--      self.uiLayer_ = display.newBatchNode(batchNodeImage)
    self.uiLayer_ = display.newLayer();
    self.mapLayer:addChild(self.uiLayer_);--ui层
    
    
    
    self.loadingLayer_=display.newNode()
   	self.mapLayer:addChild(self.loadingLayer_);--loading层
    
    
    self.tipLayer_=display.newNode();
   	self.mapLayer:addChild(self.tipLayer_);--tip层
	
	
	
	-- 计算地图位移限定值
    self.camera_ = MapCamera.new(self)
    self.camera_:resetOffsetLimit()
	self.camera_:setMargin(0, 0, 0, 0)
	
	

	--地图移动的数据保存
	self.pointArr_ = {}
end










            

--[[--
返回地图的底层 》》俗称地板层
]]
function BaseScene:getFloorsLayer()
    return self.floorsLayer_
end

--[[--
返回地图的批量渲染层 》》俗称中间层
]]
function BaseScene:getBatchLayer()
    return self.batch_
end

--[[--
返回用于显示地图最上层 》》 俗称飞行层
]]
function BaseScene:getFlysLayer()
    return self.flysLayer_
end


--[[-
返回于地图的ui层
]]
function BaseScene:getUILayer()
    return self.uiLayer_
end


--[[--
返回于地图的触摸层
]]
function BaseScene:getTouchLayer()
    return self.touchLayer_
end


--[[--
返回于地图的loading层
]]
function BaseScene:getLoadingLayer()
    return self.loadingLayer_
end

--[[--
返回于tips层
]]
function BaseScene:getTipLayer()
    return self.tipLayer_
end


--[[--
返回背景图
]]
function BaseScene:getBackgroundLayer()
    return self.backgroundLayer_
end


--[[--
debug层
]]
function BaseScene:getDebugLayer()
    return self.debugLayer_;
end


--[[--
通过制定的layerName获取层
]]
function BaseScene:getLayerBySceneLayerName(parentLayerName)
	local currentLayer ;
	
	if parentLayerName == SceneConstants.FLOORS_LAYER then --地板层
		currentLayer = self:getFloorsLayer()
	elseif parentLayerName == SceneConstants.FLY_LAYER then --飞行层
		currentLayer = self:getFlysLayer()
	elseif parentLayerName == SceneConstants.TOUCH_LAYER then --触摸层
		currentLayer = self:getTouchLayer()
	elseif parentLayerName == SceneConstants.UI_LAYER then --ui层
		currentLayer = self:getUILayer()
	elseif parentLayerName == SceneConstants.LOADING_LAYER then --地图的loading层
		currentLayer = self:getLoadingLayer()
	elseif parentLayerName == SceneConstants.TIP_LAYER then --tips层
		currentLayer = self:getTipLayer()
	else
		currentLayer = self:getBatchLayer()
	end
	return currentLayer;
end









--[[--
场景放大缩小
@param float delta
]]
function BaseScene:zoom(delta)
    local scale1 = self:getCamera():getScale()
    local scale2 = math.min(8.0, math.max(0.46, scale1 * (1 + delta)))
    self:getCamera():setScale(scale2)
    local posX, posY = self:getCamera():getOffset()
    local newPosX = display.cx - (display.cx - posX) / scale1 * scale2
    local newPosY = display.cy - (display.cy - posY) / scale1 * scale2
    self:getCamera():moveOffset(newPosX - posX, newPosY - posY)
end










--[[--
返回地图尺寸
]]
function BaseScene:getSize()
	return self.width_, self.height_
end

--[[--
返回摄像机对象
]]
function BaseScene:getCamera()
    return self.camera_
end




















-- event.name 是触摸事件的状态：began, moved, ended, cancelled
        -- event.x, event.y 是触摸点当前位置
        -- event.prevX, event.prevY 是触摸点之前的位置
--function BaseScene:onTouch(event, x, y)
--
--
--end
--[[--
	触摸事件 
]]
function BaseScene:onTouch(event, x, y)
	if event == "began" then
		self.drag = {
			startX  = x,
			startY  = y,
			lastX   = x,
			lastY   = y,
			offsetX = 0,
			offsetY = 0,
			moveOffsetX  = 0,
			moveOffsetY  = 0,
            time = 0,
		}
		self:touchBegan(event,x,y);
		return true
        -- return cc.TOUCH_BEGAN_NO_SWALLOWS
	elseif event == "moved" then
		if self.drag then
			self.drag.offsetX = x - self.drag.lastX
			self.drag.offsetY = y - self.drag.lastY
			self.drag.lastX = x
			self.drag.lastY = y
            local canMove = (not self.touchBuildView) or (self.touchBuildView and (not self.touchBuildView:isMoveAble()))
			if canMove and Math2d.dist(self.drag.lastX, self.drag.lastY, self.drag.startX, self.drag.startY) >= 4 then
				self.drag.moved = true -- 设置移动中标志
				self:getCamera():moveOffset(self.drag.offsetX, self.drag.offsetY)
			end
		end
		self:touchMoved(event,x,y);
        return true
        -- return cc.TOUCH_MOVED_RELEASE_OTHERS
	else
        if self.drag and self.drag.moved then
            local offsetX = self.drag.lastX - self.drag.startX
            local offsetY = self.drag.lastY - self.drag.startY
            local s = Math2d.dist(self.drag.lastX, self.drag.lastY, self.drag.startX, self.drag.startY)
            if s > 10 and offsetX ~= 0 and offsetY ~= 0 and self.drag.time >= 0.000000001 then
                local v = s / self.drag.time -- 滑动速度(假定是匀速滑动,v = s / t)
                local t = 0.75 -- 匀减速滑动时间(可调整)
                local a = v / t -- 匀减速的加速度(vt = v0 - a * t, vt = 0)
                -- local s2 = v * t - 0.5 * a * t * t -- 匀减速滑动距离(s = v0 * t - 1 / 2 * a * t ^ 2)
                self.tween = {
                    s = s,
                    v = v,
                    t = t,
                    a = a,
                    offsetX = offsetX,
                    offsetY = offsetY,
                    lastOffsetX = offsetX,
                    lastOffsetY = offsetY,
                    time = 0,
                }
            end
        end
		self:touchCancle(event,x,y);
		self.drag = nil
	end
end

--[[
多点触摸处理
@param string event began/moved/ended/cancelled
@param array points 形如:{point0, point1, ..., pointN}

其中每一个触摸点的值包含：
point.x, point.y 触摸点的当前位置
point.prevX, point.prevY 触摸点之前的位置
point.id 触摸点 id，用于确定触摸点的变化
]]
function BaseScene:multiTouchHandle(event, points)
    if event == "began" then -- 立即取消缓动特效
        self.tween = nil
    end
    local pointArr = {}
    for k, v in pairs(points) do
        if v.id - 2 <= 0 then
            pointArr[v.id] = {x = v.x, y = v.y}
            self.pointArr_[v.id] = {x = v.x, y = v.y}
        end
    end
    local touchPointNum = table.nums(self.pointArr_)
    if touchPointNum == 1 and points["0"] then -- 只按下了一个触点时
        return self:onTouch(event, points["0"].x, points["0"].y)
    elseif not self.multiTouch_ then
        self.pointArr_ = {}
        return
    end

    if event == "began" then
        if self.drag then -- 多点的时候，强制取消拖动
            self:touchCancle(event, self.pointArr_["0"].x, self.pointArr_["0"].y);
            self.drag = nil
        end
        if self.pointArr_["0"] and self.pointArr_["1"] and pointArr["1"] then
            local p1, p2 = self.pointArr_["0"], self.pointArr_["1"]
            local dist = Math2d.dist(p1.x, p1.y, p2.x, p2.y) -- 两触点间的距离
            local midScreenX, midScreenY = (p1.x + p2.x) / 2, (p1.y + p2.y) / 2
            self.lastZoomInfo_ = { -- 保存起来
                mid = {x = midScreenX, y = midScreenY},
                dist = dist,
                startDist = dist, -- 起始间距
            };
        end
        
        self:multiTouchBegan(event);
    elseif event == "moved" then
        if self.multiTouch_ and self.pointArr_["0"] and self.pointArr_["1"] then -- 缩放时只取前两个触点（需开启多点触摸）
            local p1, p2 = self.pointArr_["0"], self.pointArr_["1"]
            local dist = Math2d.dist(p1.x, p1.y, p2.x, p2.y) -- 两触点间的距离
            local lastDist, lastMid
            if self.lastZoomInfo_ then
                lastDist = self.lastZoomInfo_.dist
                lastMid = self.lastZoomInfo_.mid
            end
            
            local midScreenX, midScreenY = (p1.x + p2.x) / 2, (p1.y + p2.y) / 2
            self.lastZoomInfo_ = { -- 保存起来
                mid = {x = midScreenX, y = midScreenY},
                dist = dist,
            };
            if self.lastZoomInfo_.startDist == nil then
               self.lastZoomInfo_.startDist = dist
            end
            
            if lastDist then
                local scale1 = self:getCamera():getScale()
                local minScale = self:getCamera():getMinScale()
                local maxScale = self:getCamera():getMaxScale()
                local scale2 = math.min(maxScale, math.max(minScale, scale1 * (dist / lastDist)))
                self:getCamera():setScale(scale2)
                local posX, posY = self:getCamera():getOffset()
                local newPosX = lastMid.x - (lastMid.x - posX) / scale1 * scale2
                local newPosY = lastMid.y - (lastMid.y - posY) / scale1 * scale2
                self:getCamera():moveOffset(newPosX - posX, newPosY - posY)
            end
        end
        
    else
        if pointArr["0"] or pointArr["1"] then -- 0/1任意一个触点ended/cancelled的，便取消缩放
            self.lastZoomInfo_ = nil
            self.pointArr_ = {}
        end
    end
end






function BaseScene:multiTouchBegan(event)
end
function BaseScene:touchBegan(event, x, y)
end
function BaseScene:touchMoved(event, x, y)
end
function BaseScene:touchCancle(event, x, y)
end









--[[--
tick帧更新事件
]]
function BaseScene:tick(dt)
    if self.drag then
        self.drag.time = self.drag.time + dt
    end
    if self.tween then -- 滑动缓动效果处理
        self.tween.time = self.tween.time + dt
        local t2 = math.min(self.tween.t, self.tween.time)
        local t = self.tween
        local s2 = t.v * t2 - 0.5 * t.a * t2 * t2
        local scale = (t.s + s2) / t.s
        local offsetX = t.offsetX * scale
        local offsetY = t.offsetY * scale
        local deltaX = offsetX - self.tween.lastOffsetX
        local deltaY = offsetY - self.tween.lastOffsetY
        self:getCamera():moveOffset(deltaX, deltaY)
        if self.tween.time >= self.tween.t then
            self.tween = nil
        else
            self.tween.lastOffsetX = offsetX
            self.tween.lastOffsetY = offsetY
        end
    end
end







--[[--
进入场景
]]
function BaseScene:onEnter()
    if self.touchLayer_ then
        -- @see https://github.com/chukong/quick-cocos2d-x/blob/develop/docs/UPGRADE_TO_2_2_3.md
        self.touchLayer_:addNodeEventListener(
            cc.NODE_TOUCH_EVENT,
            function(event)
                return self:multiTouchHandle(event.name, event.points)
            end
        )
        -- 如果当前 node 响应了触摸，是否吞噬触摸事件（阻止事件继续传递）
        self.touchLayer_:setTouchSwallowEnabled(false)
      	self.touchLayer_:setTouchMode(self.touchMode_ or cc.TOUCH_MODE_ONE_BY_ONE) -- 多点 cc.TOUCH_MODE_ALL_AT_ONCE cc.TOUCH_MODE_ONE_BY_ONE 单点触摸
        self.touchLayer_:setTouchEnabled(true)
    end 

--     --分发进入场景事件
--    local flowData = FlowData.new(GameFlowConstants.ENTER_SCENE,{sceneName = self.sceneName_,scene=self});
--    GameFlow:push(flowData);
    
    
    

    --因为加载资源是从tick中加载的   所以延迟几秒  
    self:performWithDelay(function()
        self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
           self:tick(dt)
        end)
        self:scheduleUpdate()
    end, 1.5)
end







--[[--
	退出
]]
function BaseScene:onExit()
end



--[[--
场景销毁
]]
function BaseScene:onCleanup()
	self:unscheduleUpdate();
	self.uiLayer_ = nil;

--	--释放背景音乐
--	if self.backgroundMusicArr_ then 
--		for k, v in paris(self.backgroundMusicArr_) do
--			audio.stopBackgroundMusic(v);
--			--audio.stopBackgroundMusic();
--			audio.unloadSound(v);
--		end
--	end
	
	
--	if device.platform ~= "windows" then
--        self:removeAllChildren()
		display.removeUnusedSpriteFrames()
		collectgarbage("collect")
		collectgarbage("collect")
		
--		CCSpriteFrameCache:sharedSpriteFrameCache():removeSpriteFrames()
--     	CCTextureCache:sharedTextureCache():removeAllTextures()
		
		
--	end
--	CCActionManager:sharedManager():removeAllActions();--强制停止动画
--	CCTextureCache:sharedTextureCache():removeAllTextures() --释放以前的资源
	CCLabelBMFont:purgeCachedData();--释放位图字体
	
	
	
	
--	如果游戏有很多场景，在切换场景的时候可以把前一个场景的内存全部释放，防止总内存过高.
--	CCTextureCache::sharedTextureCache()->removeAllTextures(); 释放到目前为止所有加载的图片
--	CCTextureCache::sharedTextureCache()->removeUnusedTextures(); 将引用计数为1的图片释放掉CCTextureCache::sharedTextureCache()->removeTexture(); 单独释放某个图片
--	CCSpriteFrameCache 与 CCTextureCache 释放的方法差不多。
--	值得注意的是释放的时机，一般在切换场景的时候释放资源，如果从A场景切换到B场景，调用的函数顺序为B::init()---->A::exit()---->B::onEnter() 
--	--可如果使用了切换效果，比如CTransitionJumpZoom::transitionWithDuration这样的函数，则函数的调用顺序变为B::init()---->B::onEnter()---->A::exit()
--	-- 而且第二种方式会有一瞬间将两个场景的资源叠加在一起，如果不采取过度，很可能会因为内存吃紧而崩溃。
--	有时强制释放全部资源时，会使某个正在执行的动画失去引用而弹出异常，可以调用CCActionManager::sharedManager()->removeAllActions();来解决。
	
	--回收没用到的资源
--	display:removeUnusedSpriteFrames();--里面原理是：removeUnusedSpriteFrames CCTextureCache:sharedTextureCache():removeUnusedTextures();
	
	
	
--	CCTextureCache:sharedTextureCache():removeAllTextures() --释放以前的资源
--	CCLabelBMFont:purgeCachedData();--释放位图字体

--		把所有图片的texture设置下setAliasTexParameters就不会模糊了
--		setAntiAliasTexParameters
--		默认不是RGBA8888
end


return BaseScene
