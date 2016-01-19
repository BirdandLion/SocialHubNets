//
//  NSAttributedString+Extension.m
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
//    NSDictionary *attributes = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

@end
