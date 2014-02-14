/*
** Lua binding: PixelGraySprite_luabinding
** Generated automatically by tolua++-1.0.92 on 07/26/13 13:46:08.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_PixelGraySprite_luabinding_open (lua_State* tolua_S);

#include "PixelGraySprite.h"
using namespace GameLuabinding;

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"PixelGraySprite");
 tolua_usertype(tolua_S,"CCSprite");
}

/* method: create of class  PixelGraySprite */
#ifndef TOLUA_DISABLE_tolua_PixelGraySprite_luabinding_PixelGraySprite_create00
static int tolua_PixelGraySprite_luabinding_PixelGraySprite_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"PixelGraySprite",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   PixelGraySprite* tolua_ret = (PixelGraySprite*)  PixelGraySprite::create();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"PixelGraySprite");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: graylightWithCCSprite of class  PixelGraySprite */
#ifndef TOLUA_DISABLE_tolua_PixelGraySprite_luabinding_PixelGraySprite_graylightWithCCSprite00
static int tolua_PixelGraySprite_luabinding_PixelGraySprite_graylightWithCCSprite00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelGraySprite",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCSprite",0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelGraySprite* self = (PixelGraySprite*)  tolua_tousertype(tolua_S,1,0);
  CCSprite* oldSprite = ((CCSprite*)  tolua_tousertype(tolua_S,2,0));
  bool isLight = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'graylightWithCCSprite'", NULL);
#endif
  {
   CCSprite* tolua_ret = (CCSprite*)  self->graylightWithCCSprite(oldSprite,isLight);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CCSprite");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'graylightWithCCSprite'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_PixelGraySprite_luabinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"PixelGraySprite","PixelGraySprite","",NULL);
  tolua_beginmodule(tolua_S,"PixelGraySprite");
   tolua_function(tolua_S,"create",tolua_PixelGraySprite_luabinding_PixelGraySprite_create00);
   tolua_function(tolua_S,"graylightWithCCSprite",tolua_PixelGraySprite_luabinding_PixelGraySprite_graylightWithCCSprite00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_PixelGraySprite_luabinding (lua_State* tolua_S) {
 return tolua_PixelGraySprite_luabinding_open(tolua_S);
};
#endif

