--[[
 	GamePlistProperties
 	public ->> 全局公开类  
 	完全重写父类的  engin/config/properties/GamePlistProperties.lua
 	
 	游戏中game的app包可以直接重写此类
	
	
	游戏的plist常量
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local GamePlistProperties = {}



local Jplist = Jplist;
GamePlistProperties.Sheet_Map=Jplist("fight/Sheet_Map",nil)


return GamePlistProperties
