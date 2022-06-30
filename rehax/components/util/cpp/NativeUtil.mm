#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include "NativeUtil.h"

void NativeUtil::openUrl(const char * url)
{
    NSString * nsUrl = [NSString stringWithUTF8String:url];
    NSURL * nsUrlObj = [NSURL URLWithString:nsUrl];
    [[NSWorkspace sharedWorkspace] openURL:nsUrlObj];
}

NativeTimer * NativeUtil::startInterval(int intervalMs, std::function<void(void)> tick)
{
    NSTimer * nativeTimer = [NSTimer scheduledTimerWithTimeInterval:(float)intervalMs / 1000.0
                                                            repeats:YES
                                                                block:^ (NSTimer *timer) {
        tick();
    }];
    NativeTimer * timer = new NativeTimer();
    timer->timer = nativeTimer;
    return timer;
}

void NativeUtil::stopTimer(NativeTimer * timer)
{
    [timer->timer invalidate];
    timer->timer = nullptr;
    delete timer;
}
