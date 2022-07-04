#pragma once

#include "../../view/cpp/NativeView.h"

class NativeFragment : public NativeView
{
public:
  RHX_EXPORT void createFragment() override
  {
  }

  // RHX_EXPORT void mount(NativeView *parent) override
  // {
  // }
};

#if target_lua

void luaDefineFragment(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeFragment> clazz = lua.new_usertype<NativeFragment>("NativeFragment", sol::constructors<NativeFragment()>(), sol::base_classes, sol::bases<NativeView>());
  clazz["createFragment"] = &NativeFragment::createFragment;
  // clazz["mount"] = &NativeFragment::mount;
}

#endif
