//
//  AppDelegate.m
//  Recetario
//
//  Created by germana on 9/15/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseService.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DatabaseService createAndCheckDatabase];
    // Override point for customization after application launch.
    return YES;
}


@end
