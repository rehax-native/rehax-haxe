#include "NativeGesture.h"
#import <Cocoa/Cocoa.h>

@interface RehaxGestureRecognizer : NSGestureRecognizer
{
    @public

    std::function<void(void)> callback;
    std::function<void(float, float)> onMouseDownCb;
    std::function<void(float, float)> onMouseUpCb;
    std::function<void(float, float)> onMouseMoveCb;
}

- (void) performAction;

@end

@implementation RehaxGestureRecognizer

- (void) mouseDown:(NSEvent *) event
{
    NSPoint event_location = event.locationInWindow;
    NSPoint local_point = [self.view convertPoint:event_location fromView:nil];

    onMouseDownCb(local_point.x, local_point. y);
}

- (void) mouseUp:(NSEvent *) event
{
    NSPoint event_location = event.locationInWindow;
    NSPoint local_point = [self.view convertPoint:event_location fromView:nil];

    onMouseUpCb(local_point.x, local_point. y);
}

- (void) mouseDragged:(NSEvent *) event
{
    NSPoint event_location = event.locationInWindow;
    NSPoint local_point = [self.view convertPoint:event_location fromView:nil];

    onMouseMoveCb(local_point.x, local_point. y);
}

- (void) performAction
{
    callback();
}

@end

void NativeGesture::setup(std::function<void(void)> action, std::function<void(float, float)> onMouseDown, std::function<void(float, float)> onMouseUp, std::function<void(float, float)> onMouseMove)
{
    RehaxGestureRecognizer * rec = [RehaxGestureRecognizer new];

    rec->callback = action;
    rec->onMouseDownCb = onMouseDown;
    rec->onMouseUpCb = onMouseUp;
    rec->onMouseMoveCb = onMouseMove;

    [rec setTarget:rec];
    [rec setAction:@selector(performAction)];

    native = (void *) CFBridgingRetain(rec);
}

void NativeGesture::setState(int state)
{
    NSGestureRecognizer * rec = (__bridge NSGestureRecognizer *) native;

    // Possible;
    // Recognized;
    // Began;
    // Changed;
    // Canceled;
    // Ended;

    switch (state) {
        case 0:
            rec.state = NSGestureRecognizerStatePossible;
            break;
        case 1:
            rec.state = NSGestureRecognizerStateRecognized;
            break;
        case 2:
            rec.state = NSGestureRecognizerStateBegan;
            break;
        case 3:
            rec.state = NSGestureRecognizerStateChanged;
            break;
        case 4:
            rec.state = NSGestureRecognizerStateCancelled;
            break;
        case 5:
            rec.state = NSGestureRecognizerStateEnded;
            break;
    }
}
