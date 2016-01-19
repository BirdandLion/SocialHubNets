//
//  AppDelegate.m
//  我的微博
//
//  Created by qianfeng on 16/1/7.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

/*
 *    NSString/NSArray/NSDictionary     : Foundation
 *    CFStringRef/CFArray/CFDictionary  : Core Foundation
 //    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;  
 */

#import "AppDelegate.h"
#import "GPControllerTool.h"
#import "GPOAuthViewController.h"
#import "GPAccountTool.h"

#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD+MJ.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    // 从沙盒取出上次存储的版本号(取出上次的用户记录)
    GPAccountModel *account = [GPAccountTool account];
    if(account)
    {
        [GPControllerTool chooseRootController];
    }
    else // OAuth
    {
        self.window.rootViewController = [[GPOAuthViewController alloc] init];
    }
    
    // 监控网络
    AFNetworkReachabilityManager *manager = [[AFNetworkReachabilityManager alloc] init];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                GPLog(@"没有网络");
                [MBProgressHUD showError:@"网络异常, 请检查设置"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                GPLog(@"手机网络");
                [MBProgressHUD hideHUD];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                GPLog(@"WiFi网络");
                [MBProgressHUD hideHUD];
                break;
                
            default:
                break;
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 程序进入后台时调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 提醒操作系统, 当应用进入后台时,开启另一个任务
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 时间过期运行这个block
        [application endBackgroundTask:taskID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清楚所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片的下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
