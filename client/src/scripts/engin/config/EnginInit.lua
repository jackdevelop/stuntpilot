
--[[--
初始化
]]
require("engin.util.EnginOverload")
require("engin.util.EnginFunction")
require("engin.util.EnginDebug")












--[[--
初始化静态类
]]
--常量  不可重写
UrlConfig = require("engin.config.constants.UrlConfig")
SceneConstants = require("engin.config.constants.SceneConstants")
GameConstants = require("engin.config.constants.GameConstants")

GameUtil = require("engin.util.GameUtil"); 

StringUtil = require("engin.util.string.StringUtil"); --字符串相关工具类
StringBuffer= require("engin.util.string.StringBuffer"); --高效字符串连接类
 

--可重写 全部重写的
--AnimationProperties = require("engin.config.properties.AnimationProperties") -- 动画的一些基础定义 game的app中可以直接重写覆盖此类
--GameImageUIProperties =  require("engin.config.properties.GameImageUIProperties") --ui以及图片的常量类 game的app中可以直接重写覆盖此类
--GamePlistProperties  = require("engin.config.properties.GamePlistProperties") --plist常量类 game的app中可以直接重写覆盖此类
--GameSoundProperties  = require("engin.config.properties.GameSoundProperties") --音乐常量类 game的app中可以直接重写覆盖此类
--GameServerProperties = require("engin.config.properties.GameServerProperties")  --server的一些服务器地址请求接口

























--[[--
初始化全局类
]]
--http
HttpLoad = require("engin.mvcs.service.HttpLoad").new()
HttpLoadResultHandle = require("engin.mvcs.service.HttpLoadResultHandle").new()

--基础的控件
FilterText = require("engin.components.FilterText").new();
AtlasText  = require("engin.components.AtlasText").new();
BubbleButton =  require("engin.components.BubbleButton").new();
SpriteMask = require("engin.components.SpriteMask").new();


--管理类
PopUpManager = require("engin.manager.PopUpManager").new();



--base
Base  = require("engin.util.base.Base");
BaseObject  = require("engin.util.base.BaseObject");

--基础的显示控件
Animation  = require("engin.components.Animation"); --动画
AnimationCache = require("engin.components.AnimationCache"); --缓存动画类
BaseSprite  = require("engin.components.BaseSprite");--sprite显示基类


 










