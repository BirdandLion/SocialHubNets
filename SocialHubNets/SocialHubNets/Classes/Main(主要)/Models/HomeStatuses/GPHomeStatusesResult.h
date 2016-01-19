//
//  GPHomeStatusesResult.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  加载服务器首页的返回结果

#import <Foundation/Foundation.h>

@interface GPHomeStatusesResult : NSObject
/* 微博数组 */
@property (nonatomic, strong) NSArray *statuses;

/**/
@property (nonatomic, assign) int total_number;

@end
