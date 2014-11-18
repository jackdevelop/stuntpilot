local FlyDegreesData = require("app.data.FlyDegreesData")
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





	
	
	
	--慢慢加速
    local function startMoving(object)
        if object.movingState_ == MovableBehavior.MOVING_STATE_STOPPED --暂停状态
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDDOWN  --减速
        then
            object.movingState_ = MovableBehavior.MOVING_STATE_SPEEDUP
        end
    end
    object:bindMethod(self, "startMoving", startMoving)
	
	--慢慢减速
    local function stopMoving(object)
        if object.movingState_ == MovableBehavior.MOVING_STATE_FULLSPEED --全速
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDUP --加速
        then
            object.movingState_ = MovableBehavior.MOVING_STATE_SPEEDDOWN
        end
    end
    object:bindMethod(self, "stopMoving", stopMoving)

	--迅速切换到暂停  并吧speed的速度职位0
    local function stopMovingNow(object)
        object.movingState_ = MovableBehavior.MOVING_STATE_STOPPED
        object.currentSpeed_ = 0
    end
    object:bindMethod(self, "stopMovingNow", stopMovingNow)
	--迅速切换到全速  并吧speed的速度职位全速
    local function startMovingNow(object)
        object.movingState_ = MovableBehavior.MOVING_STATE_FULLSPEED
        object.currentSpeed_  = object.maxSpeed_
    end
    object:bindMethod(self, "startMovingNow", startMovingNow)
	
    local function isMoving(object)
        return object.movingState_ == MovableBehavior.MOVING_STATE_FULLSPEED
                or object.movingState_ == MovableBehavior.MOVING_STATE_SPEEDUP
    end
    object:bindMethod(self, "isMoving", isMoving)

	
	
	
	
	
	
	
	
	
	--[[
	设置速度
	]]
    local function setSpeed(object, maxSpeed)
        object.speed_ = checknumber(maxSpeed)
        if object.speed_ < 0 then object.speed_ = 0 end

        object.speedIncr_ = object.speed_ * 0.025 * MovableBehavior.SPEED_SCALE
        object.speedDecr_ = object.speed_ * 0.038 * MovableBehavior.SPEED_SCALE
        object.maxSpeed_  = object.speed_ * MovableBehavior.SPEED_SCALE
        
        
    end
    object:bindMethod(self, "setSpeed", setSpeed)
    
    
	
	
	
	
	
--	--[[
--	  鼠标控制状态下的计算行动
--	 ]]
--  	local function calcActionMouse(object)
--  		if object.movingLocked_ > 0  then return end
--
--        local state = object.movingState_
--        if state == MovableBehavior.MOVING_STATE_STOPPED then return end
--        
--        if self.path_ and self.path_[self.step_] then
--        	--local _nextTarget = _step==_path.length ? _endTarget : WorldMap.me.tile2WorldPostion(_path[_step][0],_path[_step][1]);
--        
--        end
--    end
	
	
	
    local function tick(object, dt)
        if object.movingLocked_ > 0  then return end

        local state = object.movingState_
        if state == MovableBehavior.MOVING_STATE_STOPPED then return end
		
		 if state == MovableBehavior.MOVING_STATE_SPEEDUP
                or (state == MovableBehavior.MOVING_STATE_FULLSPEED
                    and object.currentSpeed_ < object.maxSpeed_) then  --加速 或者全速
            object.currentSpeed_ = object.currentSpeed_ + object.speedIncr_
            if object.currentSpeed_ >= object.maxSpeed_ then --全速
                object.currentSpeed_ = object.maxSpeed_
                object.movingState_ = MovableBehavior.MOVING_STATE_FULLSPEED
            end
        elseif state == MovableBehavior.MOVING_STATE_SPEEDDOWN then
            object.currentSpeed_ = object.currentSpeed_ - object.speedDecr_ --减速
            if object.currentSpeed_ <= 0 then
                object.currentSpeed_ = 0
                object.movingState_ = MovableBehavior.MOVING_STATE_STOPPED
            end
        elseif object.currentSpeed_ > object.maxSpeed_ then --比最大速度都还大的情况下  只能跑到最大速
            object.currentSpeed_ = object.currentSpeed_ - object.speedDecr_
            if object.currentSpeed_ < object.maxSpeed_ then
                object.currentSpeed_ = object.maxSpeed_
            end
        end
        
