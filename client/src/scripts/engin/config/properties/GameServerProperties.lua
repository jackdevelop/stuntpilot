--[[
 	GameServerProperties
 	public ->> 全局公开类  
 	游戏中game的app包可以直接重写此类
	
	
	游戏的请求的server地址
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local GameServerProperties = {}

GameServerProperties.ServerUrl = "http://creativeproject.herokuapp.com/"; -- 请求的服务器地址


return GameServerProperties
