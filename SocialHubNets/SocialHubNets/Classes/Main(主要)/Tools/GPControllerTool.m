//
//  GPControllerTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPControllerTool.h"
#import "GPRootTabController.h"
#import "GPNewFeatureController.h"

@implementation GPControllerTool

+ (void)chooseRootController
{
    NSString *versionKey = @"CFBundleVersion"; // kCFBundleVersionKey
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [df objectForKey:versionKey];
    // 取出新的版本号
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][versionKey];
    
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    if([currentVersion isEqualToString:lastVersion])
    {
        // 版本一样
        window.rootViewController = [[GPRootTabController alloc] init];
    }
    else
    {
        // 版本不一样
        window.rootViewController = [[GPNewFeatureController alloc] init];
        [df setObject:currentVersion forKey:versionKey];
        [df synchronize];
    }
}

@end
