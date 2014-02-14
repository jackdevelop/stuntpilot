#include "Vector2f.h"

Vector2f& Vector2f::operator= (const Vector2f& other)
{
    x = other.x;
    y = other.y;
    return *this;
}

Vector2f::Vector2f(float _x, float _y)
    :x(_x),
    y(_y)
{
}

Vector2f::Vector2f(const Vector2f& v)
    :x(v.x),
    y(v.y)
{
}

Vector2f::Vector2f()
    :x(0),
    y(0)
{
}
