//
//  GPStatusTool.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  微博业务类: 处理与微博相关的业务(加载微博数据, 发微博, 删微博)

#import <Foundation/Foundation.h>
#import "GPHomeStatusesParam.h"
#import "GPHomeStatusesResult.h"
#import "GPSendStatusParam.h"
#import "GPSendStatusResult.h"
#import "GPHttpTool.h"

@interface GPStatusTool : NSObject

// 请求首页数据
+ (void)homeStatusWithParams:(GPHomeStatusesParam*)params success:(void (^)(GPHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

// 发文本微博(不带图片)
+ (void)sendStatusWithParam:(GPSendStatusParam*)param success:(void (^)(GPSendStatusResult *result))success failure:(void (^)(NSError* error))failure;

// 发文本微博(带图片)
+ (void)sendStatusPictureWithParam:(GPSendStatusParam*)param constructionBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(GPSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


@end
