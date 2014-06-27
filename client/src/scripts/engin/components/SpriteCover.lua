--[[
 	SpriteCover
 	public ->> 全局公开类
 	不可重写
 	
 	创建不可点击的层
	使用：
	local c = SpriteCover.createCoverSprite()
     self:addChild(c);
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local SpriteCover = {}--class("SpriteCover");









--[[
创建遮罩层
@param stopRect  阻止事件穿透
@param color 
]]
function SpriteCover.createCoverSprite(stopRect,color)
	if not stopRect then 
		stopRect = CCRect(0, 0, display.width, display.height)
	end
	
	local cover = SpriteButton.newButton({isPress = true});
	cover:setCascadeBoundingBox(stopRect)
	cover:setTouchSwallowEnabled(true)
	cover:setColor(ccc3(255, 125, 0 ))
	
	return cover
end










--[[
当项目中使用了cocostudio编辑ui时   优先统一使用SpriteCover.createCCSCoverSprite() 创建遮罩
创建ccs遮罩
不需要添加 
	删除时：PopUpManager:deletePopUp(popUp)；
]]
function SpriteCover.createCCSCoverSprite()
	local SpriteCoverCCSHandle  = require("client.view.ccs.handle.SpriteCoverCCSHandle");
	local spriteCoverCCSHandle = SpriteCoverCCSHandle.new();
	local ui = spriteCoverCCSHandle:init()
	
	
	return ui
end






----[[
--使用方法 
-- GameUtil.cover(pr [,func [,stopRect [,passRect] ] ])
-- 比如建筑的说明书 ： 
-- local c=GameUtil.cover(popView,function()
-- end,CCRectMake(0,0,960,640),nil)
-- --c:enabled(true)
--				
--@param pr  父窗口
--@param  func: 拦截事件时触发的函数
--@param  stopRect: rect内拦截(相对于cover内坐标)
--@param  passRect: rect内不拦截(相对于cover内坐标)
--@return CCLayer
-- ]]
--function SpriteCover.createCoverSprite(func,passFun,passRectArr)
--	local _layer =display.newLayer();
--	local _doNothing = function(eventType, x, y)
--		if(eventType=="began") then
--			local stop = true
--			
--			--过滤通过的地方
--			if passRectArr then
--				local convertNodePosition = _layer:convertToNodeSpace(ccp(x, y));
--				for k,v in pairs(passRectArr) do
--					local flag = v:containsPoint(convertNodePosition);
--					stop = not flag;
--					
--					if flag then 
--						break;
--					end
--				end
--			end
--			
--			if stop then
--				if(func) then func(x,y) end
--				return true
--			else 
--				if(passFun) then passFun(x,y) end
--				return false
--			end
--		end
--	end
--	
--	--_layer:registerScriptTouchHandler(_doNothing,false,-127,true) 
--	_layer:registerScriptTouchHandler(_doNothing,false,SceneConstants.MaskLayer,true)
--	_layer:setTouchEnabled(true)
--	return _layer
--end



return SpriteCover