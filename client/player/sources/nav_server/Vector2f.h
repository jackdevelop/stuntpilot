#ifndef _VECTOR2F_H
#define _VECTOR2F_H

#include <cmath>
#include <stdlib.h>

#include "constant.h"

class Vector2f
{
    public:
        float x;
        float y;
        
        Vector2f& operator= (const Vector2f& other);
        Vector2f(float _x, float _y);
        Vector2f(const Vector2f& v);
        Vector2f();
        
        inline void setVector2f(const Vector2f &v)
        {
            x = v.x;
            y = v.y;
        }

        inline float getAngle()
        {
            return -atan2(y, x);
        }

        inline float length()
        {
            return sqrt(lengthSquared());
        }

        inline float lengthSquared()
        {
            return x * x + y * y;
        }

        inline float distanceSquared(const Vector2f &v)
        {
            float dx = x - v.x;
            float dy = y - v.y;
            return dx * dx + dy * dy;
        }

        inline Vector2f addLocal(const Vector2f &vec)
        {
            x += vec.x;
            y += vec.y;
            return *this;
        }

        inline Vector2f multLocal(float scalar)
        {
            x *= scalar;
            y *= scalar;
            return *this;
        }

        inline Vector2f normalize(void)
        {
            float len = length();
            if (len != 0) {
                return divide(len);
            }
            return divide(1);
        }

        inline Vector2f divide(float scalar)
        {
            return Vector2f(x / scalar, y / scalar);
        }

        inline Vector2f subtract(const Vector2f &vec)
        {
            return Vector2f(x - vec.x, y - vec.y);
        }

        inline bool equals(const Vector2f &vec)
        {
            return (abs(x - vec.x) < EPSILON) 
                && (abs(y - vec.y) < EPSILON);
        }

        inline float dot(const Vector2f &vec)
        {
            return x * vec.x + y * vec.y;
        }
};

#endif
