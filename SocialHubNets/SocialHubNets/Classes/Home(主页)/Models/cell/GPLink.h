//
//  GPLink.h
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  一个link对象封装一个链接

#import <Foundation/Foundation.h>

@interface GPLink : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSRange range;

@property (nonatomic, strong) NSArray *rects;

@end
