--[[
工厂创建类

]]


local BehaviorFactory = {}

function BehaviorFactory.createBehavior(behaviorName)
	local class = BehaviorClassProperties.get(behaviorName);
    --local class = behaviorsClass[behaviorName]
    assert(class ~= nil, string.format("BehaviorFactory.createBehavior() - Invalid behavior name \"%s\"", tostring(behaviorName)))
    return class.new()
end

--local allStaticObjectBehaviors = {
--    BuildingBehavior  = true,
--    CampBehavior      = true,
--    CollisionBehavior = true,
--    DecorateBehavior  = true,
--    DestroyedBehavior = true,
--    FireBehavior      = true,
--    MovableBehavior   = true,
--    NPCBehavior       = true,
--    TowerBehavior     = true,
--}
--
--function BehaviorFactory.getAllStaticObjectBehaviorsName()
--    return table.keys(allStaticObjectBehaviors)
--end
--
--function BehaviorFactory.isStaticObjectBehavior(behaviorName)
--    return allStaticObjectBehaviors[behaviorName]
--end

return BehaviorFactory
