#ifndef _CELL_H
#define _CELL_H

#include <vector>

#include "constant.h"
#include "Triangle.h"
#include "Vector2f.h"

using namespace std;

class Cell : public Triangle
{
    private:
        void init(void);
    public:
        int links[3];
        int index;
        int sessionId;
        unsigned int heapId;
        int f;
        int h;
        bool isOpen;
        Cell *parent;
        int arrivalWall;
        vector<Vector2f> wallMidPoint;
        vector<float> wallDistance;
        Cell(Vector2f &p1, Vector2f &p2, Vector2f &p3);
        bool requestLink(Vector2f &pA, Vector2f &pB, Cell *caller);
        int getLink(int side);
        void checkAndLink(Cell *cell);
        void setLink(int side, Cell *caller);
        void computeHeuristic(Vector2f &goal);
        int setAndGetArrivalWall(int index);
};

#endif
