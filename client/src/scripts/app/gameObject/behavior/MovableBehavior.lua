
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

	
	
	
	
	
	
	
	
	
	--[[
	设置速度
	]]
    local function setSpeed(object, maxSpeed)
        object.speed_ = tonum(maxSpeed)
        if object.speed_ < 0 then object.speed_ = 0 end

        object.speedIncr_ = object.speed_ * 0.025 * MovableBehavior.SPEED_SCALE
        object.speedDecr_ = object.speed_ * 0.038 * MovableBehavior.SPEED_SCALE
        object.maxSpeed_  = object.speed_ * MovableBehavior.SPEED_SCALE
    end
    object:bindMethod(self, "setSpeed", setSpeed)
    
    
	
	
	
	
	
	--[[
	  鼠标控制状态下的计算行动
	 ]]
  	local function calcActionMouse(object)
  		if object.movingLocked_ > 0  then return end

        local state = object.movingState_
        if state == MovableBehavior.MOVING_STATE_STOPPED then return end
        
        if self.path_ and self.path_[self.step_] then
--        	local _nextTarget = _step==_path.length ? _endTarget : WorldMap.me.tile2WorldPostion(_path[_step][0],_path[_step][1]);
        	
        
        end
    end
		 
--		protected function calcActionMouse():void
--		{
--			if(isStatic) return;
--			
--			var c:CharacterObject = _me as CharacterObject;
--			
--			if(_path!=null && _path[_step]!=null)
--			{
--				if(c.action==Actions.Wait) c.action = Actions.Run;
--				
--				_nextTarget = _step==_path.length ? _endTarget : WorldMap.me.tile2WorldPostion(_path[_step][0],_path[_step][1]);
--				
--				
--				var radian:Number = GMath.getPointAngle(_nextTarget.x-c.PosX,_nextTarget.y-c.PosY);
--				var angle:int = GMath.R2A(radian)+90;
--				
--				var xisok:Boolean=false;
--				var yisok:Boolean=false;
--				
--				var xspeed:Number = c.speed*Math.cos(radian);
--				var yspeed:Number = c.speed*Math.sin(radian);
--				
--				
--				if(Math.abs(c.PosX-_nextTarget.x)<=xspeed)
--				{
--					xisok=true;
--					xspeed=0;
--				}
--				
--				if(Math.abs(c.PosY-_nextTarget.y)<=yspeed)
--				{
--					yisok=true;
--					yspeed=0;
--				}
--				
--				moveTo(c.PosX+xspeed,c.PosY+yspeed,c);
--				
--				if(xisok && yisok)
--				{
--					// 走到新的位置点 更新区块坐标					
--					_step++;
--					if(_step>=_path.length)
--					{
--						
--						stopMove();
--						if(_onWalkComplate!=null) _onWalkComplate.apply(null,_onWalkParams);
--						clearWalkComplate();
--					}
--				}else{
--					changeDirectionByAngle(angle);
--				}
--			}
--		}
    local function tick(object, dt)
        if object.movingLocked_ > 0  then return end

        local state = object.movingState_
        if state == MovableBehavior.MOVING_STATE_STOPPED then return end
		
		
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
    	if object:getFocus() then
    		
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
    		
    		
    		if x > maxX - halfWidth then
    			targetx = x - (maxX - display.width);
    		end
    		
    		if y > maxY - halfHeight then
    			targety = y - (maxY - display.height);
    		end
    		
    	else
    		--将地图坐标转换为屏幕坐标 
    		targetx,targety=x,y;--model.controller_.scene_:getCamera():convertToScreenPosition(object.x_,object.y_);
    	end
    	
    	object.x_,object.y_ = targetx,targety ;
    end
    -- object:bindMethod(self, "runPos", runPos)
    
    
    local function setPosition(object,x,y)
		runPos(object,x,y);
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
    object:setSpeed(tonum(object.state_.speed))
    object.currentSpeed_ = 0
    object.movingState_  = MovableBehavior.MOVING_STATE_STOPPED
end

return MovableBehavior
