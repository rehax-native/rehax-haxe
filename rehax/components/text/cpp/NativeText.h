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
