--[[
 	HttpLoadResultHandle
 	public ->> 全局公开类
 	
	http的连接类
 	游戏中game的app包可以直接重写此类 更改此类的相关处理
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local HttpLoadResultHandle = class("HttpLoadResultHandle")






--[[
	网络的异常错误处理
]]
function HttpLoadResultHandle:errorHandle(callBack,statusCode)
    -- http错误
   print("Error", string.format("http error(code=%s)", statusCode))
    --device.showAlert("Error", string.format("http error(code=%s)", statusCode))
end





--[[
	网络成功处理
	网络成功还分两种情况
	1：数据成功 且后台返回验证成功
	2：数据成功 但后台验证不成功 
]]
function HttpLoadResultHandle:succesHandle(callBack,result)
	local responseJson=json.decode(result); --解码json
	if responseJson then 
		local status = responseJson['status'] --后台返回的数据成功与否的编码
		--data 是数据
		
		if status == 1 then --成功
				
		elseif status == 2 then
			
			
		end
		
		
		--回调处理
	    if callBack then
			callBack(responseJson);
		end	
		echoj("json数据返回正确：",responseJson);
	else
		print("警告：数据不是json格式，或者数据位空");
	end
end
















return HttpLoadResultHandle
