--maker lcf8858  ，直接复制所有代码，看末尾注释块为使用例子，文件名要保存为 AFindPath.lua
module("AFindPath",package.seeall)


local m_mapList         -- 地图数据     --调试时使用
local m_openList        -- 开放列表(里面存放相邻节点) 
local m_inspectList     -- 检测列表(里面存放除了障碍物的节点) 
local m_pathList        -- 路径
local m_AFind           -- 代理，地图的代理方法
local m_destPoint       -- 目标点
local m_startPoint      -- 起点




function createPoint(x, y)
    local point = {}

        point.x = x
        point.y = y
        point.parent = nil
        point.child = nil
        point.f_value = 0
        point.f_cost = 0      

    return point
end


function calculateTwoObjDistance(point1,point2)
return math.abs(point1.x - point2.x) + math.abs(point1.y - point2.y)
end 


function removeObjFromList(list,point)
for key, var in ipairs(list) do
        if var.x == point.x and var.y == point.y then
         table.remove(list,key)
         break;
        end 
end
end


--参数为   自身点，相邻点，结束点
function inspectTheAdjacentNodes(node,  adjacent,  endNode)
if adjacent then

            local _x = math.abs(endNode.x - adjacent.x);  
            local _y = math.abs(endNode.y - adjacent.y);  

            local F , G, H1, H2, H3;  
            adjacent.f_cost = node.f_cost + calculateTwoObjDistance(node, adjacent);--获得累计的路程  
            G = adjacent.f_cost;  

            --三种算法  
            H1 = _x + _y;  
            --H2 = hypot(_x, _y);  
            --H3 = max(_x, _y);  

--A*算法 = Dijkstra算法 + 最佳优先搜索  
            F = G + H1;  
--            F = G;
--Dijkstra算法  
            --F = G;  

--最佳优先搜索  
            --F = H2;  


            adjacent.f_value = F;  

            adjacent.parent = node;--设置父节点  
            --adjacent->setColor(Color3B::ORANGE);--搜寻过的节点设为橘色  
            setSeachedC3B(adjacent)

            node.child = adjacent;--设置子节点  
            removeObjFromList(m_inspectList, adjacent);--把检测过的点从检测列表中删除  
            table.insert(m_openList,adjacent);--加入开放列表  
      end  

end


-- 两个点的是否相等
function isEquit(point1, point2)
    -- print(point1.f_value,point2.f_value)
    if point1.x == point2.x and point1.y == point2.y then
     return true;
    else
        return false;
    end
end


function getMinPathFormOpenList()
    --table.nums(m_openList)
    if table.nums(m_openList)>0 then
        local p1=m_openList[1];
        for key, var in ipairs(m_openList) do
            if var.f_value < p1.f_value then
         p1=var;
         end
        end
        return p1;
else
    return nil;
end
end


function getObjByPointOfMapCoord(list ,point)
    for key, var in ipairs(list) do
     if isEquit(var ,point) then
        return var;
     end
    end
return nil
end


