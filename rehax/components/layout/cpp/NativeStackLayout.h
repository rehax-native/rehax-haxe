#pragma once

#include "../../view/cpp/NativeView.h"

class NativeStackLayout : public INativeLayout
{
public:
  RHX_EXPORT NativeStackLayout();
  RHX_EXPORT NativeStackLayout(bool isHorizontal, float spacing);
  RHX_EXPORT ~NativeStackLayout();
  RHX_EXPORT void layoutContainer(NativeView* container);
  RHX_EXPORT void cleanUp(NativeView* container);

private:
  float spacing = 0.0;
  bool isHorizontal = false;
  void * nativeInfo = nullptr;
};

#if target_lua

void luaDefineStackLayout(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeStackLayout> clazz = lua.new_usertype<NativeStackLayout>("NativeStackLayout", sol::constructors<NativeStackLayout(), NativeStackLayout(bool, float)>(), sol::base_classes, sol::bases<INativeLayout>());
  clazz["layoutContainer"] = &NativeStackLayout::layoutContainer;
  clazz["cleanUp"] = &NativeStackLayout::cleanUp;
}

#endif
