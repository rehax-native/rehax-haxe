#pragma once

#include <functional>
#include "../../view/cpp/NativeView.h"

class NativeButton : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;

  RHX_EXPORT void setText(const char *text);
  RHX_EXPORT const char *getText();

  RHX_EXPORT void setTextColor(NativeColor color);
  RHX_EXPORT void addView(NativeView *child) override;

  RHX_EXPORT void setOnClick(std::function<void(void)> onClick);
};


#if target_lua

void luaDefineButton(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeButton> clazz = lua.new_usertype<NativeButton>("NativeButton", sol::constructors<NativeButton()>(), sol::base_classes, sol::bases<NativeView>());
  clazz["createFragment"] = &NativeButton::createFragment;
  clazz["addView"] = &NativeButton::addView;
  clazz["setText"] = &NativeButton::setText;
  clazz["getText"] = &NativeButton::getText;
  clazz["setTextColor"] = &NativeButton::setTextColor;
  clazz["setOnClick"] = &NativeButton::setOnClick;
}

#endif
