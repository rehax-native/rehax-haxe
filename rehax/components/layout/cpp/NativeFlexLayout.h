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

#if target_lua

void luaDefineFlexLayout(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeFlexItem> clazzItem = lua.new_usertype<NativeFlexItem>("NativeFlexItem", sol::constructors<NativeFlexItem()>());
  clazzItem["flexGrow"] = &NativeFlexItem::flexGrow;
  clazzItem["hasFlexGrow"] = &NativeFlexItem::hasFlexGrow;
  clazzItem["alignSelf"] = &NativeFlexItem::alignSelf;

  sol::usertype<NativeFlexLayout> clazz = lua.new_usertype<NativeFlexLayout>("NativeFlexLayout", sol::constructors<NativeFlexLayout()>(), sol::base_classes, sol::bases<INativeLayout>());
  clazz["setOptions"] = &NativeFlexLayout::setOptions;
  clazz["layoutContainer"] = &NativeFlexLayout::layoutContainer;
  clazz["cleanUp"] = &NativeFlexLayout::cleanUp;
  clazz["clearItems"] = &NativeFlexLayout::clearItems;
  clazz["addItem"] = &NativeFlexLayout::addItem;
}

#endif
