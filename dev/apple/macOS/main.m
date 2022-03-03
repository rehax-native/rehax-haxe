//
//  main.m
//  PluginTester
//
//  Created by Denis Stadniczuk on 02.02.22.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
      // Setup code that might create autoreleased objects goes here.
  }
  [[NSApplication sharedApplication] setDelegate:[AppDelegate new]];
  return NSApplicationMain(argc, argv);
}
