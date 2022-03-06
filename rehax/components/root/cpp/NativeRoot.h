#pragma once

#include "../../view/cpp/NativeView.h"
#include <functional>

class NativeRoot : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;
  // void addView(NativeView * child) override;
  RHX_EXPORT void initialize(std::function<void(void)> onReady);
};
