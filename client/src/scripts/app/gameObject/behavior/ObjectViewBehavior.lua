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
       if object.framesName_ then
	        local frames = display.newFrames(object.framesName_, object.framesBegin_, object.framesLength_)
	        object.sprite_ = display.newSprite();--display.newSpriteFrame(frames[1])
	        object.sprite_:playAnimationForever(display.newAnimation(frames, object.framesTime_))
	        object.sprite_:displayFrame(frames[1])
	    else
	        local imageName = object.imageName_
	        if type(imageName) == "table" then
	            imageName = imageName[1]
	        end
	        object.sprite_ = display.newSprite(imageName)
	    end
	
	    local size = object.sprite_:getContentSize()
	    object.spriteSize_ = {size.width, size.height}
	
	    if object.scale_ then
	        object.sprite_:setScale(self.scale_)
	    end
	    
	    batch:addChild(object.sprite_)
    end
    object:bindMethod(self, "createView", createView)

	
	
	
    local function removeView(object)
    	if object.sprite_ then
			object.sprite_:removeSelf()
			object.sprite_ = nil
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
