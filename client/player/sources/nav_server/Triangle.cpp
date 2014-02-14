#include "Triangle.h"

Triangle::Triangle(Vector2f& p1, Vector2f& p2, Vector2f& p3)
    :pointA(p1),
     pointB(p2),
     pointC(p3)
{   
    dataCalculated = false;
}

Triangle::~Triangle()
{
    for (vector<Line2D*>::iterator iter = sides.begin();
        iter != sides.end(); )
    {
        delete *iter;
        iter = sides.erase(iter);
    }
}

void Triangle::calculateData(void)
{
    center = pointA;

    center.addLocal(pointB).addLocal(pointC).multLocal(1.0f / 3.0f);

    sides.clear();
    sides.push_back(new Line2D(pointA, pointB));
    sides.push_back(new Line2D(pointB, pointC));
    sides.push_back(new Line2D(pointC, pointA));
    
    dataCalculated = true;
}

bool Triangle::isContainPoint(Vector2f& point)
{
    if (dataCalculated == false) 
    {
        calculateData();
    }

    if (sides.size() != 3)
    {
        return false;
    }
    
    for (int i = 0; i < 3; ++i) {
        if (sides[i]->classifyPoint(point) == LEFT_SIDE) 
        {
            return false;
        }
    }

    return true;
}
