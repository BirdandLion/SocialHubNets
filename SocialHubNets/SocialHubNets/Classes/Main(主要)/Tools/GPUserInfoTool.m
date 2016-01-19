//
//  GPUserInfoTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPUserInfoTool.h"
#import "GPHttpTool.h"
#import "MJExtension.h"

@implementation GPUserInfoTool

// 获取用户信息
+ (void)userInfoWithParams:(GPUserInfoParam*)userInfo success:(void (^)(GPUserInfoReuslt *result))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = userInfo.keyValues;
    [GPHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObj) {
        if(success)
        {
            GPUserInfoReuslt *userInfo = [GPUserInfoReuslt objectWithKeyValues:responseObj];
            success(userInfo);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取用户的未读消息数
+ (void)userUnreadCountWithParams:(GPUnreadCountParam*)unReadCount success:(void (^)(GPUnreadCountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = unReadCount.keyValues;
    [GPHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id responseObj) {
        if(success)
        {
            GPUnreadCountResult *userInfo = [GPUnreadCountResult objectWithKeyValues:responseObj];
            success(userInfo);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
