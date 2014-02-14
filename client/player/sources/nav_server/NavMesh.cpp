#include "NavMesh.h"

static vector<Cell*> cellV; // cell vector

void NavMesh::init(int count, int arr[])
{
    // init cellV
    Cell *cell = NULL;
    for (vector<Cell*>::iterator iter = cellV.begin();
        iter != cellV.end(); )
    {
        delete *iter;
        iter = cellV.erase(iter);
    }
    
    for (int i = 0; i < count; i += 6) {

        if (count < i + 5)
        {
           // printf("Init NavMesh Data Error %d\n", count);
            break;
        }
        
        Vector2f p1(arr[i    ], arr[i + 1]);
        Vector2f p2(arr[i + 2], arr[i + 3]);
        Vector2f p3(arr[i + 4], arr[i + 5]);
        cell = new Cell(p1, p2, p3);
        cell->index = i / 6;
        cellV.push_back(cell);
    }

    // init cell link relation
    for (unsigned int i = 0; i < cellV.size(); ++i) {
        for (unsigned int j = 0; j < cellV.size(); ++j) {
            if (i != j) {
                cellV[i]->checkAndLink(cellV[j]);
            }
        }
    }

}

NavMesh *NavMesh::create()
{
    return new NavMesh();
}



void NavMesh::destroy()
{
	  for (vector<Cell*>::iterator iter = cellV.begin();
        iter != cellV.end(); )
    {
        delete *iter;
        iter = cellV.erase(iter);
    }
	
	CMinHeap::destroy();
}


Cell *NavMesh::findCellByPoint(Vector2f &point)
{
    for (unsigned int i = 0; i < cellV.size(); ++i) {
        if (cellV[i]->isContainPoint(point)) {
            return cellV[i];
        }
    }
    return NULL;
}





int NavMesh::findPath(Vector2f startPoint, Vector2f endPoint)
{
    // the cell where startPoint in
    Cell *startCell = findCellByPoint(startPoint);
    // the cell where endPoint in
    Cell *endCell = findCellByPoint(endPoint);

    if (startCell == NULL || endCell == NULL) { // startCell or endCell is NULL
        return -1;
    }

    if (startCell == endCell) { // startPoint and endPoint in same cell
        pathPointV.clear();
        pathPointV.push_back(startPoint);
        pathPointV.push_back(endPoint);
        return pathPointV.size() * 2;
    }

    static int pathSessionId = 0;
    ++pathSessionId;

    //Heap *openList = new Heap();
    CMinHeap *openList = CMinHeap::instance(true);
    // add endCell to openList    
    openList->push(endCell);

    // set endCell's property
    endCell->f = 0;
    endCell->h = 0;
    endCell->isOpen = false;
    endCell->parent = NULL;
    endCell->sessionId = pathSessionId;

    bool pathFound = false; // is path found
    Cell *curCell = NULL; // current cell
    Cell *adjCell = NULL; // current cell's adjacent cell

    while (openList->size() > 0) {
        // pop the element which has the smallest f
        curCell = openList->pop();

        if (curCell == NULL) { // openList is empty
            break;
        }

        if (curCell == startCell) { // path found
            pathFound = true;
            break;
        }

        int adjacentId;
        for (int i = 0; i < 3; ++i) {
            adjacentId = curCell->links[i];
            if (adjacentId < 0) { // unwalkable
                continue;
            }
            adjCell = cellV[adjacentId];
            if (adjCell == NULL) {
                continue;
            }
            if (adjCell->sessionId != pathSessionId) { // not same session
                adjCell->sessionId = pathSessionId;
                adjCell->parent = curCell;
                adjCell->isOpen = true;

                adjCell->computeHeuristic(startPoint);
                adjCell->f = curCell->f + adjCell->wallDistance[abs(i - curCell->arrivalWall)];
                openList->push(adjCell);
                adjCell->setAndGetArrivalWall(curCell->index);
            } else {
                if (adjCell->isOpen) { // already in openList
                    if (curCell->f + adjCell->wallDistance[abs(i - curCell->arrivalWall)] < adjCell->f) {
                        adjCell->f = curCell->f;
                        openList->update(adjCell);
                        adjCell->parent = curCell;
                        adjCell->setAndGetArrivalWall(curCell->index);
                    }
                } else {
                    adjCell = NULL;
                }
            }
        }
    }

    CMinHeap::destroy();

    if (pathFound) {
        // generate path cell data
        genPathCell(startCell);
        // generate path point data
        genPathPoint(startPoint, endPoint);
        return pathPointV.size() * 2;
    }
    return -2;
}

