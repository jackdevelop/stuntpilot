--[[
 	HttpLoad
 	public ->> 全局公开类
 	
	http的连接类
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local HttpLoad = class("HttpLoad")



function HttpLoad:ctor()
    self.requestCount = 0
end


function HttpLoad:json(actionId,param,callBack)
	network.isHostNameReachable(UrlConfig.ServerUrl)
	
    self.requestCount = self.requestCount + 1
    local index = self.requestCount
    local request = network.createHTTPRequest(function(event)
        self:onResponse(callBack,event, index, true)
        
--        local request = event.request;
--        local cookieStr = request:getCookieString();
--        if cookieStr then
--	        local cookie = network.parseCookie(cookieStr)
--	        dump(cookie, "GET COOKIE FROM SERVER")
--        end
		
    end, UrlConfig.ServerUrl..actionId, "POST")
--    end, GameServerProperties.ServerUrl, "GET")--get方式获取  ，post获取
	 --和下面这个是一样的吧？
	local jsonParam = json.encode(param);
    request:addPOSTValue("param", jsonParam);
    --[[
    	http://www.cnblogs.com/QLeelulu/archive/2009/11/22/1607898.html
    	
    	要在发送请求的时候添加HTTP Basic Authentication认证信息到请求中，有两种方法：
		•一是在请求头中添加Authorization：
		Authorization: "Basic 用户名和密码的base64加密字符串"
		•二是在url中添加用户名和密码：
		http://userName:password@api.minicloud.com.cn/statuses/friends_timeline.xml
    ]]
    if not self.heard_ then
    	self.heard_ = "Authorization: Basic "..crypto.encodeBase64("admin:creativeproject");
   	end
   	request:addRequestHeader(self.heard_)
   	
   	
    request:setCookieString(network.makeCookieString({C1 = "V1", C2 = "V2"}))
    printf("REQUEST START %d", index)
    request:start()
end





function HttpLoad:onResponse(callBack,event, index, dumpResponse)
    local request = event.request
    printf("REQUEST %d - event.name = %s", index, event.name)
    if event.name == "completed" then
    
    	local statusCode = request:getResponseStatusCode();
    	local result = request:getResponseString();
        printf("REQUEST %d - getResponseStatusCode() = %d", index, statusCode)
        printf("REQUEST %d - getResponseHeadersString() =\n%s", index, request:getResponseHeadersString())

        if statusCode == 200 then
        	printf("REQUEST %d - getResponseDataLength() = %d", index, request:getResponseDataLength())
            if dumpResponse then
                printf("REQUEST %d - getResponseString() =\n%s", index, result)
            end
            HttpLoadResultHandle:succesHandle(callBack,result)
        else
        	HttpLoadResultHandle:errorHandle(callBack,statusCode)
        end
    else
        printf("REQUEST %d - getErrorCode() = %d, getErrorMessage() = %s", index, request:getErrorCode(), request:getErrorMessage())
    end
end












return HttpLoad
