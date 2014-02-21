--[[
 	ScrollSprite
 	public ->> 全局公开类
 	
	无线滚动的ScrollSprite 视图
	
 
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local ScrollSprite =class("ScrollSprite",BaseSprite);



--[[
初始化数据
  以下两个
@param scrollSpt 
@param scrollImage 
]]
function ScrollSprite:initData(scrollImage,scrollImageContentSize)
	self.scrollImage_ = scrollImage;--当前图片
	self.scrollImageContentSize_ = scrollImageContentSize;--当前图片所占的尺寸
	self.scrollSpt_  = nil;
	
	self.direction_vertical_ = 0; -- 横屏
	self.direction_horizontal_ = 1; --竖屏
end


--初始化视图
function ScrollSprite:initView()
	local scrollImage = self.scrollImage_ 
	self.scrollSpt_ = display.newSprite(scrollImage); 
	self:addChild(self.scrollSpt_);
	
	local scrollImageContentSize = self.scrollImageContentSize_;--尺寸
	local scrollImageWidth,scrollImageHeight = scrollImageContentSize.width,scrollImageContentSize.height;
	local width,height = display.width*2,display.height*2;--大小
	
	--铺满全屏  
	if self.direction_vertical_ then  --横板
		local num =math.ceil( width/scrollImageWidth ); --需要创建多少个
		self.num_ = num;
		for i = 1, num, 1 do 
		  local spt = display.newSprite(scrollImage,scrollImageWidth*i,0); 
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
			
			
	else
		
		local num =math.ceil( height/scrollImageHeight ); 
		self.num_ = num;
		for i = 1, num, 1 do 
		  local spt = display.newSprite(scrollImage,0,scrollImageHeight*i); 
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
	end
end





--移除
function ScrollSprite:removeView()
	ScrollSprite.super.removeView(self);
	
	
	for i = 0, self.num_, 1 do 
		self["scrollSpt_"..i] = nil;
	end
	self.num_ = nil;
	
	self.scrollImage_ = nil;--当前图片
	self.scrollImageContentSize_ = nil;--当前图片所占的尺寸
	self.scrollSpt_  = nil;
	self.direction_vertical_ = nil; -- 横屏
	self.direction_horizontal_ = nil; --竖屏
end



return ScrollSprite;
