#include "NativeButton.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface FunctionalNSButton : NSButton
{
  @public
  std::function<void(void)> callback;
}

- (void)setOnClick:(std::function<void(void)>)callback;
- (void)onClick:(id)sender;

@end

@implementation FunctionalNSButton

- (void)setOnClick:(std::function<void(void)>)cb
{
  callback = cb;
  [self setTarget:self];
  [self setAction:@selector(onClick:)];
}

- (void)onClick:(id)sender
{
  callback();
}

@end

void NativeButton::createFragment() {
  FunctionalNSButton * view = [FunctionalNSButton new];
  [view setFrame:NSMakeRect(0, 0, 200, 200)];
  [view setTitle:@""];
  view.bezelStyle = NSBezelStyleRounded;
  // [view sizeToFit];
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

void NativeButton::setText(const char * text)
{
  FunctionalNSButton * view = (__bridge FunctionalNSButton *) nativeView;
  [view setTitle: [NSString stringWithUTF8String: text]];
  // [view sizeToFit];
}

const char * NativeButton::getText()
{
  FunctionalNSButton * view = (__bridge FunctionalNSButton *) nativeView;
  return [view stringValue].UTF8String;
}

void NativeButton::setTextColor(NativeColor color)
{
  // NSButton * view = (__bridge NSButton *) nativeView;
  // NSColor * c = [NSColor colorWithRed:color.r green:color.g blue:color.b alpha:color.a];
  // [view setTextColor:c];
}

void NativeButton::addView(NativeView * child)
{
  NativeView::addView(child);
  // NSButton * view = (__bridge NSButton *) nativeView;
  // [view sizeToFit];
}

void NativeButton::setOnClick(std::function<void(void)> onClick)
{
  FunctionalNSButton * view = (__bridge FunctionalNSButton *) nativeView;
  [view setOnClick:onClick];
}