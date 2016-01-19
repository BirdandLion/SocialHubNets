//
//  GPAccountTool.h
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPAccountModel.h"
#import "GPAccessTokenParam.h"

@interface GPAccountTool : NSObject

// 存储账户信息
+ (void)saveWithAccount:(GPAccountModel*)account;

// 读取账户信息
+ (GPAccountModel*)account;

// 获取access_token
+ (void)getAccessTokenWithParam:(GPAccessTokenParam*)param success:(void (^)(GPAccountModel *account))success failure:(void (^)(NSError *error))failure;

@end
