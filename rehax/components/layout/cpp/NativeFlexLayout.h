#pragma once

#include <vector>
#include "../../view/cpp/NativeView.h"

struct NativeFlexItem {
  float flexGrow;
  bool hasFlexGrow;
  int alignSelf = -1;
};

class NativeFlexLayout : public INativeLayout
{
public:
  RHX_EXPORT NativeFlexLayout();
  RHX_EXPORT ~NativeFlexLayout();

  RHX_EXPORT void setOptions(
    bool isHorizontal,
    bool isReverse, 
    int justifyContent,
    int alignItems
  );
  RHX_EXPORT void layoutContainer(NativeView* container);
  RHX_EXPORT void cleanUp(NativeView* container);

  RHX_EXPORT void clearItems();
  RHX_EXPORT void addItem(NativeFlexItem item);

private:
  std::vector<NativeFlexItem> items;

  bool isHorizontal;
  bool isReverse;
  int justifyContent;
  int alignItems;

  void * nativeInfo = nullptr;
};
