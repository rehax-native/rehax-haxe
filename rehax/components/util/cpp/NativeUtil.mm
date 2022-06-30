#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include "NativeUtil.h"

void NativeUtil::openUrl(const char * url)
{
    NSString * nsUrl = [NSString stringWithUTF8String:url];
    NSURL * nsUrlObj = [NSURL URLWithString:nsUrl];
    [[NSWorkspace sharedWorkspace] openURL:nsUrlObj];
}
