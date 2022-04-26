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
:isHorizontal(false), isReverse(false)
{}

NativeFlexLayout::NativeFlexLayout(bool isHorizontal, bool isReverse)
:isHorizontal(isHorizontal), isReverse(isReverse)
{}

void NativeFlexLayout::clearItems()
{
  items.clear();
}

void NativeFlexLayout::addItem(NativeFlexItem item)
{
  items.push_back(item);
}

void NativeFlexLayout::layoutContainer(NativeView* container)
{
  NSView * view = (__bridge NSView *) container->nativeView;
  NSView * prevView = NULL;
  NativeFlexLayoutRemoveAllConstraintsWidthId(view, @"rhx_layout");
  float spacing = 0.0;

  auto minProp = isHorizontal ? NSLayoutAttributeLeft : NSLayoutAttributeTop;
  auto maxProp = isHorizontal ? NSLayoutAttributeRight : NSLayoutAttributeBottom;

  auto crossPropMin = isHorizontal ? NSLayoutAttributeTop : NSLayoutAttributeLeft;
  auto crossPropSize = isHorizontal ? NSLayoutAttributeHeight : NSLayoutAttributeWidth;
  auto sizeProp = isHorizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
  
  NSLayoutConstraint * constraint;

  float totalFlex = 0.0;

  if (view.subviews.count > 0) {
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:minProp relatedBy:NSLayoutRelationEqual toItem:view.subviews[0] attribute:minProp multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    prevView = view.subviews[0];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:crossPropMin relatedBy:NSLayoutRelationEqual toItem:view.subviews[0] attribute:crossPropMin multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view.subviews[0] attribute:crossPropSize relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:crossPropSize multiplier:1.0 constant:-2.0 * spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];

    if (items.size() > 0 && items[0].hasFlexGrow) {
      totalFlex += items[0].flexGrow;
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
    }
  }

  if (prevView != NULL)
  {
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:maxProp relatedBy:NSLayoutRelationEqual toItem:prevView attribute:maxProp multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:crossPropMin relatedBy:NSLayoutRelationEqual toItem:prevView attribute:crossPropMin multiplier:1.0 constant:-spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:prevView attribute:crossPropSize relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:crossPropSize multiplier:1.0 constant:-2.0 * spacing];
    constraint.identifier = @"rhx_layout";
    [view addConstraint:constraint];
  }

  if (totalFlex > 0.0) {
    for (int i = 0; i < view.subviews.count; i++) {
      auto item = items[i];
      if (item.hasFlexGrow) {
        auto subView = view.subviews[i];
        auto flexConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:sizeProp relatedBy:NSLayoutRelationEqual toItem:view attribute:sizeProp multiplier:item.flexGrow / totalFlex constant:0.0];
        flexConstraint.identifier = @"rhx_layout";
        [view addConstraint:flexConstraint];
      }
    }
  }
  NSLog(@"Total flex: %f", totalFlex);
}
