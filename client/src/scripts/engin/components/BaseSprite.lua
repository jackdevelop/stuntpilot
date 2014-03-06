--[[
 	BaseSprite
 	public ->> 全局公开类
 	
	sprite显示对象的基类  
	直接返回ccnode对象   所以继承当前BaseSprite对象  外部不能使用queuebatch批量渲染
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local BaseSprite = class("BaseSprite",function()
     --return display.newSprite();
      return display.newNode();
end)




function BaseSprite:ctor(batch,object)
	self.batch_ = batch;
	self.object_=object;
end





--初始化数据
function BaseSprite:initData()
end

--初始化视图
function BaseSprite:initView()
end










--移除
function BaseSprite:removeView()
	self:removeSelf();
	self.object_ = nil;
	self.batch_= nil;
end


return BaseSprite;
