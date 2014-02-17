
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end


--自己这里定义
CCLuaLoadChunksFromZIP("res/script/framework_precompiled.zip")
--[[
 环境变量    
	默认的基础的      E:\cocos2d-x+lua\lua\item\engin\git\quick-cocos2d-x\
	最新版本		 E:\cocos2d-x+lua\lua\item\engin\git\devel\quick-cocos2d-x\
]]




require("app.GameApp").new():run()


