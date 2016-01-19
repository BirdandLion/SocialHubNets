//
//  GPAccountTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPAccountTool.h"
#import "GPHttpTool.h"
#import "MJExtension.h"

#define GPAccountFilePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation GPAccountTool

+ (void)saveWithAccount:(GPAccountModel*)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:GPAccountFilePath];
}

+ (GPAccountModel*)account
{
    // 解归档
    GPAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:GPAccountFilePath];
    
    NSDate *now = [NSDate date];
    NSComparisonResult result = [now compare:account.expires_time];
    if(result != NSOrderedAscending)
    {
        account = nil;
    }

    return account;
}

+ (void)getAccessTokenWithParam:(GPAccessTokenParam*)param success:(void (^)(GPAccountModel *account))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = param.keyValues;
    [GPHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(NSDictionary *responseObj) {
        if(success)
        {
            GPAccountModel *account = [GPAccountModel accountModelWithDict:responseObj];
            success(account);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
