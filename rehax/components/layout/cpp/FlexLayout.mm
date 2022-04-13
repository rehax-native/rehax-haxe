#include "FlexLayout.h"
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
  
  NSLayoutConstraint * constraint;

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
}
