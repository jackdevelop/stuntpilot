比如做菜单，你把items(sprite的集合)加到一个作为背景的sprite上作为child，如果不需要背景可以用一个适合尺寸的透明图片（用小的全空的png，newScale9Sprite来缩放）
function TouchMenu:inSprite(x,y)
	local touchInSprite
	for k,v in ipairs(self.items) do
		touchInSprite = v:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
		if touchInSprite then
			return k
		end
	end
	return 0
end
这样就可以知道点击的是哪个sprite
如果是菜单，不要回传move消息，move的时候判断，如果移动到另外的tag上，也去做changeTag
begin的时候，如果tag>0就去做changeTag

function TouchMenu:changeTag(tag)
	if self.currTag == tag then
		self.listener(TOUCH_DOUBLE_CLICKED,tag,self.items[tag]) 	--双击
		return
	else
		self.currTag = tag
		self.listener(TOUCH_CLICKED,tag,self.items[tag]) 			--单击
	end

	local callback = function()
		self.listener(TOUCH_PRESSED,tag,self.items[tag]) 			--长按
		self.isPressed = true 	-- 用于阻挡消息(长按事件处理中，不再接受新的move效果)
	end

	if (self.timerId) then
		self.timer:kill(self.timerId)
	end
	self.timerId = self.timer:delayUpdate(callback,1)  --延时1秒
	self.isPressed = false
end


大概就是这样了
在ended事件中，删除计时任务：
		if self.timer:exists(self.timerId) then
			self.timer:kill(self.timerId)
		end
