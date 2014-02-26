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
  注意：movingDistance 必须是scrollImageContentSize_ 的赔数
@param scrollImage 
@param scrollImageContentSize_ 
@param movingDistance 每帧移动的距离
]]
function ScrollSprite:initData(scrollImage,scrollImageContentSize,movingDistanceJpoint)
	self.scrollImage_ = scrollImage;--当前图片
	self.movingDistanceJpoint_ = movingDistanceJpoint; --每帧移动距离
	self.scrollImageContentSize_ = scrollImageContentSize;--当前图片所占的尺寸
	
	--计算使用
	self.distX_ = 0;
	self.distY_ = 0;
	self.moveNum_ = -1;
	self.moveNum_dist_ = 0;
end


--初始化视图
function ScrollSprite:initView()
	local scrollImage = self.scrollImage_ 
	self.scrollSpt_0 = display.newSprite(scrollImage); 
	display.align(self.scrollSpt_0,display.BOTTOM_LEFT)
	self:addChild(self.scrollSpt_0);
	
	--尺寸
	if not self.scrollImageContentSize_ then self.scrollImageContentSize_ = self.scrollSpt_0:getContentSize(); end
	local scrollImageContentSize = self.scrollImageContentSize_;--尺寸
	
	local scrollImageWidth,scrollImageHeight = scrollImageContentSize.width,scrollImageContentSize.height;
	local width,height = display.width*2,display.height*2;--大小
	
	--铺满全屏  
	if self.movingDistanceJpoint_("x") ~= 0  then  --横板
		local num =math.ceil( width/scrollImageWidth ); --需要创建多少个
		self.num_ = num;
		self.num_len_ = math.ceil( self.num_ * scrollImageWidth );
		for i = 1, num-1, 1 do 
		  local spt = display.newSprite(scrollImage,scrollImageWidth*i,0); 
		  display.align(spt,display.BOTTOM_LEFT)
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
			
	else
		
		local num =math.ceil( height/scrollImageHeight ); 
		self.num_ = num;
		self.num_len_ = math.ceil( self.num_ * scrollImageHeight );
		
		for i = 1, num-1, 1 do 
		  local spt = display.newSprite(scrollImage,0,scrollImageHeight*i); 
		  self:addChild(spt);
		  self["scrollSpt_"..i] = spt
		end
	end
end




--[[
设置移动距离
]]
function ScrollSprite:setMovingDistance(movingDistance)
	self.movingDistance_ = movingDistance;
end	
	



--[[
tick
]]
function ScrollSprite:tick(dt)
	local distX,distY = self.movingDistanceJpoint_();
	self.distX_ = self.distX_ + distX;
	self.distY_ = self.distY_ + distY;
	for i = 0, self.num_-1, 1 do 
	  	local spt = self["scrollSpt_"..i];
	  	local x,y = spt:getPosition();
	  	
	  	spt:setPosition(x+distX,y+distY);
	end
	
	
	
	
	local scrollImageContentSize = self.scrollImageContentSize_;--尺寸
	local scrollImageWidth,scrollImageHeight = scrollImageContentSize.width,scrollImageContentSize.height;
	if distX ~= 0 then --横板
		self.moveNum_dist_ = self.moveNum_dist_ +  distX ;--记录每次的移动距离
		if scrollImageWidth == math.abs(self.moveNum_dist_) then
			
			self.moveNum_ = self.moveNum_ + 1;
			
			
			local spt = self["scrollSpt_"..self.moveNum_];
			local x,y = spt:getPosition();
			spt:setPosition(x+self.num_len_,y);
			
			
			if self.moveNum_  == self.num_-1 then self.moveNum_ = -1 end;
			
			self.moveNum_dist_ = 0;
		end
		
	else
		self.moveNum_dist_ = self.moveNum_dist_ +  distY ;
		
		
		
	end
	
	
	
	
	
end





--移除
function ScrollSprite:removeView()
	ScrollSprite.super.removeView(self);
	
	
	for i = 0, self.num_, 1 do 
		self["scrollSpt_"..i] = nil;
	end
	self.num_ = nil;
	self.num_len_ = nil;
	
	self.scrollImage_ = nil;--当前图片
	self.scrollImageContentSize_ = nil;--当前图片所占的尺寸
end



return ScrollSprite;
