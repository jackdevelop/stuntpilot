
--[[--

定义了所有的静态对象

]]

local StaticObjectsProperties = {}

local defines = {}

----------------------------------------

local object = {
    classId      = "static",
    framesName   = "IncreaseHp%04d.png",
    framesBegin  = 1,
    framesLength = 28,
    framesTime   = 1.0 / 28,
    radius       = 60,
    scale        = 2.0,
    offsetY      = 20,
    zorder       = 30000,
    viewZOrdered = false,
    behaviors   = {"DecorateBehavior"},
}
defines["IncreaseHp"] = object

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
