#include "NativeView.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface FlippedView : NSView
- (BOOL)isFlipped;
@end

@implementation FlippedView
- (BOOL)isFlipped {
    return YES;
}
@end

NativePosition NativePosition::create(float x, float y)
{
  NativePosition pos;
  pos.x = x;
  pos.y = y;
  return pos;
}

NativeSize NativeSize::create(float width, float height)
{
  NativeSize size;
  size.width = width;
  size.height = height;
  return size;
}

NativeFrame NativeFrame::create(NativePosition position, NativeSize size)
{
  NativeFrame frame;
  frame.position = position;
  frame.size = size;
  return frame;
}

NativeColor NativeColor::create(float r, float g, float b, float a)
{
  NativeColor color;
  color.r = r;
  color.g = g;
  color.b = b;
  color.a = a;
  return color;
}

void NativeView::createFragment()
{
  NSView * view = [FlippedView new];
  // node = YGNodeNew();
  // [view setFrame:NSMakeRect(0, 0, 200, 200)];
  // [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
  // view.translatesAutoresizingMaskIntoConstraints = NO;
  nativeView = (void *) CFBridgingRetain(view);
}

void NativeView::teardown()
{
  CFBridgingRelease(nativeView);
  nativeView = nullptr;
}

// void NativeView::mount(NativeView *parent)
// {
//   NSView * parentView = (__bridge NSView *) parent->nativeView;
//   NSView * view = (__bridge NSView *) nativeView;
//   // view.wantsLayer = true;
//   // [view layer].backgroundColor = [[NSColor redColor] CGColor];
//   view.frame = parentView.bounds;
//   [parentView addSubview:view];
// }

// void NativeView::unmount(NativeView *parent)
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   [view removeFromSuperview];
//   CFBridgingRelease(nativeView);
//   nativeView = nullptr;
// }

void NativeView::addView(NativeView * child)
{
  NSView * view = (__bridge NSView *) nativeView;
  NSView * childView = (__bridge NSView *) child->nativeView;
  // view.wantsLayer = true;
  // [view layer].backgroundColor = [[NSColor redColor] CGColor];
  // view.frame = parentView.bounds;
  [childView setFrame:view.bounds];
  // [childView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
  childView.translatesAutoresizingMaskIntoConstraints = NO;

  [view addSubview:childView];
}

void NativeView::removeView(NativeView * child)
{

}

void NativeView::removeFromParent()
{
  NSView * view = (__bridge NSView *) nativeView;
  [view removeFromSuperview];
}

void NativeViewRemoveAllConstraintsWidthId(NSView * view, NSString * identifier)
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
  NSArray *filteredArray = [[view constraints] filteredArrayUsingPredicate:predicate];

  for (id constraint in filteredArray)
  {
    NSLog(@"Remove constraint %@", constraint);
    [view removeConstraint:constraint];
  }

  filteredArray = [[[view superview] constraints] filteredArrayUsingPredicate:predicate];
  for (id constraint in filteredArray)
  {
    if ([constraint secondItem] == view)
    {
      // [[view superview] removeConstraint:constraint];
    }
  }
}

void NativeView::setWidthFill()
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_width");

  NSLayoutConstraint * constraint;

  constraint = [NSLayoutConstraint constraintWithItem:[view superview] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
  constraint.identifier = @"hx_width";
  [[view superview] addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:[view superview] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
  constraint.identifier = @"hx_width";
  [[view superview] addConstraint:constraint];
}

void NativeView::setHeightFill()
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_height");

  NSLayoutConstraint * constraint;

  constraint = [NSLayoutConstraint constraintWithItem:[view superview] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
  constraint.identifier = @"hx_height";
  [[view superview] addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:[view superview] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
  constraint.identifier = @"hx_height";
  [[view superview] addConstraint:constraint];
}

void NativeView::setWidthNatural()
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_width");
}

void NativeView::setHeightNatural()
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_height");
}

void NativeView::setWidthFixed(float width)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_width");

  NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
  constraint.identifier = @"hx_width";
  [view addConstraint:constraint];
}

void NativeView::setHeightFixed(float height)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_height");

  NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
  constraint.identifier = @"hx_height";
  [view addConstraint:constraint];
}

void NativeView::setWidthPercentage(float percentage)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_width");

  NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[view superview] attribute:NSLayoutAttributeWidth multiplier:percentage / 100.0 constant:0];
  constraint.identifier = @"hx_width";
  [[view superview] addConstraint:constraint];
}

