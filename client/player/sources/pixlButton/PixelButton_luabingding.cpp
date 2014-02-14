/*
** Lua binding: PixelButton_luabinding
** Generated automatically by tolua++-1.0.92 on 07/27/13 16:22:03.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_PixelButton_luabinding_open (lua_State* tolua_S);

#include "CCControlButton.h"
#include "CCScale9Sprite.h"
#include "PixelButton.h"
using namespace std;
using namespace cocos2d;

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"CCEvent");
 tolua_usertype(tolua_S,"CCTouch");
 tolua_usertype(tolua_S,"PixelButton");
 tolua_usertype(tolua_S,"CCControlButton");
}

/* method: init of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_init00
static int tolua_PixelButton_luabinding_PixelButton_init00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'init'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->init();
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'init'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_create00
static int tolua_PixelButton_luabinding_PixelButton_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   PixelButton* tolua_ret = (PixelButton*)  PixelButton::create();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"PixelButton");
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

/* method: create of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_create01
static int tolua_PixelButton_luabinding_PixelButton_create01(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,3,0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  std::string normalSprite = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  std::string selectedSprite = ((std::string)  tolua_tocppstring(tolua_S,3,0));
  std::string disabledSprite = ((std::string)  tolua_tocppstring(tolua_S,4,0));
  {
   PixelButton* tolua_ret = (PixelButton*)  PixelButton::create(normalSprite,selectedSprite,disabledSprite);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"PixelButton");
  }
 }
 return 1;
tolua_lerror:
 return tolua_PixelButton_luabinding_PixelButton_create00(tolua_S);
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_create02
static int tolua_PixelButton_luabinding_PixelButton_create02(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,3,0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,4,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  std::string normalSprite = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  std::string selectedSprite = ((std::string)  tolua_tocppstring(tolua_S,3,0));
  std::string disabledSprite = ((std::string)  tolua_tocppstring(tolua_S,4,0));
  bool isZoomOnTouchDown = ((bool)  tolua_toboolean(tolua_S,5,0));
  {
   PixelButton* tolua_ret = (PixelButton*)  PixelButton::create(normalSprite,selectedSprite,disabledSprite,isZoomOnTouchDown);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"PixelButton");
  }
 }
 return 1;
tolua_lerror:
 return tolua_PixelButton_luabinding_PixelButton_create01(tolua_S);
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_create03
static int tolua_PixelButton_luabinding_PixelButton_create03(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,1,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  std::string srcName = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  bool isZoomOnTouchDown = ((bool)  tolua_toboolean(tolua_S,3,false));
  {
   PixelButton* tolua_ret = (PixelButton*)  PixelButton::create(srcName,isZoomOnTouchDown);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"PixelButton");
  }
 }
 return 1;
tolua_lerror:
 return tolua_PixelButton_luabinding_PixelButton_create02(tolua_S);
}
#endif //#ifndef TOLUA_DISABLE

/* get function: clickX of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_get_PixelButton_clickX
static int tolua_get_PixelButton_clickX(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'clickX'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->clickX);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: clickX of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_set_PixelButton_clickX
static int tolua_set_PixelButton_clickX(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'clickX'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->clickX = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: clickY of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_get_PixelButton_clickY
static int tolua_get_PixelButton_clickY(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'clickY'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->clickY);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: clickY of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_set_PixelButton_clickY
static int tolua_set_PixelButton_clickY(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'clickY'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->clickY = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: m_src of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_get_PixelButton_m_src
static int tolua_get_PixelButton_m_src(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'm_src'",NULL);
#endif
  tolua_pushcppstring(tolua_S,(const char*)self->m_src);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: m_src of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_set_PixelButton_m_src
static int tolua_set_PixelButton_m_src(lua_State* tolua_S)
{
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'm_src'",NULL);
  if (!tolua_iscppstring(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->m_src = ((string)  tolua_tocppstring(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: onEnter of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_onEnter00
static int tolua_PixelButton_luabinding_PixelButton_onEnter00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'onEnter'", NULL);
#endif
  {
   self->onEnter();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'onEnter'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: onExit of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_onExit00
static int tolua_PixelButton_luabinding_PixelButton_onExit00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'onExit'", NULL);
#endif
  {
   self->onExit();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'onExit'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: ccTouchBegan of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_ccTouchBegan00
static int tolua_PixelButton_luabinding_PixelButton_ccTouchBegan00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCTouch",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"CCEvent",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
  CCTouch* pTouch = ((CCTouch*)  tolua_tousertype(tolua_S,2,0));
  CCEvent* pEvent = ((CCEvent*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'ccTouchBegan'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->ccTouchBegan(pTouch,pEvent);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'ccTouchBegan'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: ccTouchMoved of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_ccTouchMoved00
static int tolua_PixelButton_luabinding_PixelButton_ccTouchMoved00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCTouch",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"CCEvent",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
  CCTouch* pTouch = ((CCTouch*)  tolua_tousertype(tolua_S,2,0));
  CCEvent* pEvent = ((CCEvent*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'ccTouchMoved'", NULL);
#endif
  {
   self->ccTouchMoved(pTouch,pEvent);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'ccTouchMoved'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: ccTouchEnded of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_ccTouchEnded00
static int tolua_PixelButton_luabinding_PixelButton_ccTouchEnded00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCTouch",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"CCEvent",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
  CCTouch* pTouch = ((CCTouch*)  tolua_tousertype(tolua_S,2,0));
  CCEvent* pEvent = ((CCEvent*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'ccTouchEnded'", NULL);
#endif
  {
   self->ccTouchEnded(pTouch,pEvent);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'ccTouchEnded'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: ccTouchCancelled of class  PixelButton */
