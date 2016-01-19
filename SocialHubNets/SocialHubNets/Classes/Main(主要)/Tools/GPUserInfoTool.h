//
//  GPUserInfoTool.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUserInfoParam.h"
#import "GPUserInfoReuslt.h"
#import "GPUnreadCountParam.h"
#import "GPUnreadCountResult.h"

@interface GPUserInfoTool : NSObject

// 获取用户信息
+ (void)userInfoWithParams:(GPUserInfoParam*)userInfo success:(void (^)(GPUserInfoReuslt *result))success failure:(void (^)(NSError *error))failure;

// 获取用户的未读消息数
+ (void)userUnreadCountWithParams:(GPUnreadCountParam*)unReadCount success:(void (^)(GPUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
