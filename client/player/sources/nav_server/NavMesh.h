#ifndef _NAVMESH_H
#define _NAVmESH_H

#include <stdio.h>
#include <vector>

#include "constant.h"
#include "Vector2f.h"
#include "Cell.h"
#include "Heap.h"
#include "MinHeap.h"

using namespace std;

class NavMesh
{
    private:
        vector<Cell*> pathCellV; // path cell vector
        vector<Vector2f> pathPointV; // path point vector
        Cell *retWayPointCell;
        Vector2f retWayPointPosition;
        int findPath(Vector2f startPoint, Vector2f endPoint);
        Cell *findCellByPoint(Vector2f &point);
        void genPathCell(Cell *cell);
        void genPathPoint(Vector2f startPoint, Vector2f endPoint);
        void getFurthestWayPoint(Cell *wayPointCell,
            Vector2f &wayPointPosition,
            Vector2f &endPoint
        );
    public:
        static void init(int count, int arr[]);
		 static void destroy();
        static NavMesh *create();
        int findPath(int startX, int startY, int endX, int endY);
        void getPath(int count, int arr[]);
        void printPath(void);
};

#endif
