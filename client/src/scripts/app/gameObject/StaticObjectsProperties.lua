
--[[--

定义了所有的静态对象

]]

local StaticObjectsProperties = {}

local defines = {}

----------------------------------------

--飞机
local object = {
    classId      = "static",
    animation   = "p1_cart",
--    framesName   = "p1_cart%03d_png.png",
--    framesBegin  = 1,
--    framesLength = 2,
--    framesTime   = 1.0 / 28,
    radius       = 30,
    zorder       = 30000,
    viewZOrdered = true,
    behaviors   = {
    				"DecorateBehavior","ObjectViewBehavior","MovableBehavior",
    				"MovableDirectBehavior","RoleBehavior","DistanceCalculateBehavior",
    				
    				"StaticObjectEditorBehavior"
    			},
}
defines["p1_cart"] = object






--降落伞
local object = {
    classId      = "static",
--    framesName   = "balloon%03d_png.png",
--    framesBegin  = 1,
--    framesLength = 20,
--    framesTime   = 1.0 / 30,
	animation   = "balloon",
    radius       = 30,
    --zorder       = 30000,
    viewZOrdered = true,
    behaviors   = {
    				"DecorateBehavior","ObjectViewBehavior","MovableBehavior",
    				"MovableDirectBehavior","RoleBehavior","DistanceCalculateBehavior",
    				
    				
    				"StaticObjectEditorBehavior"
    			},
}
defines["balloon"] = object





----------------------------------------


--local object = {
--    classId     = "static",
--    imageName   = {"#PlayerTower0101.png", "#PlayerTower0102.png"},
--    radius      = 32,
--    offsetX     = {-15, -16, -16},
--    offsetY     = {3, 3, 2},
--    towerId     = "PlayerTower01L01",
--    decorations = {"PlayerTower01Destroyed"},
--    behaviors   = {"TowerBehavior"},
--    fireOffsetX = {0, 0, 0},
--    fireOffsetY = {24, 24, 24},
--    campId      = MapConstants.PLAYER_CAMP,
--}
--defines["PlayerTower01"] = object


----------------------------------------

function StaticObjectsProperties.getAllIds()
    local keys = table.keys(defines)
    table.sort(keys)
    return keys
end

function StaticObjectsProperties.get(defineId)
    assert(defines[defineId], string.format("StaticObjectsProperties.get() - invalid defineId %s", tostring(defineId)))
    return clone(defines[defineId])
end

function StaticObjectsProperties.isExists(defineId)
    return defines[defineId] ~= nil
end

return StaticObjectsProperties
