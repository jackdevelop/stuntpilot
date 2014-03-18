--[[
 	AnimationCache
 	public ->> 全局公开类
 	
	动画类缓存内
	 其与 Animation.lua的不同是 ： 会缓存动画，更改动画  只需要单独的重设贴图即可 
	 贴图必须是plist上的
 	使用方法：
 		
 	  display.addSpriteFramesWithFileListName(GamePlistProperties.Sheet_Bullet())
     local animationCache = AnimationCache.new();
     local animationParam  = AnimationProperties.get("bullet10");
     animationCache:initData("myAnimation",animationParam)
     animationCache:createView(self)
     animationCache:updateView();
     local view = animationCache:getView();
     view:pos(display.cx,display.cy);
     
    --切换动画
	self:performWithDelay(function()
		--让动画停在某一帧
		--animationCache:stopAnimation();
		--animationCache:setDisplayFrameIndex(5)
		
		 --重新切换到其他的动画贴图  而不需要重新创建sprite生产动画
		 local animationParam1  = AnimationProperties.get("towerShadow");
	     animationCache:initData("myAnimation",animationParam1)
	     animationCache:createView(self)
	     animationCache:updateView();
	end, 2)
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local AnimationCache = class("AnimationCache")





--[[
初始化数据
@param name 动画名称
@param param  参数列表
]]
function AnimationCache:initData(name,param)
	self.previousName_ = self.name_;
	self.name_   = tostring(name);
	self.enforce_ = param.enforce;--是否强制执行当前预设的动作
	if not self.enforce_  and self.previousName_ == name then return end --同一份动画数据 直接返回
	
	self:removeData();--首先清理数据
	
	
    for k,v in pairs(param) do
        self[k .. "_"] = v
    end
    
    
    local staticIndex = param.staticIndex
    if staticIndex then
        if type(self.imageName_) == "table" then
            self.imageName_ = self.imageName_[staticIndex]
        end
        if type(self.offsetX_) == "table" then
            self.offsetX_ = self.offsetX_[staticIndex]
        end
        if type(self.offsetY_) == "table" then
            self.offsetY_ = self.offsetY_[staticIndex]
        end
    end
	
	

    self.zorder_  = toint(self.zorder_)
    self.offsetX_ = toint(self.offsetX_)
    self.offsetY_ = toint(self.offsetY_)
    self.delay_   = tonum(self.delay_)
    self.actions_ = {}

    self.scale_    = tonum(self.scale_)
    if self.scale_ == 0 then
        self.scale_ = 1
    end
    if type(self.visible_) ~= "boolean" then
        self.visible_ = true
    end
end



--内部方法 解析动画的数据
--返回第一帧的贴图
local function analyseFrames(self)
	local currentFirstTexture ; 
	
	if self.framesName_ then
        self.frames_ = display.newFrames(self.framesName_, self.framesBegin_, self.framesLength_, self.framesReversed_)
        self.animation_ = display.newAnimation(self.frames_, self.framesTime_)
     	self.animation_:retain()
        
        currentFirstTexture = self.frames_[1];
    elseif self.frames_ then
    	self.animation_ = display.newAnimation(self.frames_, self.framesTime_)
      	self.animation_:retain()
        currentFirstTexture = self.frames_[1];
    else
        local imageName = self.imageName_
        if type(imageName) == "table" then
            imageName = imageName[1]
        end
        
        currentFirstTexture = display.newSpriteFrameByFileName(imageName)
    end
    
    return currentFirstTexture;
end


function AnimationCache:createView(batch)
	if self.sprite_  then return end
    self.sprite_ = display.newSprite("#CenterFlag.png")
    
	batch:addChild(self.sprite_)
	self.sprite_:registerScriptHandler(function(event)
        if event == "exit" then
            self:release()
        end
    end)
end


--[[
@param enforce 是否强制执行
]]
function AnimationCache:updateView(enforce)
	if not enforce and not self.enforce_ and self.previousName_ == self.name_ then return end --同一份动画数据 直接返回
	
	
	local currentFirstFrame = analyseFrames(self);
	self.sprite_:displayFrame(currentFirstFrame)
	
	
    self.sprite_:setScale(self.scale_)
    if not self.visible_ then
        self.sprite_:setVisible(false)
    end

    if not self.autoplay_ then return end

    if self.playForever_ then
        self:playAnimationForever()
    else
        self:playAnimationOnce()
    end
end





















function AnimationCache:setDelay(delay)
    self.delay_ = delay
end

function AnimationCache:getView()
    return self.sprite_
end

function AnimationCache:isVisible()
    return self.visible_
end

function AnimationCache:setVisible(visible)
    self.sprite_:setVisible(visible)
    self.visible_ = visible
end
























function AnimationCache:playAnimationOnce(onComplete)
    self:stopAnimation()
    if self.removeAfterPlay_ then
        local userOnComplete = onComplete
        onComplete = function()
            if userOnComplete then userOnComplete() end
            self:removeView()
        end
    end
    local action = self.sprite_:playAnimationOnce(self.animation_, self.removeAfterPlay_, onComplete, self.delay_)
    self.actions_[#self.actions_ + 1] = action
end

function AnimationCache:playAnimationOnceAndRemove(onComplete)
    self:stopAnimation()
    local userOnComplete = onComplete
    onComplete = function()
        if userOnComplete then userOnComplete() end
        self:removeView()
    end
    local action = self.sprite_:playAnimationOnce(self.animation_, self.removeAfterPlay_, onComplete, self.delay_)
    self.actions_[#self.actions_ + 1] = action
end

function AnimationCache:playAnimationForever()
    self:stopAnimation()
    local action = self.sprite_:playAnimationForever(self.animation_, true, self.delay_)
    self.actions_[#self.actions_ + 1] = action
end

function AnimationCache:fadeOutAndStopAnimation(time, onComplete)
    local action = transition.fadeOut(self.sprite_, {
        time = time,
        onComplete = function()
            if onComplete then onComplete() end
            self:stopAnimation()
        end
    })
    self.actions_[#self.actions_ + 1] = action
end













function AnimationCache:setDisplayFrameIndex(index)
    if self.frames_ then
        self.sprite_:setDisplayFrame(self.frames_[index])
    end
end
--暂停  
function AnimationCache:stopAnimation()
	if self.actions_ then 
	    for i, action in ipairs(self.actions_) do
	        if not tolua.isnull(action) then transition.removeAction(action) end
	    end
	    self.actions_ = {}
    end
end
--暂停后 重新播放
function AnimationCache:resumePlay()
	if not self.autoplay_ then return end

    if self.playForever_ then
        self:playAnimationForever()
    else
        self:playAnimationOnce()
    end
end

--强制播放
function AnimationCache:enforcePlay()
    if self.playForever_ then
        self:playAnimationForever()
    else
        self:playAnimationOnce()
    end
end











--[[
移除
]]
function AnimationCache:release()
    if self.animation_ then
        self.animation_:release()
        self.animation_ = nil
    end
end

function AnimationCache:removeData()
	self:stopAnimation()
  	self:release()
    
    self.imageName_ = nil
    self.name_    = nil
    self.zorder_  = nil
    self.offsetX_ = nil
    self.offsetY_ = nil
    self.delay_   = nil
    self.actions_ = nil

    
    --用到的 
    self.framesName_ = nil
    self.frames_ = nil
    self.animation_ =nil
    self.scale_ =nil
    self.autoplay_ = nil
    self.playForever_ = nil
    self.framesReversed_ =nil
    self.visible_ =nil 
    self.actions_ =nil
end

function AnimationCache:removeView()
    self:stopAnimation()
    self:release()
    if self.sprite_ then
        self.sprite_:removeSelf()
        self.sprite_ = nil
    end
end

return AnimationCache
