//
//  UIColor+Extension.m
//  表格视图
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+(id)colorWithHex:(u_long)color
{
    return [UIColor colorWithRed:(color & 0xff0000) / 255.0 green:(color & 0x00ff00) / 255.0 blue:(color & 0x0000ff) / 255.0 alpha:1.0];
}

+(id)colorWithHex:(u_long)color alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(color & 0xff0000) / 255.0 green:(color & 0x00ff00) / 255.0 blue:(color & 0x0000ff) / 255.0 alpha:alpha];
}

@end
