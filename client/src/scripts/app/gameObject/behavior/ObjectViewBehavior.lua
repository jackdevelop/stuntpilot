--[[
显示对象
]]
local ObjectViewBehavior = class("ObjectViewBehavior", BehaviorBase)

function ObjectViewBehavior:ctor()
    ObjectViewBehavior.super.ctor(self, "ObjectViewBehavior", nil, 0)
end

function ObjectViewBehavior:bind(object)
    object.isSelected_ = false

    local function isSelected(object)
        return object.isSelected_
    end
    object:bindMethod(self, "isSelected", isSelected)

    local function setSelected(object, isSelected)
        object.isSelected_ = isSelected
    end
    object:bindMethod(self, "setSelected", setSelected)

	
	--x,y点是否在当前的对象的范围内
    local function checkPointIn(object, x, y)
        return math2d.dist(x,
                           y,
                           object.x_ + object.radiusOffsetX_,
                           object.y_ + object.radiusOffsetY_) <= object.radius_
    end
    object:bindMethod(self, "checkPointIn", checkPointIn)

	
	
	--创建动画
    local function createView(object, batch, marksLayer, debugLayer)
       if self.framesName_ then
	        local frames = display.newFrames(self.framesName_, self.framesBegin_, self.framesLength_)
	        self.sprite_ = display.newSpriteWithFrame(frames[1])
	        self.sprite_:playAnimationForever(display.newAnimation(frames, self.framesTime_))
	    else
	        local imageName = self.imageName_
	        if type(imageName) == "table" then
	            imageName = imageName[1]
	        end
	        self.sprite_ = display.newSprite(imageName)
	    end
	
	    local size = self.sprite_:getContentSize()
	    self.spriteSize_ = {size.width, size.height}
	
	    if self.scale_ then
	        self.sprite_:setScale(self.scale_)
	    end
	
	    batch:addChild(self.sprite_)
    end
    object:bindMethod(self, "createView", createView)

	
	
	
    local function removeView(object)
    	if self.sprite_ then
			self.sprite_:removeSelf()
			self.sprite_ = nil
		end
    end
    object:bindMethod(self, "removeView", removeView, true)

    local function updateView(object)		
        local x, y = math.floor(object.x_), math.floor(object.y_)
        
    end
    object:bindMethod(self, "updateView", updateView)

    local function fastUpdateView(object)
        updateView(object)
    end
    object:bindMethod(self, "fastUpdateView", fastUpdateView)
end

function ObjectViewBehavior:unbind(object)
    object.isSelected_ = nil

    object:unbindMethod(self, "isSelected")
    object:unbindMethod(self, "setSelected")
    object:unbindMethod(self, "checkPointIn")
    object:unbindMethod(self, "createView")
    object:unbindMethod(self, "removeView")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "fastUpdateView")
end

return ObjectViewBehavior
