
--[[--
初始化
]]


require("app.config.constants.SceneConstants")








--[[--
初始化静态类
]]

--可重写
AnimationProperties = require("app.config.properties.AnimationProperties") -- 动画的一些基础定义 game的app中可以直接重写覆盖此类
GameImageUIProperties =  require("app.config.properties.GameImageUIProperties") --ui以及图片的常量类 game的app中可以直接重写覆盖此类
GamePlistProperties  = require("app.config.properties.GamePlistProperties") --plist常量类 game的app中可以直接重写覆盖此类
GameSoundProperties = require("app.config.properties.GameSoundProperties")  --音乐
GameServerProperties = require("app.config.properties.GameServerProperties")  --服务器地址


BehaviorClassProperties = require("app.config.properties.BehaviorClassProperties")




