//
//  BNRAppDelegate.m
//  Homepwner
//
//  Created by John Moon on 5/30/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRItemsViewController.h"

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Create a BNRItemsViewController
    BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
    
    
    //Create an instance of a UINavigationController
    //Its stack contains only itemsViewController
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    
    //Place BNRItemsViewController's table view in the window hierarchy
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
