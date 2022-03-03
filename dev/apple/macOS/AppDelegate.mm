//
//  AppDelegate.m
//  PluginTester
//
//  Created by Denis Stadniczuk on 02.02.22.
//

#import "AppDelegate.h"
#include "../lib/include/rhx/dev/App.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  HX_TOP_OF_STACK
  ::hx::Boot();
  __boot_all();
  dev::App_obj::main();
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
  return YES;
}


@end
