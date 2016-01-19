//
//  GPHttpTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPHttpTool.h"


@implementation GPHttpTool

+ (void)get:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

// 发送post请求
+ (void)post:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

// 发送post请求(数据上传)
+ (void)post:(NSString*)url params:(NSDictionary*)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        block(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
