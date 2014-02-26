
local MovableBehavior = class("MovableBehavior", BehaviorBase)

MovableBehavior.MOVING_STATE_STOPPED   = 0
MovableBehavior.MOVING_STATE_SPEEDUP   = 1
MovableBehavior.MOVING_STATE_SPEEDDOWN = 2
MovableBehavior.MOVING_STATE_FULLSPEED = 3

MovableBehavior.SPEED_SCALE = 1.0 / 300

function MovableBehavior:ctor()
    MovableBehavior.super.ctor(self, "MovableBehavior", nil, 1)
end

function MovableBehavior:bind(object)
    object.movingLocked_         = 0



    local function isMovingLocked(object)
        return object.movingLocked_ > 0
    end
    object:bindMethod(self, "isMovingLocked", isMovingLocked)

    local function addMovingLock(object)
        object.movingLocked_ = object.movingLocked_ + 1
    end
    object:bindMethod(self, "addMovingLock", addMovingLock)

    local function removeMovingLock(object)
        object.movingLocked_ = object.movingLocked_ - 1
        assert(object.movingLocked_ >= 0, "MovableBehavior.removeMovingLock() - object.movingLocked_ must >= 0")
    end
    object:bindMethod(self, "removeMovingLock", removeMovingLock)


	
	
	
    local function startMoving(object)
        if object.movingState_ == MovableBehavior.MOVING_STATE_STOPPED
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDDOWN then
            object.movingState_ = MovableBehavior.MOVING_STATE_SPEEDUP
        end
    end
    object:bindMethod(self, "startMoving", startMoving)

    local function stopMoving(object)
        if object.movingState_ == MovableBehavior.MOVING_STATE_FULLSPEED
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDUP then
            object.movingState_ = MovableBehavior.MOVING_STATE_SPEEDDOWN
        end
    end
    object:bindMethod(self, "stopMoving", stopMoving)

	
    local function stopMovingNow(object)
        object.movingState_ = MovableBehavior.MOVING_STATE_STOPPED
        object.currentSpeed_ = 0
    end
    object:bindMethod(self, "stopMovingNow", stopMovingNow)

	
    local function isMoving(object)
        return object.movingState_ == MovableBehavior.MOVING_STATE_FULLSPEED
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDUP
    end
    object:bindMethod(self, "isMoving", isMoving)

	
    local function tick(object, dt)
--        if not object.play_ or object.movingLocked_ > 0 or not object.bindingPathId_ then return end
--
--        local state = object.movingState_
--        if state == MovableBehavior.MOVING_STATE_STOPPED then return end
--
--        if state == MovableBehavior.MOVING_STATE_SPEEDUP
--                or (state == MovableBehavior.MOVING_STATE_FULLSPEED
--                    and object.currentSpeed_ < object.maxSpeed_) then
--            object.currentSpeed_ = object.currentSpeed_ + object.speedIncr_
--            if object.currentSpeed_ >= object.maxSpeed_ then
--                object.currentSpeed_ = object.maxSpeed_
--                object.movingState_ = MovableBehavior.MOVING_STATE_FULLSPEED
--            end
--        elseif state == MovableBehavior.MOVING_STATE_SPEEDDOWN then
--            object.currentSpeed_ = object.currentSpeed_ - object.speedDecr_
--            if object.currentSpeed_ <= 0 then
--                object.currentSpeed_ = 0
--                object.movingState_ = MovableBehavior.MOVING_STATE_STOPPED
--            end
--        elseif object.currentSpeed_ > object.maxSpeed_ then
--            object.currentSpeed_ = object.currentSpeed_ - object.speedDecr_
--            if object.currentSpeed_ < object.maxSpeed_ then
--                object.currentSpeed_ = object.maxSpeed_
--            end
--        end
--
--        local x, y = object.x_, object.y_
--        local currentDist = object.currentDist_ + object.currentSpeed_
--        if currentDist >= object.nextDist_ then
--            object.x_, object.y_ = object.nextX_, object.nextY_
--            currentDist = currentDist - object.nextDist_
--            self:setNextPosition(object)
--            x, y = math2d.pointAtCircle(object.x_, object.y_, object.nextRadians_, currentDist)
--        else
--            local ox, oy = math2d.pointAtCircle(0, 0, object.nextRadians_, object.currentSpeed_)
--            x = x + ox
--            y = y + oy
--        end
--        object.currentDist_ = currentDist
--
--        if x < object.x_ then
--            object.flipSprite_ = true
--        elseif x > object.x_ then
--            object.flipSprite_ = false
--        end
--        object.x_, object.y_ = x, y
    end
    object:bindMethod(self, "tick", tick)


    local function getFuturePosition(object, time)
        local x, y = object.x_, object.y_
        if object.currentSpeed_ == 0  then
            return x, y
        else
        	
        	
        end
    end
    object:bindMethod(self, "getFuturePosition", getFuturePosition)

    local function setSpeed(object, maxSpeed)
        object.speed_ = tonumber(maxSpeed)
        if object.speed_ < 0 then object.speed_ = 0 end

        object.speedIncr_ = object.speed_ * 0.025 * MovableBehavior.SPEED_SCALE
        object.speedDecr_ = object.speed_ * 0.038 * MovableBehavior.SPEED_SCALE
        object.maxSpeed_  = object.speed_ * MovableBehavior.SPEED_SCALE
    end
    object:bindMethod(self, "setSpeed", setSpeed)


	
    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)

    self:reset(object)
end

function MovableBehavior:unbind(object)
    object:unbindMethod(self, "isMovingLocked")
    object:unbindMethod(self, "addMovingLock")
    object:unbindMethod(self, "removeMovingLock")
    object:unbindMethod(self, "startMoving")
    object:unbindMethod(self, "stopMoving")
    object:unbindMethod(self, "stopMovingNow")
    object:unbindMethod(self, "isMoving")
    object:unbindMethod(self, "tick")
    object:unbindMethod(self, "getFuturePosition")
    object:unbindMethod(self, "setSpeed")
    object:unbindMethod(self, "vardump")
end

function MovableBehavior:reset(object)
    object:setSpeed(tonumber(object.state_.speed))
    object.currentSpeed_ = 0
    object.movingState_  = MovableBehavior.MOVING_STATE_STOPPED
end

return MovableBehavior
