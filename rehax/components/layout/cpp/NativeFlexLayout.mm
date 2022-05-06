#include "NativeFlexLayout.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


void NativeFlexLayoutRemoveAllConstraintsWidthId(NSView * view, NSString * identifier)
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
  NSArray *filteredArray = [[view constraints] filteredArrayUsingPredicate:predicate];

  for (id constraint in filteredArray)
  {
//    NSLog(@"Remove constraint %@", constraint);
    [view removeConstraint:constraint];
  }
}

NativeFlexLayout::NativeFlexLayout()
{}

void NativeFlexLayout::clearItems()
{
  items.clear();
}

void NativeFlexLayout::addItem(NativeFlexItem item)
{
  items.push_back(item);
}

void NativeFlexLayout::setOptions(
  bool isHorizontal_,
  bool isReverse_, 
  int justifyContent_,
  int alignItems_
) {
  isHorizontal = isHorizontal_;
  isReverse = isReverse_;
  justifyContent = justifyContent_;
  alignItems = alignItems_;
}

void NativeFlexLayout::layoutContainer(NativeView* container)
{
  NSView * view = (__bridge NSView *) container->nativeView;
  NSView * prevView = NULL;
  NativeFlexLayoutRemoveAllConstraintsWidthId(view, @"rhx_layout");
  float spacing = 0.0;

  auto minProp = isHorizontal ? NSLayoutAttributeLeft : NSLayoutAttributeTop;
  auto maxProp = isHorizontal ? NSLayoutAttributeRight : NSLayoutAttributeBottom;

  auto crossPropMin = NSLayoutAttributeTop;
  auto crossPropSize = isHorizontal ? NSLayoutAttributeHeight : NSLayoutAttributeWidth;

  constexpr int AlignFlexStart = 0;
  constexpr int AlignFlexEnd = 1;
  constexpr int AlignCenter = 2;

  if (isHorizontal) {
    if (alignItems == AlignFlexStart) {
      crossPropMin = NSLayoutAttributeTop;
    } else if (alignItems == AlignFlexEnd) {
      crossPropMin = NSLayoutAttributeBottom;
    } else if (alignItems == AlignCenter) {
      crossPropMin = NSLayoutAttributeCenterY;
    }
  } else {
    if (alignItems == AlignFlexStart) {
      crossPropMin = NSLayoutAttributeLeft;
    } else if (alignItems == AlignFlexEnd) {
      crossPropMin = NSLayoutAttributeRight;
    } else if (alignItems == AlignCenter) {
      crossPropMin = NSLayoutAttributeCenterX;
    }
  }

  auto sizeProp = isHorizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
  
  NSLayoutConstraint * constraint;

  float totalFlex = 0.0;
  NSView * prevFlexView = NULL;
  float prevFlex = 0.0;

  if (view.subviews.count > 0) {
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:crossPropMin relatedBy:NSLayoutRelationEqual toItem:view.subviews[0] attribute:crossPropMin multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view.subviews[0] attribute:crossPropSize relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:crossPropSize multiplier:1.0 constant:-2.0 * spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];

    prevView = view.subviews[0];

    if (items.size() > 0 && items[0].hasFlexGrow) {
      totalFlex += items[0].flexGrow;
      prevFlexView = view.subviews[0];
      prevFlex = items[0].flexGrow;
    }
  }

  for (int i = 1; i < view.subviews.count; i++) {
    NSView * subView = view.subviews[i];

    constraint = [NSLayoutConstraint constraintWithItem:prevView attribute:maxProp relatedBy:NSLayoutRelationEqual toItem:subView attribute:minProp multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];

    prevView = subView;

    constraint = [NSLayoutConstraint constraintWithItem:view attribute:crossPropMin relatedBy:NSLayoutRelationEqual toItem:subView attribute:crossPropMin multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:subView attribute:crossPropSize relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:crossPropSize multiplier:1.0 constant:-2.0 * spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];

    if (items.size() > i && items[i].hasFlexGrow) {
      totalFlex += items[i].flexGrow;

      auto item = items[i];
      auto subView = view.subviews[i];
      if (prevFlexView) {
        float multiplier = item.flexGrow / prevFlex;
        auto flexConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:sizeProp relatedBy:NSLayoutRelationEqual toItem:prevFlexView attribute:sizeProp multiplier:multiplier constant:0.0];
        flexConstraint.identifier = @"rhx_layout";
        [view addConstraint:flexConstraint];
      }
      prevFlexView = subView;
      prevFlex = item.flexGrow;
    }
  }

  if (prevView != NULL)
  {
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:crossPropMin relatedBy:NSLayoutRelationEqual toItem:prevView attribute:crossPropMin multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:prevView attribute:crossPropSize relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:crossPropSize multiplier:1.0 constant:-2.0 * spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
  }

  constexpr int FlexStart = 0;
  constexpr int FlexEnd = 1;
  constexpr int Center = 2;

  if ((justifyContent == FlexStart || totalFlex > 0.0) && view.subviews.count > 0) {
    auto subView = view.subviews[0];
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:minProp relatedBy:NSLayoutRelationEqual toItem:subView attribute:minProp multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
  }

  if ((justifyContent == FlexEnd || totalFlex > 0.0) && view.subviews.count > 0) {
    auto subView = view.subviews[view.subviews.count - 1];
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:maxProp relatedBy:NSLayoutRelationEqual toItem:subView attribute:maxProp multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
  }

  if (justifyContent == Center && totalFlex == 0.0 && view.subviews.count > 0) {
    // This isn't as easy with layout constraints
    // There are several ways:
    // * We could create two spacer views, on for the leading and one for the trailing edge, and make them equal size.
    //   This introduces two new views which we have to manage somehow.
    // * We put all views into a container view and align the center of the container to the center of the parent. This introduces another view again.
    // * We measure the childrens' sizes and create constraints accordingly. Not sure this will work with varying sizes of the children.

    // Since all these solutions aren't easy to implement, we make a compromise: We simply create a constraint that centers the middle child.
    // This will give wrong results in many cases

    int middleIndex = (int) view.subviews.count / 2.0;
    auto subView = view.subviews[middleIndex];

    auto centerProp = isHorizontal ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY;

    constraint = [NSLayoutConstraint constraintWithItem:view attribute:centerProp relatedBy:NSLayoutRelationEqual toItem:subView attribute:centerProp multiplier:1.0 constant:0];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
  }
}
