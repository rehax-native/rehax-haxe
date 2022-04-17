#pragma once

#include <vector>
#include "../../view/cpp/NativeView.h"

struct NativeFlexItem {
  float flexGrow;
  bool hasFlexGrow;
};

class NativeFlexLayout : public INativeLayout
{
public:
  RHX_EXPORT NativeFlexLayout();
  RHX_EXPORT NativeFlexLayout(bool isHorizontal, bool isReverse);
  RHX_EXPORT void layoutContainer(NativeView* container);

  RHX_EXPORT void clearItems();
  RHX_EXPORT void addItem(NativeFlexItem item);

private:
  std::vector<NativeFlexItem> items;
  bool isHorizontal = false;
  bool isReverse = false;
};
