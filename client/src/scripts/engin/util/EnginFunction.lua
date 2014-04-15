--[[
 	EnginFunction.lua
 	public ->> 全局公开类
 	
	 引擎的一些基础库封转
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]



--[[
四舍五入
math.ceil(x)    -- 向上取整
math.floor(x)   -- 向下取整
]]
function math.round(value)
    local intNum,num=math.modf(value);
    if num < 0.5 then 
        return math.floor (value)
    else
        return math.ceil (value)    
    end
end




--[[
巧妙使用 and or 还可以实现类似 C 语言中的 ?: 三元操作：
上面这个函数可以返回 a 和 b 中较大的一个，其逻辑类似 C 语言中的 return (a>b) ? a : b ;
]]
function Jmax(a,b)
    return a>b and a or b
end














--[[
 构造点   比使用table更轻量
 使用范例
p=Jpoint(1,2)
print(p("x"))		-- 1
print(p("y"))		-- 2 
]]
function Jpoint(x,y)
	return function (idx) 
		if idx=="x" then return x
		elseif idx=="y" then return y
		else return x,y end
	end
end



--[[
高效构造Jplist 的plist路径 png名称  格式 
	使用范例：
	p=Jplist("bullet/Sheet_Bullet",kCCTexture2DPixelFormat_RGBA8888)
	print(p("plist"))		-- bullet/Sheet_Bullet
	print(p("format"))		-- kCCTexture2DPixelFormat_RGBA8888
@param plistFileName
@param format
@param imageName
]]
function Jplist(plistFileName,format,imageName)
	return function (idx) 
		if not imageName then imageName =plistFileName end
		
		local currentPlistFileName =plistFileName..GameConstants.FileExtensionName_PLIST;
		local currentImageName   = imageName..GameConstants.FileExtensionName_PNG;
		
		if idx=="plist" then return currentPlistFileName
		elseif idx=="image" then return currentImageName
		elseif idx=="format" then return format 
		else return currentPlistFileName,format,currentImageName end
	end
end



--[[
高效构造Jsound 的音乐路径 是否重放 
	使用范例：
	p=Jsound("bullet/Sheet_Bullet",isLoop)
	print(p("soundUrl"))		-- bullet/Sheet_Bullet
	print(p("isLoop"))		-- kCCTexture2DPixelFormat_RGBA8888
@param soundUrl  音乐地址
@param isLoop  是否循环  默认为循环
]]
function Jsound(soundUrl,isLoop)
	return function (idx) 
		if idx=="soundUrl" then return soundUrl
		elseif idx=="isLoop" then return isLoop
		else return soundUrl,isLoop end
	end
end


--[[
高效构造Jscene 的场景名称  以及 上一个场景
	使用范例：
	p=Jsound("bullet/Sheet_Bullet",isLoop)
	print(p("soundUrl"))		-- bullet/Sheet_Bullet
	print(p("isLoop"))		-- kCCTexture2DPixelFormat_RGBA8888
@param sceneName  当前场景
@param backSceneName  上一场景
]]
function Jscene(sceneName,backSceneName)
	return function (idx) 
		if idx=="sceneName" then return sceneName
		elseif idx=="backSceneName" then return backSceneName
		else return sceneName,backSceneName end
	end
end


-- lua 中判断字符串前缀
--一个 lua 的小技巧
--在写 lua debugger 的时候，我需要判断一个字符串的前缀是不是 "@" 。
--有三个方案：
--1.比较直观的是 string.sub(str,1,1) == "@"
--2.感觉效率比较高的是 string.byte(str) == 64
--3.或者是 string.find(str,"@") == 1
--
--我推荐第三种。（注：在此特定运用环境下。因为用于判定 source 的文件名，大多数情况都是 @ 开头。如果结果为非，则性能较低）
--第一方案 string.sub 会在生成子串的时候做一次字符串 hash ，感觉效率会略微低一些。
--第二方案效率应该是最好，但是需要记住 @ 的 ascii 码 64 。如果前缀是多个字符也不适用。







 