#ifndef TOLUA_DISABLE_tolua_PixelButton_luabinding_PixelButton_ccTouchCancelled00
static int tolua_PixelButton_luabinding_PixelButton_ccTouchCancelled00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"PixelButton",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCTouch",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"CCEvent",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  PixelButton* self = (PixelButton*)  tolua_tousertype(tolua_S,1,0);
  CCTouch* pTouch = ((CCTouch*)  tolua_tousertype(tolua_S,2,0));
  CCEvent* pEvent = ((CCEvent*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'ccTouchCancelled'", NULL);
#endif
  {
   self->ccTouchCancelled(pTouch,pEvent);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'ccTouchCancelled'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_PixelButton_luabinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"PixelButton","PixelButton","CCControlButton",NULL);
  tolua_beginmodule(tolua_S,"PixelButton");
   tolua_function(tolua_S,"init",tolua_PixelButton_luabinding_PixelButton_init00);
   tolua_function(tolua_S,"create",tolua_PixelButton_luabinding_PixelButton_create00);
   tolua_function(tolua_S,"create",tolua_PixelButton_luabinding_PixelButton_create01);
   tolua_function(tolua_S,"create",tolua_PixelButton_luabinding_PixelButton_create02);
   tolua_function(tolua_S,"create",tolua_PixelButton_luabinding_PixelButton_create03);
   tolua_variable(tolua_S,"clickX",tolua_get_PixelButton_clickX,tolua_set_PixelButton_clickX);
   tolua_variable(tolua_S,"clickY",tolua_get_PixelButton_clickY,tolua_set_PixelButton_clickY);
   tolua_variable(tolua_S,"m_src",tolua_get_PixelButton_m_src,tolua_set_PixelButton_m_src);
   tolua_function(tolua_S,"onEnter",tolua_PixelButton_luabinding_PixelButton_onEnter00);
   tolua_function(tolua_S,"onExit",tolua_PixelButton_luabinding_PixelButton_onExit00);
   tolua_function(tolua_S,"ccTouchBegan",tolua_PixelButton_luabinding_PixelButton_ccTouchBegan00);
   tolua_function(tolua_S,"ccTouchMoved",tolua_PixelButton_luabinding_PixelButton_ccTouchMoved00);
   tolua_function(tolua_S,"ccTouchEnded",tolua_PixelButton_luabinding_PixelButton_ccTouchEnded00);
   tolua_function(tolua_S,"ccTouchCancelled",tolua_PixelButton_luabinding_PixelButton_ccTouchCancelled00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_PixelButton_luabinding (lua_State* tolua_S) {
 return tolua_PixelButton_luabinding_open(tolua_S);
};
#endif

