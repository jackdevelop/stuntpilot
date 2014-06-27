local StaticObjectEditorBehavior = class("StaticObjectEditorBehavior", BehaviorBase)

StaticObjectEditorBehavior.FIRE_CIRCLE_SELECTED_COLOR = {0, 0, 0, 255}
StaticObjectEditorBehavior.FIRE_CIRCLE_UNSELECTED_COLOR = {90, 0, 0, 180}


StaticObjectEditorBehavior.LABEL_ZORDER = 200;
StaticObjectEditorBehavior.CIRCLE_ZORDER = 300;
StaticObjectEditorBehavior.FLAG_ZORDER = 400;

StaticObjectEditorBehavior.LABEL_OFFSET_Y = 20;

function StaticObjectEditorBehavior:ctor()
    StaticObjectEditorBehavior.super.ctor(self, "StaticObjectEditorBehavior", nil, 0)
end

function StaticObjectEditorBehavior:bind(object)


    local function createView(object, batch, marksLayer, debugLayer)
    	if not debugLayer then return end
    	
        object.idLabel_ = ui.newTTFLabel({
            text  = object:getId(),
--            font  = 15--EditorConstants.LABEL_FONT,
            size  = 15,--EditorConstants.LABEL_FONT_SIZE,
            align = ui.TEXT_ALIGN_CENTER,
        })
        object.idLabel_.offsetY = math.floor(-object.radius_ - StaticObjectEditorBehavior.LABEL_OFFSET_Y)
        debugLayer:addChild(object.idLabel_, StaticObjectEditorBehavior.LABEL_ZORDER)

        object.radiusCircle_ = display.newCircle(object.radius_)
--        object.radiusCircle_:setColor(unpack(EditorConstants.UNSELECTED_COLOR))
        object.radiusCircle_:setLineStipple(checknumber("1111000011110000", 2))
        object.radiusCircle_:setLineStippleEnabled(true)
        debugLayer:addChild(object.radiusCircle_, StaticObjectEditorBehavior.CIRCLE_ZORDER)

		--object.flagSprite_ = display.newSprite("#balloon_path_png.png")
        object.flagSprite_ = display.newSprite("#CenterFlag.png")
        debugLayer:addChild(object.flagSprite_, StaticObjectEditorBehavior.FLAG_ZORDER)
    end
    object:bindMethod(self, "createView", createView)

    local function removeView(object)
		if object.idLabel_ then        
			object.idLabel_:removeSelf()
			object.idLabel_ = nil
		end

		if object.radiusCircle_ then    
			object.radiusCircle_:removeSelf()
			object.radiusCircle_ = nil
		end
		
		if object.flagSprite_ then    
			object.flagSprite_:removeSelf()
			object.flagSprite_ = nil
		end

    end
    object:bindMethod(self, "removeView", removeView, true)

    local function updateView(object)		
        local x, y = math.floor(object.x_), math.floor(object.y_)

		local debugLayer = object.model_.debugLayer_;
		if not debugLayer then return end
		
		
        local scale = debugLayer:getScale()
        if scale > 1 then scale = 1 / scale end

        local idString = object:getId()
        object.idLabel_:setString(idString)
        object.idLabel_:setPosition(x, y + object.idLabel_.offsetY)
        object.idLabel_:setScale(scale)

        object.radiusCircle_:setPosition(x , y )

        object.flagSprite_:setPosition(x, y)
    end
    object:bindMethod(self, "updateView", updateView)

    local function fastUpdateView(object)
        updateView(object)
    end
    object:bindMethod(self, "fastUpdateView", fastUpdateView)
end

function StaticObjectEditorBehavior:unbind(object)
    object.isSelected_ = nil

    object:unbindMethod(self, "createView")
    object:unbindMethod(self, "removeView")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "fastUpdateView")
end

return StaticObjectEditorBehavior
