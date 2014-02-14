#include "Line2D.h"

Line2D::Line2D(Vector2f &_pointA, Vector2f &_pointB)
    :pointA(_pointA),
    pointB(_pointB)
{
    normalCalculated = false;
}
