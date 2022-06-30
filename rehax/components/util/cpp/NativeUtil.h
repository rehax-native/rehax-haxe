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
