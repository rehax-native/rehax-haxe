#include "NativeText.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

void NativeText::createFragment() {
  NSTextField * view = [NSTextField new];
  [view setFrame:NSMakeRect(0, 0, 200, 200)];
  [view setStringValue:@""];
  view.editable = NO;
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

void NativeText::setText(const char * text)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  [view setStringValue: [NSString stringWithUTF8String: text]];
  [view sizeToFit];
}

const char * NativeText::getText()
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  return [view stringValue].UTF8String;
}

void NativeText::setTextColor(NativeColor color)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  NSColor * c = [NSColor colorWithRed:color.r green:color.g blue:color.b alpha:color.a];
  [view setTextColor:c];
}

void NativeText::addView(NativeView * child)
{
  NativeView::addView(child);
  NSTextField * view = (__bridge NSTextField *) nativeView;
  [view sizeToFit];
}