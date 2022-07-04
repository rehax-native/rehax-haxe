#pragma once

#include <functional>
#include "../../view/cpp/NativeView.h"

#if __OBJC__
@class NSTimer;
#else
typedef void NSTimer;
#endif

class NativeTimer {
private:
    NSTimer * timer;
  
    friend class NativeUtil;
};

class NativeUtil
{
public:
  RHX_EXPORT static void openUrl(const char * url);

  RHX_EXPORT static NativeTimer * startInterval(int intervalMs, std::function<void(void)> tick);
  RHX_EXPORT static void stopTimer(NativeTimer * timer);
};

#if target_lua

void luaDefineUtil(lua_State *state) {
	sol::state_view lua(state);

  sol::usertype<NativeTimer> clazzTimer = lua.new_usertype<NativeTimer>("NativeTimer", sol::constructors<NativeTimer()>());

  sol::usertype<NativeUtil> clazz = lua.new_usertype<NativeUtil>("NativeUtil", sol::constructors<NativeUtil()>());
  clazz["openUrl"] = &NativeUtil::openUrl;
  clazz["startInterval"] = &NativeUtil::startInterval;
  clazz["stopTimer"] = &NativeUtil::stopTimer;
}

#endif
