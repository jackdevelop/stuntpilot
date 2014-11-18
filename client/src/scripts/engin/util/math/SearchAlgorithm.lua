--[[
搜索的相关算法
]]
local SearchAlgorithm = {}







--[[--
 两个物体是否发生碰撞  
  暂时只支持圆形的两个物体
@param target1
@param target2
@return true表示碰撞
]]
function SearchAlgorithm.checkCollision(target1,target2)
	local x1= target1["x_"];
    local y1= target1["y_"];
    local radius1 = target1["radius_"]; 
    
	local x2= target2["x_"];
    local y2= target2["y_"];
	local radius2 = target2["radius_"]; 
	
	
	--两点之间的距离
	local radiusDist = radius1 + radius2;
	local dist = Math2d.dist(x1,y1,x2,y2);
	if dist < radiusDist then 
		return true
	end	           	
	
	return false;
end



--[[
当前点(x,y)是否在当前的对象内
]]
function SearchAlgorithm:checkPointInTarget(object, x, y)
	local objectX,objectY,radius = object.x_ ,object.y_,object.radius_; 

	--首先一个粗判断
	local minX,maxX = objectX - radius,objectX + radius;
	local minY,maxY = objectY - radius,objectY + radius;

	
	--在进行一个细致判断
	if x > minX and x < maxX and 
		y > minY and y < maxY then
	
    	return Math2d.dist(x,y,objectX ,objectY) <= radius;
    end
    
    return false;
end






return SearchAlgorithm
