--[[
	动画文件统一放在res\ccs\dragon 下自定义文件夹

	使用方法
	local CCSArmature = require("client.view.css.ui.base.CCSArmature");
	local ccsArmature = CCSArmature.new();
	local param = {
		png ="ccs/dragon/baoshihecheng/baoshigonghui0.png", --png地址
		plist = "ccs/dragon/baoshihecheng/baoshigonghui0.plist", --plist地址
		json = "ccs/dragon/baoshihecheng/baoshigonghui.ExportJson" --json地址
		name = "baoshigonghui",--动画名称
	}
	ccsArmature:initData(param);
	ccsArmature:initView();
	self:addChild(ccsArmature);
]]
local CCSArmature = class("CCSArmature",function()
     --return display.newSprite();
      return display.newNode();
end);



--[[

@param  ccsName  ccs的面板名称
@param  plistArr  plist的响应资源 数组
]]
function CCSArmature:initData(param)
	if not param then param = {} end
	self.param_ = param;
	
	 --资源加载
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(
		param.png ,
		param.plist,
		param.json 
	)
end






--初始化视图
function CCSArmature:initView()
	local param = self.param_;
	
	local armature = CCArmature:create(param.name) --动画的名称
    armature:getAnimation():play("Animation1") --播放的标签
    armature:setPosition(ccp(display.cx,display.cy))
    self:addChild(armature)
    self.armature_ = armature;
end




--移除
function CCSArmature:removeView()
    if self.armature_ then
    	self.armature_:removeSelf();
    	self.armature_ = nil;
    end
end




function CCSArmature:setPosition(x,y)
	self.armature_:setPosition(x,y);
end


--[[
获取动画
]]
function CCSArmature:getCCArmature()
	return  self.armature_;
end



return CCSArmature
