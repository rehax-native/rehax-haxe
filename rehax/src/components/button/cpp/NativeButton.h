#pragma once

#include <functional>
#include "../../view/cpp/NativeView.h"

class NativeButton : public NativeView
{
public:
  void createFragment() override;

  void setText(const char *text);
  const char *getText();

  void setTextColor(NativeColor color);
  void addView(NativeView *child) override;

  void setOnClick(std::function<void(void)> onClick);
};
