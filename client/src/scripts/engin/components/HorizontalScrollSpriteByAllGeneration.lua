--[[
 	HorizontalScrollSpriteByAllGeneration
 	public ->> 全局公开类
 	
	无线滚动的 HorizontalScrollSpriteByAllGeneration 视图
	此HorizontalScrollSpriteByAllGeneration 是横板正方向一次性全部生成
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local HorizontalScrollSpriteByAllGeneration =class("HorizontalScrollSpriteByAllGeneration",BaseSprite);



--[[
初始化数据
  注意：movingDistance 必须是scrollImageContentSize_ 的赔数
@param scrollImage 
@param scrollImageContentSize_ 
@param movingDistance 每帧移动的距离
@param scrollImageCountJpoint 图片数量
]]
function HorizontalScrollSpriteByAllGeneration:initData(scrollImage,scrollImageContentSize,movingDistanceJpoint,scrollImageCountJpoint)
	self.scrollImage_ = scrollImage;--当前图片
	self.movingDistanceJpoint_ = movingDistanceJpoint; --每帧移动距离
	self.scrollImageContentSize_ = scrollImageContentSize;--当前图片所占的尺寸
	local image = display.newSprite(scrollImage); 
	if not self.scrollImageContentSize_ then self.scrollImageContentSize_ = image:getContentSize(); end
	
	self.scrollImageCountJpoint_ = scrollImageCountJpoint;--横竖图片数量 
	
	--计算使用
	self.distX_ = 0;
	self.distY_ = 0;
	
	local movingDistanceJpointX,movingDistanceJpointY = self.movingDistanceJpoint_();
	if movingDistanceJpointX > 0 then  
		self.moveIntervalJpoint_ = {};
	elseif movingDistanceJpointX < 0 then
		local min = display.width-(self.scrollImageCountJpoint_("x")+1)*self.scrollImageContentSize_.width;
		self.moveIntervalJpoint_ = Jpoint(min,0);
	
	elseif movingDistanceJpointY > 0 then
	
	elseif movingDistanceJpointY < 0 then
	
	end
end




--初始化视图
function HorizontalScrollSpriteByAllGeneration:initView()
	local scrollImage = self.scrollImage_ 
	
	
	--尺寸
	local scrollImageContentSize = self.scrollImageContentSize_;--尺寸
	local scrollImageWidth,scrollImageHeight = scrollImageContentSize.width,scrollImageContentSize.height;
	
	
	
	--铺满全屏  
	local scrollImageCountJpointX,scrollImageCountJpointY = self.scrollImageCountJpoint_();
	if scrollImageCountJpointX > 0  then  --横板
		for i = 0,scrollImageCountJpointX, 1 do 
		  local spt = display.newSprite(scrollImage,scrollImageWidth*i,0); 
		  display.align(spt,display.BOTTOM_LEFT)
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
			
	else
		for i = 0, scrollImageCountJpointY, 1 do 
		  local spt = display.newSprite(scrollImage,0,scrollImageHeight*i); 
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
	end
end






--[[
设置移动距离
]]
function HorizontalScrollSpriteByAllGeneration:setMovingDistance(movingDistanceJpoint)
	self.movingDistanceJpoint_ = movingDistanceJpoint;
end	
	



--[[
tick
]]
function HorizontalScrollSpriteByAllGeneration:tick(dt)
	local moveIntervalJpoint0,moveIntervalJpoint1 = self.moveIntervalJpoint_();
	local distX,distY = self.movingDistanceJpoint_();
	
	if self.distX_ <= moveIntervalJpoint0 and distX < 0 then
		return
	elseif self.distX_ >= moveIntervalJpoint1 and distX > 0 then
		return
	end
	
	
	
	self.distX_ = self.distX_ + distX;
	self.distY_ = self.distY_ + distY;
	
	
  	local x,y = self:getPosition();
  	self:setPosition(x+distX,y+distY);
end









--移除
function HorizontalScrollSpriteByAllGeneration:removeView()
	HorizontalScrollSpriteByAllGeneration.super.removeView(self);
	
	
	for i = 0, self.num_, 1 do 
		self["scrollSpt_"..i] = nil;
	end
	self.scrollImage_ = nil;--当前图片
	self.movingDistanceJpoint_ = nil; --每帧移动距离
	self.scrollImageContentSize_ = nil;--当前图片所占的尺寸
	self.scrollImageCountJpoint_ = nil;--横竖图片数量 
	--计算使用
	self.distX_ = 0;
	self.distY_ = 0;
end



return HorizontalScrollSpriteByAllGeneration;
