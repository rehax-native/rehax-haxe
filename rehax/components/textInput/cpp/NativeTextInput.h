#pragma once

#include "../../view/cpp/NativeView.h"
#include <functional>

class NativeTextInput : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;
  // void mount(NativeView *parent) override;

  RHX_EXPORT void setText(const char *text);
  RHX_EXPORT const char *getText();

  RHX_EXPORT void setOnValueChange(std::function<void(void)> onValueChange);

  RHX_EXPORT void setPlaceholder(const char *text);

  RHX_EXPORT void setTextAlignment(int alignment);
  RHX_EXPORT void setTextColor(NativeColor color);
  RHX_EXPORT void addView(NativeView *child) override;
};

#if target_lua

void luaDefineTextInput(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeTextInput> clazz = lua.new_usertype<NativeTextInput>("NativeTextInput", sol::constructors<NativeTextInput()>(), sol::base_classes, sol::bases<NativeView>());
  clazz["createFragment"] = &NativeTextInput::createFragment;
  clazz["setText"] = &NativeTextInput::setText;
  clazz["getText"] = &NativeTextInput::getText;
  clazz["setOnValueChange"] = &NativeTextInput::setOnValueChange;
  clazz["setPlaceholder"] = &NativeTextInput::setPlaceholder;
  clazz["setTextAlignment"] = &NativeTextInput::setTextAlignment;
  clazz["setTextColor"] = &NativeTextInput::setTextColor;
  clazz["addView"] = &NativeTextInput::addView;
}

#endif
