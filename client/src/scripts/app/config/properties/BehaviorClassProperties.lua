--[[
 	BehaviorProperties
 	public ->> 全局公开类  
 	游戏中game的app包可以直接重写此类
	
	
	游戏的Behavior行为
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local BehaviorClassProperties = {}



--定义所有的behavior的class
local defines = {
	DecorateBehavior  =  require("app.gameObject.behavior.DecorateBehavior"),
	ObjectViewBehavior =  require("app.gameObject.behavior.ObjectViewBehavior"),
	MovableBehavior    = require("app.gameObject.behavior.MovableBehavior"),
	MovableDirectBehavior    = require("app.gameObject.behavior.MovableDirectBehavior"),
	RoleBehavior       = require("app.gameObject.behavior.RoleBehavior"),
	DistanceCalculateBehavior =  require("app.gameObject.behavior.DistanceCalculateBehavior"),
	
	
	
	StaticObjectEditorBehavior =  require("app.gameObject.behavior.StaticObjectEditorBehavior"),
}




function BehaviorClassProperties.get(defineId)
    assert(defines[defineId], string.format("BehaviorClassProperties.get() - invalid defineId %s", tostring(defineId)))
    return clone(defines[defineId])
end

return BehaviorClassProperties
