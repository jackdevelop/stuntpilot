/*
** Lua binding: NavMesh_luabinding
** Generated automatically by tolua++-1.0.92 on 01/09/14 12:18:39.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_NavMesh_luabinding_open (lua_State* tolua_S);

#include "NavMesh.h"

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"NavMesh");
}

/* method: init of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_init00
static int tolua_NavMesh_luabinding_NavMesh_init00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"NavMesh",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_istable(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int count = ((int)  tolua_tonumber(tolua_S,2,0));
#ifdef __cplusplus
  int* arr = Mtolua_new_dim(int, count);
#else
  int* arr = (int*) malloc((count)*sizeof(int));
#endif
  {
#ifndef TOLUA_RELEASE
   if (!tolua_isnumberarray(tolua_S,3,count,0,&tolua_err))
    goto tolua_lerror;
   else
#endif
   {
    int i;
    for(i=0; i<count;i++)
    arr[i] = ((int)  tolua_tofieldnumber(tolua_S,3,i+1,0));
   }
  }
  {
   NavMesh::init(count,arr);
  }
  {
   int i;
   for(i=0; i<count;i++)
    tolua_pushfieldnumber(tolua_S,3,i+1,(lua_Number) arr[i]);
  }
#ifdef __cplusplus
  Mtolua_delete_dim(arr);
#else
  free(arr);
#endif
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'init'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_create00
static int tolua_NavMesh_luabinding_NavMesh_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"NavMesh",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   NavMesh* tolua_ret = (NavMesh*)  NavMesh::create();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"NavMesh");
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

/* method: destroy of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_destroy00
static int tolua_NavMesh_luabinding_NavMesh_destroy00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"NavMesh",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   NavMesh::destroy();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'destroy'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: findPath of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_findPath00
static int tolua_NavMesh_luabinding_NavMesh_findPath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NavMesh",0,&tolua_err) ||
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
  NavMesh* self = (NavMesh*)  tolua_tousertype(tolua_S,1,0);
  int startX = ((int)  tolua_tonumber(tolua_S,2,0));
  int startY = ((int)  tolua_tonumber(tolua_S,3,0));
  int endX = ((int)  tolua_tonumber(tolua_S,4,0));
  int endY = ((int)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'findPath'", NULL);
#endif
  {
   int tolua_ret = (int)  self->findPath(startX,startY,endX,endY);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'findPath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getPath of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_getPath00
static int tolua_NavMesh_luabinding_NavMesh_getPath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NavMesh",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_istable(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NavMesh* self = (NavMesh*)  tolua_tousertype(tolua_S,1,0);
  int count = ((int)  tolua_tonumber(tolua_S,2,0));
#ifdef __cplusplus
  int* arr = Mtolua_new_dim(int, count);
#else
  int* arr = (int*) malloc((count)*sizeof(int));
#endif
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getPath'", NULL);
#endif
  {
#ifndef TOLUA_RELEASE
   if (!tolua_isnumberarray(tolua_S,3,count,0,&tolua_err))
    goto tolua_lerror;
   else
#endif
   {
    int i;
    for(i=0; i<count;i++)
    arr[i] = ((int)  tolua_tofieldnumber(tolua_S,3,i+1,0));
   }
  }
  {
   self->getPath(count,arr);
  }
  {
   int i;
   for(i=0; i<count;i++)
    tolua_pushfieldnumber(tolua_S,3,i+1,(lua_Number) arr[i]);
  }
#ifdef __cplusplus
  Mtolua_delete_dim(arr);
#else
  free(arr);
#endif
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getPath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: printPath of class  NavMesh */
#ifndef TOLUA_DISABLE_tolua_NavMesh_luabinding_NavMesh_printPath00
static int tolua_NavMesh_luabinding_NavMesh_printPath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NavMesh",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NavMesh* self = (NavMesh*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'printPath'", NULL);
#endif
  {
   self->printPath();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'printPath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_NavMesh_luabinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"NavMesh","NavMesh","",NULL);
  tolua_beginmodule(tolua_S,"NavMesh");
   tolua_function(tolua_S,"init",tolua_NavMesh_luabinding_NavMesh_init00);
   tolua_function(tolua_S,"create",tolua_NavMesh_luabinding_NavMesh_create00);
   tolua_function(tolua_S,"destroy",tolua_NavMesh_luabinding_NavMesh_destroy00);
   tolua_function(tolua_S,"findPath",tolua_NavMesh_luabinding_NavMesh_findPath00);
   tolua_function(tolua_S,"getPath",tolua_NavMesh_luabinding_NavMesh_getPath00);
   tolua_function(tolua_S,"printPath",tolua_NavMesh_luabinding_NavMesh_printPath00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_NavMesh_luabinding (lua_State* tolua_S) {
 return tolua_NavMesh_luabinding_open(tolua_S);
};
#endif

