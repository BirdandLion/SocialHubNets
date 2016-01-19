//
//  GPCommonItem.m
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  

#import "GPCommonItem.h"

@implementation GPCommonItem

+ (id)itemWithTitle:(NSString*)title icon:(NSString*)icon
{
    GPCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (id)itemWithTitle:(NSString*)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
