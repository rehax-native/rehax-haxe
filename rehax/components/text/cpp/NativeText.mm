#include "NativeText.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#include <iostream>

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
  NSColor * c = [NSColor colorWithRed:color.r/255.0 green:color.g/255.0 blue:color.b/255.0 alpha:color.a];
  [view setTextColor:c];
}


void NativeText::setFontSize(float size)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  view.font = [NSFont fontWithName:view.font.fontName size:size];
}

void NativeText::setFontFamilies(std::vector<std::string> fontFamilies)
{
  NSTextField * view = (__bridge NSTextField *) nativeView;
  for (int i = 0; i < fontFamilies.size(); i++)
  {
    NSString * str = [NSString stringWithCString:fontFamilies[0].c_str() encoding:NSUTF8StringEncoding];
    NSFont * font = [NSFont fontWithName:str size:view.font.pointSize];
    if (font != nullptr) {
      view.font = font;
      break;
    }
  }
}

void NativeText::addView(NativeView * child)
{
  NativeView::addView(child);
  NSTextField * view = (__bridge NSTextField *) nativeView;
  [view sizeToFit];
}
