#include "Cell.h"

Cell::Cell(Vector2f &p1, Vector2f &p2, Vector2f &p3)
    :Triangle(p1, p2, p3)
{
    init();
}

void Cell::init(void)
{
    arrivalWall = 0;
    heapId = -1;

    links[0] = -1;
    links[1] = -1;
    links[2] = -1;

    calculateData();

    wallMidPoint.clear();
    wallMidPoint.push_back(Vector2f((pointA.x + pointB.x) / 2.0,
        (pointA.y + pointB.y) / 2.0));
    wallMidPoint.push_back(Vector2f((pointB.x + pointC.x) / 2.0,
        (pointB.y + pointC.y) / 2.0));
    wallMidPoint.push_back(Vector2f((pointC.x + pointA.x) / 2.0,
        (pointC.y + pointA.y) / 2.0));

    wallDistance.clear();
    Vector2f wallVector;
    wallVector = wallMidPoint[0].subtract(wallMidPoint[1]);
    wallDistance.push_back(wallVector.length());
    wallVector = wallMidPoint[1].subtract(wallMidPoint[2]);
    wallDistance.push_back(wallVector.length());
    wallVector = wallMidPoint[2].subtract(wallMidPoint[0]);
    wallDistance.push_back(wallVector.length());
}

bool Cell::requestLink(Vector2f &pA, Vector2f &pB, Cell *caller)
{
    if (pointA.equals(pA)) { 
        if (pointB.equals(pB)) {
            links[SIDE_AB] = caller->index;
            return true;
        } else if (pointC.equals(pB)) {
            links[SIDE_CA] = caller->index;
            return true;
        }
    } else if (pointB.equals(pA)) {
        if (pointA.equals(pB)) {
            links[SIDE_AB] = caller->index;
            return true;
        } else if (pointC.equals(pB)) {
            links[SIDE_BC] = caller->index;
            return true;
        }
    } else if (pointC.equals(pA)) {
        if (pointA.equals(pB)) {
            links[SIDE_CA] = caller->index;
            return true;
        } else if (pointB.equals(pB)) {
            links[SIDE_BC] = caller->index;
            return true;
        }
    }
    return false;
}

int Cell::getLink(int side)
{
    return links[side];
}

void Cell::checkAndLink(Cell *cellB)
{
    if (getLink(SIDE_AB) == -1 && cellB->requestLink(pointA, pointB, this)) {
        setLink(SIDE_AB, cellB);
    } else if (getLink(SIDE_BC) == -1 && cellB->requestLink(pointB, pointC, this)) {
        setLink(SIDE_BC, cellB);
    } else if (getLink(SIDE_CA) == -1 && cellB->requestLink(pointC, pointA, this)) {
        setLink(SIDE_CA, cellB);
    }
}

void Cell::setLink(int side, Cell *caller)
{
    links[side] = caller->index;
}

void Cell::computeHeuristic(Vector2f &goal)
{
    float dx = abs(goal.x - center.x);
    float dy = abs(goal.y - center.y);
    h = dx + dy;
}

int Cell::setAndGetArrivalWall(int index)
{
    for (int i = 0; i < 3; ++i) {
        if (index == links[i]) {
            arrivalWall = i;
            return arrivalWall;
        }
    }
    return -1;
}
