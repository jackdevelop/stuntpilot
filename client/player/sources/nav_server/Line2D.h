#ifndef _LINE2D_H
#define _LINE2D_H

#include "constant.h"
#include "Vector2f.h"

class Line2D
{
    private:
        Vector2f normal;
        bool normalCalculated;

    public:
        Vector2f pointA;
        Vector2f pointB;

        Line2D(Vector2f &_pointA, Vector2f &_pointB);

        inline void setPointA(const Vector2f &point)
        {
            pointA = point;
            normalCalculated = false;
        }

        inline void setPointB(const Vector2f &point)
        {
            pointB = point;
            normalCalculated = false;
        }

        inline float signedDistance(Vector2f &point)
        {
            if (!normalCalculated) {
                computeNormal();
            }

            return point.subtract(pointA).dot(normal);
        }

        inline int classifyPoint(Vector2f &point, float epsilon)
        {
            float distance = signedDistance(point);
            if (distance > epsilon) {
                return RIGHT_SIDE;
            } else if (distance < -epsilon) {
                return LEFT_SIDE;
            } else {
                return ON_LINE;
            }
        }

        inline int classifyPoint(Vector2f &point)
        {
            return classifyPoint(point, EPSILON);
        }

        inline Vector2f getDirection(void)
        {
            return pointB.subtract(pointA).normalize();
        }

        inline void computeNormal(void)
        {
            normal = getDirection();
            float oldYValue = normal.y;
            normal.y = normal.x;
            normal.x = -oldYValue;
            normalCalculated = true;
        }

};

#endif
