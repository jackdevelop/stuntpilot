--[[
		
	摘自   http://magustest.com/blog/tag/lua/
	
	在Lua中，字符串是一个常量，如果用字符串连接符“..”把2个字符串连接起来，例如first_str = first_str .. second_str，
	那么原来的first_str和second_str就会作为垃圾等待回收，first_str引用的是一个新的字符串，如果在程序里面有大量的字符串连接操作的话，
	性能会十分低下。Lua是一个很简洁的语言，他没有StringBuffer的实现，但是其实我们可以动手写一个简单的StringBuffer实现，来避免性能的问题。
	
	首先定义一个叫StringBuffer的table，使得这个StringBuffer被调用的时候看起来像是面向对象的样子 ：）
	 然后分别定义两个方法append和tostr，实现的原理就是：append用table来保存所有字符串，tostr把保存了字符串的table用concat转成真正的字符串。
	
	
	使用 ：
		local all_assets ={};
		for asset in ctx:allassets() do
		    StringBuffer.append(all_assets, asset:id())
		    StringBuffer.append(all_assets, ', ')
		end
		result = StringBuffer.tostr(all_assets)
		print (result)
		

]]
local StringBuffer={}


StringBuffer.append =  function(t, str)
	if t and str then
	    table.insert(t, str)
	end
end
StringBuffer.tostr =  function(t)
	if t then
	    return table.concat(t)
	end
end







return StringBuffer;