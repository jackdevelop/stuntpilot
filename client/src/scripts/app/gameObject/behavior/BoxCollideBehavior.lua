--[[
box刚体的物理组件 
]]
local BoxCollideBehavior = class("BoxCollideBehavior", BehaviorBase)

function BoxCollideBehavior:ctor()
    BoxCollideBehavior.super.ctor(self, "BoxCollideBehavior", nil, 0)
end



--摩擦力  -- 当mass<=0时会创建一个StaticBody
local physicsWorld;



function BoxCollideBehavior:bind(object)
	
	
	--创建box刚体
	local function createPhysicsBody(object,physicsBodyParam)
		if not physicsWorld then  --当physicsWorld为nil时 自动从对象中获取 
			physicsWorld = object.physicsWorld_
		end
		
		local type = physicsBodyParam.type; --类型 1圆形 2方向  3多边形
		local mass = physicsBodyParam.mass or 0;
		local friction = physicsBodyParam.friction_ or 0 ;--摩擦系数 0-1.0
		local elasticity = physicsBodyParam.elasticity_ or 0;-- 反弹系数 0-1.0
		local x = physicsBodyParam.x;
		local y = physicsBodyParam.y;
		local param = physicsBodyParam.param;--参数
		
		
		local physicsBody ;
		if type == 1 then
			physicsBody = physicsWorld:createCircleBody(mass, param.radius, param.offsetX, param.offsetY)
		elseif type == 2 then
			--因为是笛卡尔坐标系的问题  必须宽高做一定的转换
			x = x + param.width/2;
			y = y + param.height/2;
			physicsBody = physicsWorld:createBoxBody(mass, param.width, param.height)--摩擦力，宽，高 
		else
			-- vertexes格式为{x1, y1, x2, y2, x3, y3}，目前的版本有bug，不可以设置offset
			--physicsBody = physicsWorld:createPolygonBody(mass, param.vertexes, param.offsetX, param.offsetY)
--			physicsBody = physicsWorld:createPolygonBody(mass, param.vertexes)
			--physicsBody = physicsWorld:createPolygonBody(mass,  {0,0,0,-40,160,0})
		end
		
		if physicsBody then
		    physicsBody:setFriction(friction)--摩擦系数 0-1.0
		    physicsBody:setElasticity(elasticity)-- 反弹系数 0-1.0
		    physicsBody:setPosition(x, y)
	--		body:setVelocity(velocityX, velocityY)-- 速度
	--		body:setAngleVelocity(velocity)-- 角速度
	--		Body:setCollisionType(type)--设置物体的碰撞类别，默认所有物体都是类别0
			-- 是否是感应
	--		body:setIsSensor(isSensor)
	--		body:isSensor()
	--		-- 推力
	--		body:applyForce(forceX, forceY, offsetX, offsetY)
	--		body:applyForce(force, offsetX, offsetY)
	--		body:applyImpulse(forceX, forceY, offsetX, offsetY)
	--		body:applyImpulse(force, offsetX, offsetY)
	
			return physicsBody;
		end
	end
	object:bindMethod(self, "createPhysicsBody", createPhysicsBody, true)
	
	
	
	
	
	local function createView(object,batch, floorsLayer,flysLayer, debugLayer)
		if object.physicsBodyParam_ then
			local physicsBody = object:createPhysicsBody(object.physicsBodyParam_)
			local view = object:getView();
		    physicsBody:bind(view)
			self.physicsBody_ = physicsBody;
		end
	end
	object:bindMethod(self, "createView", createView)
	
	
	
	local function removeView(object)
		--[[
		 	unbind=true时将解除绑定的CCNode，但不会从场景里删除node,只是执行CC_SAFE_RELEASE_NULL(node);
		 	unbind=false时CCNode将继续绑定在该Body上，默认为true
		 	
		 	World:removeBody(body, unbind)
			World:removeBodyByTag(tag, unbind)
		]]
		if self.physicsBody_ then
			self.physicsBody_:removeSelf(true)
			self.physicsBody_ = nil;
		end
	end
    object:bindMethod(self, "removeView", removeView, true)
	
	
	
	
   	local function updateView(object)	
   		if self.physicsBody_ then	
	        local x, y = math.floor(object.x_), math.floor(object.y_)
	        self.physicsBody_:setPosition(x,y)
        end
    end
    object:bindMethod(self, "updateView", updateView)
    
    
    
    
end



function BoxCollideBehavior:unbind(object)
end



return BoxCollideBehavior
