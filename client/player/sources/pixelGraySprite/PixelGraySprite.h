#ifndef __PIXEL_GRAY_SPRITE_H_
#define __PIXEL_GRAY_SPRITE_H_


#include "cocos2d.h"
#include "CCLuaEngine.h"
#include <string>

extern "C" {
#include "lua.h"
}

#define NS_MAP_GAME_LUABINDING_BEGIN namespace GameLuabinding {
#define NS_MAP_GAME_LUABINDING_END }

using namespace std;
using namespace cocos2d;

NS_MAP_GAME_LUABINDING_BEGIN

class PixelGraySprite
{
public:
	static PixelGraySprite *create(void);
	~PixelGraySprite(void);
	CCSprite* graylightWithCCSprite(CCSprite* oldSprite,bool isLight);
private:
    PixelGraySprite(void);
	lua_State *L;
};

NS_MAP_GAME_LUABINDING_END

#endif // __MAP_RUNTIME_C_H_