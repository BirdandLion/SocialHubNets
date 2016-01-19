//
//  GPStatusTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusTool.h"
#import "GPHttpTool.h"
#import "MJExtension.h"

@implementation GPStatusTool

+ (void)homeStatusWithParams:(GPHomeStatusesParam *)params success:(void (^)(GPHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [GPHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params.keyValues success:^(id responseObj) {
        if(success)
        {
            GPHomeStatusesResult *result = [GPHomeStatusesResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 发微博
+ (void)sendStatusWithParam:(GPSendStatusParam*)param success:(void (^)(GPSendStatusResult *result))success failure:(void (^)(NSError* error))failure
{
    // 必须先转一下
    NSDictionary *dict = param.keyValues;
    
    [GPHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:dict success:^(id responseObj) {
        if(success)
        {
            GPSendStatusResult *result = [GPSendStatusResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if(error)
        {
            failure(error);
        }
    }];
}

// 发文本微博(带图片)
+ (void)sendStatusPictureWithParam:(GPSendStatusParam*)param constructionBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(GPSendStatusResult *result))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = param.keyValues;
    
    [GPHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" params:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(block)
        {
            block(formData);
        }
    } success:^(id responseObj) {
        if(success)
        {
            GPSendStatusResult *result = [GPSendStatusResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

@end
