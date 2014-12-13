--[[
box刚体的物理组件 
]]
local BoxCollideBehavior = class("BoxCollideBehavior", BehaviorBase)

function BoxCollideBehavior:ctor()
    BoxCollideBehavior.super.ctor(self, "BoxCollideBehavior", nil, 0)
end

--摩擦力  -- 当mass<=0时会创建一个StaticBody
local mass = 0;

function BoxCollideBehavior:bind(object)
	--创建box刚体
	local function createView(object)
		local physicsBodyParam = object.physicsBodyParam;--物理的参数
		local type = physicsBodyParam.type; --类型 1圆形 2方向  3多边形
		local friction = physicsBodyParam.friction_;--摩擦系数 0-1.0
		local elasticity = physicsBodyParam.elasticity_;-- 反弹系数 0-1.0
--		local collideBody = physicsBodyParam.collide;
		local param = physicsBodyParam.param;--参数
		
		local body ;
		if type == 1 then
			body = self.world:createCircleBody(mass, param.radius, param.offsetX, param.offsetY)
		elseif type == 2 then
			body = self.world:createBoxBody(mass, param.width, param.height)--摩擦力，宽，高 
		else
			-- vertexes格式为{x1, y1, x2, y2, x3, y3}，目前的版本有bug，不可以设置offset
			body = self.world:createPolygonBody(mass, param.vertexes, param.offsetX, param.offsetY)
		end
		
		
		
	    body:setFriction(friction)--摩擦系数 0-1.0
	    body:setElasticity(elasticity)-- 反弹系数 0-1.0
--		body:setVelocity(velocityX, velocityY)-- 速度
--		body:setAngleVelocity(velocity)-- 角速度
		-- 是否是感应
--		body:setIsSensor(isSensor)
--		body:isSensor()
--		-- 推力
--		body:applyForce(forceX, forceY, offsetX, offsetY)
--		body:applyForce(force, offsetX, offsetY)
--		body:applyImpulse(forceX, forceY, offsetX, offsetY)
--		body:applyImpulse(force, offsetX, offsetY)

	    --body:bind(rightWallSprite)
	    --body:setPosition(display.right - WALL_THICKNESS / 2, display.cy + WALL_THICKNESS)
	end
	object:bindMethod(self, "createView", createView)
	
	
	
	local function removeView(object)
		-- unbind=true时将解除绑定的CCNode，但不会从场景里删除node,只是执行CC_SAFE_RELEASE_NULL(node);
		-- unbind=false时CCNode将继续绑定在该Body上，默认为true
--		body:removeSelf(unbind)
--		World:removeBody(body, unbind)
--		World:removeBodyByTag(tag, unbind)
	end
    object:bindMethod(self, "removeView", removeView, true)
	
	

    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
end

function BoxCollideBehavior:unbind(object)
    object:unbindMethod(self, "vardump")
end

return BoxCollideBehavior
