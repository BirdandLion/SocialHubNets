//
//  GPHttpTool.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface GPHttpTool : UIView

// 发送get请求
+ (void)get:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

// 发送post请求
+ (void)post:(NSString*)url params:(NSDictionary*)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

// 发送post请求(数据上传)
+ (void)post:(NSString*)url params:(NSDictionary*)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end

