#pragma once

#include "../../view/cpp/NativeView.h"

class NativeFlexLayout : public INativeLayout
{
public:
  RHX_EXPORT NativeFlexLayout();
  RHX_EXPORT NativeFlexLayout(bool isHorizontal, bool isReverse);
  RHX_EXPORT void layoutContainer(NativeView* container);

private:
  bool isHorizontal = false;
  bool isReverse = false;
};