void NativeView::setHeightPercentage(float percentage)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_height");

  NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:[view superview] attribute:NSLayoutAttributeHeight multiplier:percentage / 100.0 constant:0];
  constraint.identifier = @"hx_height";
  [[view superview] addConstraint:constraint];
}

void NativeView::setVerticalPositionNatural(NativeView * previousView)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_pos_vert");

  if (view.superview == NULL) {
    return;
  }

  if (previousView == NULL) {
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    constraint.identifier = @"hx_pos_vert";
    [view.superview addConstraint:constraint];
  } else {
    NSView * prev = (__bridge NSView *) previousView->nativeView;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:prev attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    constraint.identifier = @"hx_pos_vert";
    [view.superview addConstraint:constraint];
  }
}

void NativeView::setHorizontalPositionNatural(NativeView * previousView)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_pos_horiz");

  if (view.superview == NULL) {
    return;
  }

  if (previousView == NULL) {
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    constraint.identifier = @"hx_pos_horiz";
    [view.superview addConstraint:constraint];
  } else {
    NSView * prev = (__bridge NSView *) previousView->nativeView;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prev attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    constraint.identifier = @"hx_pos_horiz";
    [view.superview addConstraint:constraint];
  }
}

void NativeView::setVerticalPositionFixed(float y)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_pos_vert");

  NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:y];
  constraint.identifier = @"hx_pos_vert";
  [view.superview addConstraint:constraint];
}

void NativeView::setHorizontalPositionFixed(float x)
{
  NSView * view = (__bridge NSView *) nativeView;
  NativeViewRemoveAllConstraintsWidthId(view, @"hx_pos_horiz");

  NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:x];
  constraint.identifier = @"hx_pos_horiz";
  [view.superview addConstraint:constraint];
}

// void NativeView::setHeightFill()
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

//   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", @"hx_height"];
//   NSArray *filteredArray = [[view constraints] filteredArrayUsingPredicate:predicate];
//   NSLayoutConstraint * constraint;
//   if (filteredArray.count > 0) {
//     constraint = filteredArray[0];
//     constraint.constant = height;
//   } else {
//     constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
//     constraint.identifier = @"hx_height";
//     [view addConstraint:constraint];
//   }
// }

// void NativeView::setWidthNull()
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", @"hx_width"];
//   NSArray *filteredArray = [[view constraints] filteredArrayUsingPredicate:predicate];
//   NSLayoutConstraint * constraint;
//   if (filteredArray.count > 0) {
//     constraint = filteredArray[0];
//     [view removeConstraint:constraint];
//   }
// }

// void NativeView::setHeightNull()
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", @"hx_height"];
//   NSArray *filteredArray = [[view constraints] filteredArrayUsingPredicate:predicate];
//   NSLayoutConstraint * constraint;
//   if (filteredArray.count > 0) {
//     constraint = filteredArray[0];
//     [view removeConstraint:constraint];
//   }
// }

// void NativeView::setX(float x)
// {

// }

// void NativeView::setY(float y)
// {

// }

// void NativeView::setPosition(NativePosition position)
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   NSRect frame = [view frame];
//   [view setFrame:NSMakeRect(position.x, position.y, frame.size.width, frame.size.height)];
// }

// NativeSize NativeView::getSize()
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   NSRect frame = [view frame];
//   NativeSize size;
//   size.width = frame.size.width;
//   size.height = frame.size.height;
//   return size;
// }

// NativePosition NativeView::getPosition()
// {
//   NSView * view = (__bridge NSView *) nativeView;
//   NSRect frame = [view frame];
//   NativePosition position;
//   position.x = frame.origin.x;
//   position.y = frame.origin.y;
//   return position;
// }

void NativeView::setBackgroundColor(NativeColor color)
{
  NSView * view = (__bridge NSView *) nativeView;
  [view setWantsLayer:true];
  [view setLayer:[CALayer layer]];
  NSColor *col = [NSColor colorWithDeviceRed:color.r/255.0 green:color.g/255.0 blue:color.b/255.0 alpha:color.a];
  [view.layer setBackgroundColor:[col CGColor]];
  // NSLog(@"Set Color %@", col);
}

void NativeView::setTextColor(NativeColor color)
{
  // NSView * view = (__bridge NSView *) nativeView;
  // [view setTextColor:[NSColor colorWithRed:color.r green:color.g blue:color.b alpha:color.a]];
}

void NativeView::setOpacity(float opacity)
{
  NSView * view = (__bridge NSView *) nativeView;
  [view setAlphaValue:opacity];
}