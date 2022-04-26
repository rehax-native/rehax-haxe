#pragma once

#include "../../view/cpp/NativeView.h"

class NativeStackLayout : public INativeLayout
{
public:
  RHX_EXPORT NativeStackLayout();
  RHX_EXPORT NativeStackLayout(bool isHorizontal, float spacing);
  RHX_EXPORT void layoutContainer(NativeView* container);

private:
  float spacing = 0.0;
  bool isHorizontal = false;
};
