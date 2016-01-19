//
//  NSAttributedString+Extension.h
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

/**
 *  返回字符串所占用的尺寸 来设置动态的宽/高
 *
 *  @param font    字体
 *  @param maxSize 限制的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
