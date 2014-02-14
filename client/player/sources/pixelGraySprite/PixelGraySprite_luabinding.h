#ifndef __PIXEL_GRAY_SPRITE_H_
#define __PIXEL_GRAY_SPRITE_H_

extern "C" {
#include "lua.h"
#include "tolua++.h"
#include "tolua_fix.h"
}
/* Exported function */
TOLUA_API int  tolua_PixelGraySprite_luabinding_open (lua_State* tolua_S);
#endif // __MAPRUNTIMEC_LUABINDING_H_