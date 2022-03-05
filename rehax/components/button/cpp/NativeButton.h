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
