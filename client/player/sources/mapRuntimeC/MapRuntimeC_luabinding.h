
#ifndef __MAPRUNTIMEC_LUABINDING_H_
#define __MAPRUNTIMEC_LUABINDING_H_

extern "C" {
#include "lua.h"
#include "tolua++.h"
#include "tolua_fix.h"
}

TOLUA_API int luaopen_MapRuntimeC_luabinding(lua_State* tolua_S);
//TOLUA_API int luaopen_XYMainButton_luabinding(lua_State* tolua_S);
#endif // __MAPRUNTIMEC_LUABINDING_H_
