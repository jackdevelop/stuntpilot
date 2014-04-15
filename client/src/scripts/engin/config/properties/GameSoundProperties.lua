--[[
 	GameSoundProperties
 	public ->> 全局公开类  
 	游戏中game的app包可以直接重写此类
	
	
	游戏的音乐常量
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local GameSoundProperties = {}


local Jsound = Jsound;
GameSoundProperties.bg_sound=Jsound("sound/bg.mp3",true)  --分别为:路径名称  是否循环


return GameSoundProperties
