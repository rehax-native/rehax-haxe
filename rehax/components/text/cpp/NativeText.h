#pragma once

#include <vector>
#include "../../view/cpp/NativeView.h"

class NativeText : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;
  // void mount(NativeView *parent) override;

  RHX_EXPORT void setText(const char *text);
  RHX_EXPORT const char *getText();

  RHX_EXPORT void setTextColor(NativeColor color);
  RHX_EXPORT void setFontSize(float size);
  RHX_EXPORT void setFontFamilies(std::vector<std::string> fontFamilies);
  RHX_EXPORT void addView(NativeView *child) override;
};

#if target_lua

void luaDefineText(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeText> clazz = lua.new_usertype<NativeText>("NativeText", sol::constructors<NativeText()>(), sol::base_classes, sol::bases<NativeView>());
  clazz["createFragment"] = &NativeText::createFragment;
  clazz["setText"] = &NativeText::setText;
  clazz["getText"] = &NativeText::getText;
  clazz["setTextColor"] = &NativeText::setTextColor;
  clazz["setFontSize"] = &NativeText::setFontSize;
  clazz["setFontFamilies"] = &NativeText::setFontFamilies;
  clazz["addView"] = &NativeText::addView;
}

#endif
