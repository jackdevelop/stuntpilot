--[[
 	AtlasText
 	public ->> 全局公开类
 	不可重写
 	CCLabelAtlas 封转类使用
 	
	使用：
	local atlasParam = {
		labelWithString,
		charMapFile = "",
		itemWidth,
		itemHeight,
	}
	local txtParam = {
		text = ,
		textAlign ,
		x, 
		y,
	}
	local txt = AtlasText:create(atlasParam,txtParam);
 	
 
 * @author  jackdevelop@sina.com
 * $Id:$
 * @version 1.0
]]
local AtlasText ={}-- class("AtlasText");






--CCLabelAtlas* diceCount=CCLabelAtlas::labelWithString("1:", "nums_font.png", 14, 21, '0');
--labelWithString 第一个参数：显示的内容：1x，你也许会奇怪为什么是1x，因为使用的png图必须是连续的，因为程序内部是议连续的scall码识别的。9的后一位的”:“，所以先实现x就得用”:“代替。
--charMapFile 第二个参数：图片的名字
--itemWidth  第三个参数：每一个数字的宽
--itemHeight 第四个参数：每一个数字的高 这个不能设错，否则显示的时候可能就不对了。
--每五个数字：开始字符
function AtlasText.create(atlasParam,txtParam)
	--CCLabelAtlas的基础参数
	local labelWithString = atlasParam.labelWithString or "0";
	local charMapFile = atlasParam.charMapFile or "font/ui_num.png" ;
	local itemWidth = atlasParam.itemWidth or "24";
	local itemHeight = atlasParam.itemHeight or "24";
    local startCharMap = atlasParam.startCharMap or string.byte('0');
	
	
	--显示文本的基础参数
	local text       = tostring(txtParam.text)
    local textAlign  = txtParam.align or  display.CENTER
    local x, y       = txtParam.x, txtParam.y
	
	local atlasText = CCLabelAtlas:create(labelWithString, charMapFile, itemWidth, itemHeight,startCharMap )
	display.align(atlasText, textAlign, x, y)
	
	
	return atlasText;
end






return AtlasText
