#include "NativeRoot.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface NativeRootView : NSView
- (BOOL)isFlipped;
@end

@implementation NativeRootView
- (BOOL)isFlipped {
    return YES;
}
@end


void NativeRoot::initialize(std::function<void(void)> onReady) {
  @autoreleasepool {
    NSRect frame = NSMakeRect(200, 200, 600, 600);
    NSWindow* window = [[NSWindow alloc] initWithContentRect:frame
                        // styleMask: NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskUnifiedTitleAndToolbar | NSWindowStyleMaskFullSizeContentView
                        styleMask: NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskUnifiedTitleAndToolbar
                        backing:NSBackingStoreBuffered
                        defer:NO];

    NSView * view = [NativeRootView new];
    // [view setFrame:NSMakeRect(0, 0, 600, 600)];
    [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    view.translatesAutoresizingMaskIntoConstraints = YES;

    [window setContentView:view];

    [window makeKeyAndOrderFront:NSApp];
    // nativeBackend = (void *) CFBridgingRetain(window);
    nativeView = (void *) CFBridgingRetain(view);

    onReady();

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp run];
  }
}

void NativeRoot::createFragment()
{
}

// void NativeRoot::addView(NativeView * child)
// {
//   NativeView::addView(child);
//   NSView * view = (__bridge NSView *) nativeView;
//   NSView * childView = (__bridge NSView *) child->nativeView;
//   [childView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
//   [childView setFrame:[view bounds]];
// }