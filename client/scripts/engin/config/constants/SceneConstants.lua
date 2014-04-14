--[[
 	SceneConstants
 	public ->> 全局公开类
 	
	地图的基础静态属性
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local SceneConstants = {}


--帧运行频率  dt
SceneConstants.dt=0.0165;--0.01



--指定父类的显示层
SceneConstants.BACKGROUND_LAYER="backgroundLayer";--返回背景图
SceneConstants.DEBUG_LAYER="debugLayer";--debug层

SceneConstants.FLOORS_LAYER="floorsLayer";--地板层
SceneConstants.FLY_LAYER="flysLayer";--建筑的上一飞行层
SceneConstants.BATCH_LAYER="batchLayer";--中间建筑层

SceneConstants.TOUCH_LAYER="touchLayer";--触摸层
SceneConstants.UI_LAYER="uiLayer";--ui层
SceneConstants.LOADING_LAYER="loadingLayer"; --地图的loading层
SceneConstants.TIP_LAYER="tipLayer";--tips层




--游戏优先级的基本定义 
SceneConstants.LayerEventPriorityConstants_scene_touchLayer = 100; 
SceneConstants.MaskLayer=-200;


--游戏的层级的
--UI的优先级别
SceneConstants.MIN_UI_ZORDER      = 0
SceneConstants.MAX_UI_ZORDER      = 100

--MapConstants.DEFAULT_OBJECT_ZORDER  = 200
SceneConstants.MAX_OBJECT_ZORDER      = 20000
--MapConstants.BULLET_ZORDER          = 21000








----场景的名称
--SceneConstants.LoginScene = "LoginScene";--登陆场景




return SceneConstants
