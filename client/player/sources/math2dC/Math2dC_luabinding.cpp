/*
** Lua binding: Math2dC_luabinding
** Generated automatically by tolua++-1.0.92 on 01/15/14 12:22:34.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_Math2dC_luabinding_open (lua_State* tolua_S);

#include <Math2dC.h>

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"Math2dC");
}

/* method: distByFloat of class  Math2dC */
#ifndef TOLUA_DISABLE_tolua_Math2dC_luabinding_Math2dC_distByFloat00
static int tolua_Math2dC_luabinding_Math2dC_distByFloat00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"Math2dC",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  float ax = ((float)  tolua_tonumber(tolua_S,2,0));
  float ay = ((float)  tolua_tonumber(tolua_S,3,0));
  float bx = ((float)  tolua_tonumber(tolua_S,4,0));
  float by = ((float)  tolua_tonumber(tolua_S,5,0));
  {
   float tolua_ret = (float)  Math2dC::distByFloat(ax,ay,bx,by);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'distByFloat'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: dist of class  Math2dC */
#ifndef TOLUA_DISABLE_tolua_Math2dC_luabinding_Math2dC_dist00
static int tolua_Math2dC_luabinding_Math2dC_dist00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"Math2dC",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int ax = ((int)  tolua_tonumber(tolua_S,2,0));
  int ay = ((int)  tolua_tonumber(tolua_S,3,0));
  int bx = ((int)  tolua_tonumber(tolua_S,4,0));
  int by = ((int)  tolua_tonumber(tolua_S,5,0));
  {
   int tolua_ret = (int)  Math2dC::dist(ax,ay,bx,by);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'dist'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_Math2dC_luabinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"Math2dC","Math2dC","",NULL);
  tolua_beginmodule(tolua_S,"Math2dC");
   tolua_function(tolua_S,"distByFloat",tolua_Math2dC_luabinding_Math2dC_distByFloat00);
   tolua_function(tolua_S,"dist",tolua_Math2dC_luabinding_Math2dC_dist00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_Math2dC_luabinding (lua_State* tolua_S) {
 return tolua_Math2dC_luabinding_open(tolua_S);
};
#endif

