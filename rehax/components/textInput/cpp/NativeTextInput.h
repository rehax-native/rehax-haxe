#pragma once

#include "../../view/cpp/NativeView.h"

class NativeTextInput : public NativeView
{
public:
  void createFragment() override;
  // void mount(NativeView *parent) override;

  void setText(const char *text);
  const char *getText();

  void setTextColor(NativeColor color);
  void addView(NativeView *child) override;
};
