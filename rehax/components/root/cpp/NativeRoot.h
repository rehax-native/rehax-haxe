#pragma once

#include "../../view/cpp/NativeView.h"
#include <functional>

class NativeRoot : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;
  RHX_EXPORT void addView(NativeView * child) override;
  RHX_EXPORT void initialize(std::function<void(void)> onReady);
};

#if target_lua

void luaDefineRoot(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeRoot> clazz = lua.new_usertype<NativeRoot>("NativeRoot", sol::constructors<NativeRoot()>(), sol::base_classes, sol::bases<NativeView>());
  clazz["createFragment"] = &NativeRoot::createFragment;
  clazz["addView"] = &NativeRoot::addView;
  clazz["initialize"] = &NativeRoot::initialize;
}

#endif
