#include "Math2dC.h"


/**
精确获取两个点之间的距离  浮点数计算 
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
粗略计算两个点之间的距离  整形数计算 
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