--		local radians = object:getPlaneFlyRadians();
		
		
		--飞机行走	
		local x,y = object:getPosition();
		local flyDegrees = object:getPlaneFlyDegrees();
	    local vectorX,vectorY = FlyDegreesData[checkint(flyDegrees)]();
	    vectorX,vectorY = vectorX *object.currentSpeed_ ,vectorY*object.currentSpeed_ ;
	    
	    --死亡  使用死亡速度
--	    if object:isDestroyed() then  vectorX,vectorY = vectorX * object.deadSpeed_ ,vectorY * object.deadSpeed_   end;
	--    echoj("角度:",flyDegrees,"向量：".."("..vectorX,vectorY,")");
		object:setPosition(x+vectorX,y+vectorY);
    end
    object:bindMethod(self, "tick", tick)

	
	
	
	
	


	



	--[[
	获取time后的点
	]]
    local function getFuturePosition(object, time)
        local x, y = object.x_, object.y_
        if object.currentSpeed_ == 0  then
            return x, y
        else
        	
        	
        end
    end
    object:bindMethod(self, "getFuturePosition", getFuturePosition)
	
	


	
	
	
	
	
	

    
    
    local function setPosition(object,x,y)
    	--[[
		计算坐标
		]]
		local function runPos(object,x,y)
			--if(_controler) _controler.calcAction();
	    	local targetX,targety;
	    	local model = object.model_ ;
	    	local maxX = model.width_
	    	local maxY = model.height_;
	    	
	    	
	    	local targetx,targety;
	    	if object:isFocus() then
	    		
	    		local halfWidth = math.floor(display.width/2); --display.width>>1
				local halfHeight = math.floor(display.height/2);
	    		
	    		if x < halfWidth then 
	    			targetx = x;
	    		else
	    			targetx = x--halfWidth;
	    		end
	    		
	    		if y < halfHeight then 
	    			targety = y;
	    		else
	    			targety = y-- halfHeight;
	    		end
	    		
	    		
--	    		if x > maxX - halfWidth then
--	    			targetx = x - (maxX - display.width);
--	    		end
--	    		
--	    		if y > maxY - halfHeight then
--	    			targety = y - (maxY - display.height);
--	    		end
	    	else
	    		--将地图坐标转换为屏幕坐标 
	    		targetx,targety=x,y;--model.controller_.scene_:getCamera():convertToScreenPosition(object.x_,object.y_);
	    	end
	    	
	    	object.x_,object.y_ = targetx,targety ;
	    end
	    
	    
	    
	    
		runPos(object,x,y);
		
		
		
		
		
		
		if object:isDestroyed() then
			
		
		else
			--过滤信息
			if object.y_ > display.height + 10 then
				object:setPlaneFlyDegrees(9);
			elseif object.y_ < 50 then
				if object:isFocus() and object.y_ < 0 then 
					object:setPlaneFlyDegrees(24);
				else
					object:setPlaneFlyDegrees(24);
				end
			elseif object.x_ < -10 then 
				object:setPlaneFlyDegrees(1);
			elseif object.x_  > object.model_.width_ + 10 then
				object:setPlaneFlyDegrees(16);
			end
		end
    end
    object:bindMethod(self, "setPosition", setPosition)
   
	
	
	
	
    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
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
    object:setSpeed(checknumber(object.state_.speed))
    object.currentSpeed_ = 0
    object.movingState_  = MovableBehavior.MOVING_STATE_STOPPED
end

return MovableBehavior

