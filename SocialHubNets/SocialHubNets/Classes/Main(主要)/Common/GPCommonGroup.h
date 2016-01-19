//
//  GPCommonGroup.h
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  用一个模型来描述每组的信息:组头, 组尾

#import <Foundation/Foundation.h>

@interface GPCommonGroup : NSObject

/*
 * 组头
 */
@property (nonatomic, strong) NSString *header;
/*
 * 组尾
 */
@property (nonatomic, strong) NSString *footer;
/*
 * 数组存储所有的行模型(GPCommonItem)
 */
@property (nonatomic, strong) NSArray *items;

+ (id)group;

@end