--使用方法，返回路径；
function findPath(afind,startPoint,destPoint)
    m_mapList=afind.map;
    m_startPoint=startPoint;
    m_destPoint=destPoint;
    init(afind);

    print(table.getn(m_inspectList))
    --得到开始点的节点 
    local _sp = getObjByPointOfMapCoord(m_inspectList,m_startPoint)
    --得到结束点
    local _endNode =getObjByPointOfMapCoord(m_inspectList,m_destPoint)

    --因为是开始点 把到起始点的距离设为0  
    _sp.f_cost = 0;  
    _sp.f_value = 0;  
    --把已经检测过的点从检测列表中删除  
    removeObjFromList(m_inspectList, _sp);  
    --然后加入开放列表  
    table.insert(m_openList,_sp); 

    local _node =nil

    while true do
     --得到离起始点最近的点  
        _node = getMinPathFormOpenList();  
        if _node==nil then

            --找不到路径  
            print("找不到路径")
            break;  
        end 
        --把计算过的点从开放列表中删除  
        removeObjFromList(m_openList, _node);  
        local _x = _node.x;  
        local _y = _node.y;  

        if (isEquit(_node,m_destPoint)) then  
            break;  
        end  

        --检测8个方向的相邻节点是否可以放入开放列表中 ，可更改为四方向  ，上下左右，斜上下左右
        local _adjacent = getObjByPointOfMapCoord(m_inspectList, createPoint(_x + 1, _y + 1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList,createPoint( _x +1, _y));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList, createPoint(_x +1, _y-1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList,createPoint( _x , _y -1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList, createPoint(_x -1, _y - 1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList,createPoint( _x -1, _y));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList, createPoint(_x -1, _y+1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  

        _adjacent = getObjByPointOfMapCoord(m_inspectList,createPoint( _x , _y+1));  
        inspectTheAdjacentNodes(_node, _adjacent, _endNode);  
    end
    while _node  do
        table.insert(m_pathList, createPoint(_node.x, _node.y))
        _node = _node.parent
    end
    drawPath(m_pathList)
    return m_pathList;
end


--画出路径，调试时使用
function drawPath(pathlist)
    if table.getn(pathlist)>0 then
    --第图层必须为c1
        local layer = m_mapList:getLayer("c1")
        for i,v in ipairs(pathlist) do
            sprite = layer:getTileAt(cc.p( v["x"], v["y"] ))
            sprite:setColor(cc.c3b(0, 255, 0))
        end
        setSeachedC3B(pathlist[1],cc.c3b(0, 0, 255))
        setSeachedC3B(pathlist[table.getn(pathlist)],cc.c3b(0, 0, 255))
    end
end


--画出搜寻过的地图快，调试时使用
function setSeachedC3B(v,c3b)
    local layer = m_mapList:getLayer("c1")
    sprite = layer:getTileAt(cc.p( v["x"], v["y"] ))
    sprite:setColor(cc.c3b(255, 0, 0))
    if c3b~=nil then
        sprite:setColor(c3b)
        --todo
    end
end


function init(afind)
    m_inspectList={}
    m_openList={}
    m_pathList={}
    m_inspectList=afind.mapList;
    local layer = m_mapList:getLayer("c1")

--    local ls = layer:getLayerSize()
--    local i = 0
--    local j = 0
--    print(ls.width,ls.height)
--    for i = 0, ls.width-1, 1 do
--        for  j = 0, ls.height-1, 1 do
--            local sprite = layer:getTileAt(cc.p( i, j ))
--            if sprite==nil then
--                --local srt = print("sprite==nil: %f, %f", i,j)
--            else
--                table.insert(m_inspectList, createPoint(i,j))
--            end
--        end
--    end


end


-- 使用例子，在其他文件中使用
--[[
require("app.scenes.AFindPath")

    self.map = cc.TMXTiledMap:create("dt.tmx");
    self.map:addTo(self)
    self.map:align(display.CENTER, display.cx, display.cy)
    local  s1 = self.map:getContentSize()
    print("ContentSize: %f, %f", s1.width,s1.height)
    local layer = self.map:getLayer("c1")
    layer:getTexture():setAntiAliasTexParameters()
    local ls = layer:getLayerSize()
    local x = 0
    local y = 0
    for y = 0, ls.height-1, 1 do
        for  x = 0, ls.width-1, 1 do
            local sprite = layer:getTileAt(cc.p( x, y ))
            if sprite==nil then
                print("sprite==nil: %f, %f", x,y)
            end
        end
    end

    local deleget = {}
    deleget.map=self.map
    local dest_point = AFindPath.createPoint(18, 12)
    local start_point = AFindPath.createPoint(0, 9)
    deleget.mapList={}
    local x = 0
    local y = 0
    for y = 0, ls.height-1, 1 do
        for  x = 0, ls.width-1, 1 do
            local sprite = layer:getTileAt(cc.p( x, y ))
            if sprite~=nil then
                table.insert(deleget.mapList, AFindPath.createPoint(x,y))
            end
        end
    end
    
    
    local _path = AFindPath.findPath(deleget, start_point, dest_point)

--]]
