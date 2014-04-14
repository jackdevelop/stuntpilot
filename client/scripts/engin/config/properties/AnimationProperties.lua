--[[
 	AnimationProperties
 	public ->> 全局公开类
 	
	基础的动画属性 ，供Animation类使用
	游戏中game的app包可以直接重写此类
 
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local AnimationProperties = {}

local defines = {}



----静态的图片
--local decoration = {
--    imageName = {"#bullet19_01.png"}, --图片的名称
--    offsetX   = {0}, --图像的横向偏移量，默认值为 0
--    offsetY   = {0},-- 图像的纵向偏移量，默认值为 0
--    visible   = true,--是否显示
--    zorder       = 0,
--}
--defines["towerShadow"] = decoration
--
--
----终极目标死亡
--local decoration = {
--    framesName      = "bullet10_%02d.png",
--    framesBegin     = 1,            -- 从 ShipWaveUp0001.png 开始
--    framesLength    = 12,           -- 一共有 16 帧
--    framesTime      = 0.1,     -- 播放速度为每秒 20 帧
--
--    -- 以下为都为可选设定
--    zorder          = 1,            -- 在被装饰对象的 ZOrder 基础上 +1，默认值为 0
--    playForever     = true,         -- 是否循环播放，默认值为 false
--    autoplay        = true,         -- 是否自动开始播放，默认值为 false
--    removeAfterPlay = false,        -- 播放一次后自动删除，仅当 playForever = false 时有效，默认值为 false
--    hideAfterPlay   = false,        -- 播放一次后隐藏，仅当 playForever = false 时有效，默认值为 false
--    visible         = true,         -- 是否默认可见，默认值为 true
--    offsetX         = 0,            -- 图像的横向偏移量，默认值为 0
--    offsetY         = 0,           -- 图像的纵向偏移量，默认值为 0
--    scale 			= 1,
--    delay			= 0,
--}
--defines["bullet10"] = decoration
--
--
--
--
--
----终极目标死亡
--local decoration = {
--    framesName      = "bullet19_%02d.png",
--    framesBegin     = 1,            -- 从 ShipWaveUp0001.png 开始
--    framesLength    = 10,           -- 一共有 16 帧
--    framesTime      = 0.1,     -- 播放速度为每秒 20 帧
--
--    -- 以下为都为可选设定
--    zorder          = 1,            -- 在被装饰对象的 ZOrder 基础上 +1，默认值为 0
--    playForever     = true,         -- 是否循环播放，默认值为 false
--    autoplay        = true,         -- 是否自动开始播放，默认值为 false
--    removeAfterPlay = false,        -- 播放一次后自动删除，仅当 playForever = false 时有效，默认值为 false
--    hideAfterPlay   = false,        -- 播放一次后隐藏，仅当 playForever = false 时有效，默认值为 false
--    visible         = true,         -- 是否默认可见，默认值为 true
--    offsetX         = 0,            -- 图像的横向偏移量，默认值为 0
--    offsetY         = 0,           -- 图像的纵向偏移量，默认值为 0
--    scale 			= 1,
--    delay			= 0,
--}
--defines["bullet22"] = decoration







--[[
获取帧动画
]]
function AnimationProperties.get(decorationName)
    return clone(defines[decorationName])
end


return AnimationProperties
