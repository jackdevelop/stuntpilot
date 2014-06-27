--[[
 	Base
 	public ->> 全局公开类
 	
	基础的类  即可当做显示的基类  也可当做sprite显示对象的基类
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local Base = class("Base")




--[[
@param batch显示
@param object
]]
function Base:ctor(batch,object)
	self.batch_=batch;--父类
	self.object_=object;
end





--初始化数据
function Base:initData()
end

--初始化视图
function Base:initView()
end
--获取外层batch
function Base:getBatch()
	return self.batch_
end







--移除
function Base:removeView()
	self.object_ = nil;
	self.batch_=nil;
end



return Base;