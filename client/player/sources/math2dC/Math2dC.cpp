#include "Math2dC.h"


/**
��ȷ��ȡ������֮��ľ���  ���������� 
@param ax
@param ay
@param bx
@param by
**/
float Math2dC::distByFloat(float ax, float ay,float bx,float by)
{
    float dx = bx - ax;
    float dy = by - ay;
    float dist = sqrtf(dx * dx + dy * dy);

	return dist;
}



/**
���Լ���������֮��ľ���  ���������� 
@param ax
@param ay
@param bx
@param by
**/
int Math2dC::dist(int ax,int ay,int bx,int by)
{
	int dx = bx - ax;
    int dy = by - ay;
    int dist = sqrtf(dx * dx + dy * dy);

	return dist;

}
