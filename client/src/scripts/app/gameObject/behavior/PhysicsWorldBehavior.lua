--[[
总物理世界 
一个场景中一般只有一个 
http://cn.cocos2d-x.org/tutorial/show?id=1356
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local TiledMapUtil = require("engin.util.TiledMapUtil")
local PhysicsWorldBehavior = class("PhysicsWorldBehavior", BehaviorBase)





function PhysicsWorldBehavior:ctor()
    PhysicsWorldBehavior.super.ctor(self, "PhysicsWorldBehavior", nil, 0)
end


local GRAVITY         = -200
local physicsWorld;

function PhysicsWorldBehavior.getPhysicsWorld()
	return physicsWorld
end



function PhysicsWorldBehavior:bind(object)
	local function createView(object,batch, floorsLayer,flysLayer, debugLayer)
		local  runningScene = BaseScene:getRunningScene()
		
		--创建物理世界 
	    object.physicsWorld_ = CCPhysicsWorld:create(0, GRAVITY)
	    batch:addChild(object.physicsWorld_)
	    -- add debug node
	    object.physicsWorldDebug = object.physicsWorld_:createDebugNode()
	    batch:addChild(object.physicsWorldDebug)
		physicsWorld = object.physicsWorld_;
		
		
		--解析地图的碰撞层
		local tiledMap = runningScene.tiledMap_;
		if tiledMap then
			local function callBack(physicsBodyParam)
				object:createPhysicsBody(physicsBodyParam);		
			end
			TiledMapUtil.getPhysicsWorldProperties(tiledMap,"pengzhuang",callBack)
		end
		
		object.physicsWorld_:start()
	end
	object:bindMethod(self, "createView", createView)
	
	
	
	
	
	
	local function removeView(object)
	end
    object:bindMethod(self, "removeView", removeView, true)
	
	
	
	
   	local function updateView(object)		
    end
    object:bindMethod(self, "updateView", updateView)
end



function PhysicsWorldBehavior:unbind(object)
end



return PhysicsWorldBehavior
