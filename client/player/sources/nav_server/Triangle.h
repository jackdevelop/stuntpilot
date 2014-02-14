#ifndef _TRIANGLE_H
#define _TRIANGLE_H

#include <vector>

#include "Line2D.h"
#include "Vector2f.h"

using namespace std;

class Triangle
{
    public:
        static const int SIDE_AB = 0;
        static const int SIDE_BC = 1;
        static const int SIDE_CA = 2;

        Vector2f pointA;
        Vector2f pointB;
        Vector2f pointC;
        Vector2f center;
        vector<Line2D*> sides;
        bool dataCalculated;
        
        Triangle(Vector2f& p1, Vector2f& p2, Vector2f& p);
        virtual ~Triangle();
        bool isContainPoint(Vector2f& point);

    protected:
        void calculateData(void);
};

#endif
