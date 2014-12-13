local TiledMapUtil = {};




--创建tiled地图
function TiledMapUtil.create(tiledUrl)
	local tileMap=CCTMXTiledMap:create(tiledUrl);
	--local group = tileMap:objectGroupNamed("zuobiao1");
   return tileMap
end



--获取整个的宽度 高度
function TiledMapUtil.getSize(tiledMap)
	local mapSize = tiledMap:getMapSize();
	local tileSize = tiledMap:getTileSize()
	local size = {
		mapSize.width*tileSize.width,
		mapSize.height*tileSize.height
	};
	return size;
end








function TiledMapUtil.getObjects(tiledMap,objName)
	local group = tiledMap:objectGroupNamed(objName);
	if group then
		local array = group:getObjects();
		local count = array:count();--总过有多少个对象
		for i = 0, count-1, 1 do
			local one = array:objectAtIndex(i);
			
			local allKeys = one:allKeys();
			local allKeysCount = allKeys:count();
			for j = 0, allKeysCount-1, 1 do
				local key = allKeys:objectAtIndex(j):getCString();
				local value =  one:valueForKey(key);
				local valueStr = value:getCString()
				
				--[[
				-- 获取某个属性值  key:valueForKey("id"):getCString()
				local x =  one:valueForKey("x"):getCString() --或者使用objectForKey
				local y =  one:valueForKey("y"):getCString()
				local width =  one:valueForKey("width"):getCString() 
				local height =  one:valueForKey("height"):getCString() 
				local rotation =  one:valueForKey("rotation"):getCString() 
				--http://blog.csdn.net/teng_ontheway/article/details/21704279
				--编辑器中主要有polygone, polyline，box和circle4种，其实box也属于polygone
				local polygon = one:valueForKey("polygon") ;
				--自定义的一些属性
				local id =  one:valueForKey("id"):getCString()
				local type =  one:valueForKey("type"):getCString()
				]]
			end
			
			
			--[[
			单独读取碰撞属性 
			 <objectgroup name="pengzhuang">
			  <object id="11" x="2080" y="440">
			   <polygon points="0,0 0,-60 140,0"/>
			  </object>
			 </objectgroup>
			 最后的打印：
			 0,0 
			 0,-60
			 140,0
			]]
			local points = one:objectForKey("points");
			if points then
			local pointsCount = points:count();
			for k = 0, pointsCount-1, 1 do
				local onePoint = points:objectAtIndex(k);
				local onePointCount = onePoint:count();
				local x =  onePoint:valueForKey("x"):getCString() 
				local y = onePoint:valueForKey("y"):getCString() 
				--echoj(x,y);
			end
			end
			
			
			
		end
	end
end




function TiledMapUtil.getProperties(tiledMap,position)
	local tileGid = tiledMap:getTileGIDAt(position);
	if tileGid then
		local properties = tiledMap:getPropertiesForGID(tileGid) --:asValueMap();
		if  properties:empty() then
			--auto collision = properties["Collidable"].asString();
		end
	end
end













return TiledMapUtil;