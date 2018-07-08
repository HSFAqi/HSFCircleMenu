//
//  AppDelegate.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/4.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "AppDelegate.h"

/* 键盘 */
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark -配置键盘
-(void)setUpSDK_IQKeyboardManager{
    [IQKeyboardManager sharedManager].enable = YES;//自动键盘处理事件在整个项目内是否启用。
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;//需要当键盘弹起时，点击背景收起键盘
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;//需要支持内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self setUpSDK_IQKeyboardManager];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