int NavMesh::findPath(int startX, int startY, int endX, int endY)
{
    Vector2f *startPoint = new Vector2f(startX, startY);
    Vector2f *endPoint = new Vector2f(endX, endY);
    int ret = findPath(*startPoint, *endPoint);
    delete startPoint;
    delete endPoint;
    return ret;
}

void NavMesh::genPathCell(Cell *cell)
{
    pathCellV.clear();
    pathCellV.push_back(cell);
    while (cell->parent != NULL) {
        pathCellV.push_back(cell->parent);
        cell = cell->parent;
    }
}    

void NavMesh::genPathPoint(Vector2f startPoint, Vector2f endPoint)
{
    pathPointV.clear();
    pathPointV.push_back(startPoint);
    if (pathCellV.size() == 1) {
        pathPointV.push_back(endPoint);
        return;
    }

    Cell *wayPointCell = pathCellV[0];
    Vector2f wayPointPosition = startPoint;
    while (!wayPointPosition.equals(endPoint)) {
        getFurthestWayPoint(
            wayPointCell,
            wayPointPosition,
            endPoint
        );
        wayPointCell = retWayPointCell;
        wayPointPosition = retWayPointPosition;
        pathPointV.push_back(retWayPointPosition);
    }
}

void NavMesh::getFurthestWayPoint(
    Cell *wayPointCell,
    Vector2f &wayPointPosition,
    Vector2f &endPoint
)
{
    Vector2f startPt = wayPointPosition;
    Cell *cell = wayPointCell;
    Cell *lastCell = cell;
    int startIndex = 0;
    for (unsigned int i = 0; i < pathCellV.size(); ++i) {
        if (pathCellV[i] == cell) {
            startIndex = i;
            break;
        }
    }
    Line2D *outSide = cell->sides[cell->arrivalWall];
    Vector2f lastPtA = outSide->pointA;
    Vector2f lastPtB = outSide->pointB;
    Line2D *lastLineA = new Line2D(startPt, lastPtA);
    Line2D *lastLineB = new Line2D(startPt, lastPtB);
    Vector2f testPtA;
    Vector2f testPtB;
    for (unsigned int i = startIndex + 1; i < pathCellV.size(); ++i) {
        cell = pathCellV[i];
        outSide = cell->sides[cell->arrivalWall];
        if (i == pathCellV.size() - 1) {
            testPtA = endPoint;
            testPtB = endPoint;
        } else {
            testPtA = outSide->pointA;
            testPtB = outSide->pointB;
        }

        if (!lastPtA.equals(testPtA)) {
            if (lastLineB->classifyPoint(testPtA) == RIGHT_SIDE) {
                retWayPointCell = lastCell;
                retWayPointPosition = lastPtB;

                delete lastLineA;
                delete lastLineB;
                return;
            } else {
                if (lastLineA->classifyPoint(testPtA) != LEFT_SIDE) {
                    lastPtA = testPtA;
                    lastCell = cell;
                    lastLineA->setPointB(lastPtA);
                }
            }
        }

        if (!lastPtB.equals(testPtB)) {
            if (lastLineA->classifyPoint(testPtB) == LEFT_SIDE) {
                retWayPointCell = lastCell;
                retWayPointPosition = lastPtA;

                delete lastLineA;
                delete lastLineB;
                return;
            } else {
                if (lastLineB->classifyPoint(testPtB) != RIGHT_SIDE) {
                    lastPtB = testPtB;
                    lastCell = cell;
                    lastLineB->setPointB(lastPtB);
                }
            }
        }
    }
    retWayPointCell = pathCellV[pathCellV.size() - 1];
    retWayPointPosition = endPoint;

    delete lastLineA;
    delete lastLineB;
}

void NavMesh::getPath(int count, int arr[])
{
    unsigned int size = pathPointV.size();
    if (count < static_cast<int>(size)) {
        size = count;
    }
    for (unsigned int i = 0; i < size; ++i) {
        arr[i * 2    ] = pathPointV[i].x;
        arr[i * 2 + 1] = pathPointV[i].y;
    }
}

void NavMesh::printPath(void)
{
   // printf("path point info:\n");
    for (unsigned int i = 0; i < pathPointV.size(); ++i) {
     //   printf("pathPointV[%d]=(%f,%f)\n", i, pathPointV[i].x, pathPointV[i].y);
    }
}
