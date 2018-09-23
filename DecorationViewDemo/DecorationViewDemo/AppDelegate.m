//
//  AppDelegate.m
//  DecorationViewDemo
//
//  Created by J on 2017/6/17.
//  Copyright © 2017年 J. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = ViewController.new;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
