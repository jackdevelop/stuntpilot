--[[
 	GameServerProperties
	
	游戏的请求的server地址
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local GameServerProperties = {}

GameServerProperties.ServerUrl = "http://creativeproject.herokuapp.com"; -- 请求的服务器地址


--所有请求的action接口
GameServerProperties.LoginAction = "/users";--登陆的action



--基础的接口




return GameServerProperties
