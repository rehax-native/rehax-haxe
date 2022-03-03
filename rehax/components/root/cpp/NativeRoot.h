#pragma once

#include "../../view/cpp/NativeView.h"
#include <functional>

class NativeRoot : public NativeView
{
public:
  void createFragment() override;
  // void addView(NativeView * child) override;
  void initialize(std::function<void(void)> onReady);
};
