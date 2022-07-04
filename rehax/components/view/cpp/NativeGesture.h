#pragma once

#include <functional>
#include "./NativeView.h"

class NativeGesture {

public:
  void setup(std::function<void(void)> action, std::function<void(float, float)> onMouseDown, std::function<void(float, float)> onMouseUp, std::function<void(float, float)> onMouseMove);
  void setState(int state);
  void destroy();

  void * native;
};

#if target_lua

void luaDefineGesture(lua_State *state) {
  sol::state_view lua(state);

  sol::usertype<NativeGesture> clazz = lua.new_usertype<NativeGesture>("NativeGesture", sol::constructors<NativeGesture()>());
  clazz["setup"] = &NativeGesture::setup;
  clazz["setState"] = &NativeGesture::setState;
  clazz["destroy"] = &NativeGesture::destroy;

}

#endif
