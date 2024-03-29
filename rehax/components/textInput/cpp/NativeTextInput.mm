#include "NativeTextInput.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface FunctionalNSTextField : NSTextField <NSTextFieldDelegate>
{
  @public
  std::function<void(void)> callback;
}

- (void)setCallback:(std::function<void(void)>)callback;
- (void)controlTextDidChange:(id)notification;

@end

@implementation FunctionalNSTextField

- (void)setCallback:(std::function<void(void)>)cb
{
  self.delegate = self;
  callback = cb;
}

- (void)controlTextDidChange:(id)notification
{
  callback();
}

@end

void NativeTextInput::createFragment() {
  NSTextField * view = [FunctionalNSTextField new];
  [view setFrame:NSMakeRect(0, 0, 200, 200)];
  [view setStringValue:@""];
  view.editable = YES;
  view.bezeled = NO;
  [view setBackgroundColor:[NSColor clearColor]];
  [view sizeToFit];
  // [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
  nativeView = (void *) CFBridgingRetain(view);
}

// void NativeText::mount(NativeView *parent)
// {
//   NSView * parentView = (__bridge NSView *) parent->nativeView;
//   NSView * view = (__bridge NSView *) nativeView;
//   view.wantsLayer = true;
//   [parentView addSubview: view];
// }

void NativeTextInput::setText(const char * text)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  [view setStringValue: [NSString stringWithUTF8String: text]];
  [view sizeToFit];
}

const char * NativeTextInput::getText()
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  return [view stringValue].UTF8String;
}

void NativeTextInput::setPlaceholder(const char *text)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  view.placeholderString = [NSString stringWithUTF8String: text];
}

void NativeTextInput::setTextColor(NativeColor color)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  NSColor * c = [NSColor colorWithRed:color.r green:color.g blue:color.b alpha:color.a];
  [view setTextColor:c];
}

void NativeTextInput::setTextAlignment(int alignment)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  switch (alignment) {
    case 0:
      [view setAlignment:NSTextAlignmentLeft];
      break;
    case 1:
      [view setAlignment:NSTextAlignmentCenter];
      break;
    case 2:
      [view setAlignment:NSTextAlignmentRight];
      break;
  }
}

void NativeTextInput::addView(NativeView * child)
{
  NativeView::addView(child);
  NSTextField * view = (__bridge NSTextField *) nativeView;
  [view sizeToFit];
}

void NativeTextInput::setOnValueChange(std::function<void(void)> onValueChange)
{
  FunctionalNSTextField * view = (__bridge FunctionalNSTextField *) nativeView;
  [view setCallback:onValueChange];
}
