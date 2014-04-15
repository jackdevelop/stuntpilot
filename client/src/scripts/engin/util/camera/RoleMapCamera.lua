--[[
 	RoleMapCamera
 	public ->> 全局公开类
 	
	主要针对主角以及地图卷轴移动之内的
]]
local MapCamera = require("engin.util.camera.MapCamera")
local RoleMapCamera = class("RoleMapCamera",MapCamera)



function RoleMapCamera:ctor(map)
	 RoleMapCamera.super.ctor(self, map)
	 
    self.moveSpeed_ = 1; -- 地图的移动速度
    self.focus_ = nil; --镜头注视对象
    
    
end




--[[
镜头注视
]]
function RoleMapCamera:getFocus()
    return clone(self.focus_)
end
function RoleMapCamera:setFocus(focus)
    self.focus_ = focus;
end


--[[
镜头移动速度
]]
function RoleMapCamera:getMoveSpeed()
    return clone(self.moveSpeed_);
end
function RoleMapCamera:setMoveSpeed(moveSpeed)
    self.moveSpeed_ = moveSpeed
end





--[[
镜头迅速的观察某点
]]
function RoleMapCamera:lookAt(x,y)
	self.moveStartPoint_ = Jpoint(self:getOffset());
	self.moveEndPoint_ = Jpoint(x,y);
	
	self:moveTo(x, y)
end



--[[
镜头缓慢的移动到某个点
]]
function RoleMapCamera:flyTo(x,y,moveEndCallback)
	self.moveStartPoint_ = Jpoint(self:getOffset());
	self.moveEndPoint_ = Jpoint(x,y);
	self.moveEndCallback_ = moveEndCallback;
--	self.moveEndMark_ = 
--	self.moveLen_ = Math2d.dist(ax, ay, bx, by);
end


--[[
基本思路：
1.鼠标点击后，获取舞台坐标
2.将舞台坐标转换为世界坐标（比如，你的舞台坐标是100*100，而你的背景已经向上滚动了100像素，向右滚动了100像素，那么世界坐标应该是200，200）
3.把世界坐标转换为网格坐标
4.计算寻路，获得路径
5.把路径点转换为世界坐标，如果已经靠近边缘，则移动主角（再把世界坐标转换为舞台坐标），如果没有靠近边缘，则主角在中心，移动地图
]]
function RoleMapCamera:tick(dt)
	local moveEndPointX,moveEndPointY = self.moveEndPoint_();
	
	
	--判断当前焦点对象是否移动到了指定的点
	local function judgeFocusPosition()
		local focus = self.focus_;--当前的焦点
		if focus then 
			local focusPositionX,focusPositionY = focus:getPosition();
			if focusPositionX == moveEndPointX and focusPositionY == moveEndPointY then 
				return true
			end
		end
		return false;
	end
	
	
	
	--首先移动地图
	local function moveMap(movingSpeed,onComplete)
		if not movingSpeed then movingSpeed = 1 end;
		--self:moveTo(moveEndPointX,moveEndPointY);
		self:setOffset(moveEndPointX,moveEndPointY, movingSpeed, onComplete)
	end
	
	--移动完成后的回调
	local function moveMapEndCallBackFun()
		if self.moveEndCallback_ then 
			self.moveEndCallback_();
		end
	end
	
	
	
	
	
	
	local focus = self.focus_;--当前的焦点
	if focus then 
		if judgeFocusPosition() then return end
		
		moveMap(nil,function()
			if not judgeFocusPosition() then --开始移动主角
				transition.moveTo(focus, {
		            x = moveEndPointX,
		            y = moveEndPointY,
		            time = 1,
		            onComplete = moveMapEndCallBackFun
		        })
			end
		end);
	else
		moveMap(nil,moveMapEndCallBackFun);
	end
end




--public function update():void
--		{
--			if(_focus)
--			{
--				_zeroX = _focus.PosX - (Global.W>>1);
--				_zeroY = _focus.PosY - (Global.H>>1);
--				
--				var value:Number = Global.MAPSIZE.x-Global.W;
--				_zeroX = _zeroX<0 ? 0 : _zeroX;
--				_zeroX = _zeroX>value ? value : _zeroX;
--				
--				value = Global.MAPSIZE.y-Global.H;
--				_zeroY = _zeroY<0 ? 0 : _zeroY;
--				_zeroY = _zeroY>value ? value : _zeroY;
--			}
--			
--			_cameraView.x = _zeroX;
--			_cameraView.y = _zeroY;
--			
--			_cameraView.width = Global.W;
--			_cameraView.height = Global.H;
--		}

--		public function lookAt(x:uint,y:uint):void
--		{
--			this.focus(null);
--			setZero(x-(Global.W>>1),y-(Global.H>>1));
--			update();
--			_scene.ReCut();
--		}
		
--		public function flyTo(x:uint,y:uint,callback:Function=null):void
--		{
--			if(_timer!=null)
--			{
--				trace("[D5Camera] Camera is moving,can not do this operation.");
--				return;
--			}
--			this.focus(null);
--			_moveCallBack = callback;
--			
--			_moveStart = new Point(_zeroX-(Global.W>>1),_zeroY-(Global.H>>1));
--			
--			_moveEnd = new Point(x-(Global.W>>1),y-(Global.H>>1));
--
--			
--			_timer = new Timer(50);
--			_timer.addEventListener(TimerEvent.TIMER,moveCamera);
--			_timer.start();
--		}
--		
--		protected function moveCamera(e:TimerEvent):void
--		{
--			var xspeed:Number = (_moveEnd.x-_moveStart.x)/5;
--			var yspeed:Number = (_moveEnd.y-_moveStart.y)/5;
--			_moveStart.x += xspeed;
--			_moveStart.y += yspeed;
--			setZero(_moveStart.x,_moveStart.y);
--			if((xspeed>-.5 && xspeed<.5) && (yspeed>-.5 && yspeed<.5))
--			{
--				_moveEnd = null;
--				_timer.stop();
--				_timer.removeEventListener(TimerEvent.TIMER,moveCamera);
--				_timer = null;
--				_scene.ReCut();
--				if(_moveCallBack!=null) _moveCallBack();
--			}
--		}


return RoleMapCamera
