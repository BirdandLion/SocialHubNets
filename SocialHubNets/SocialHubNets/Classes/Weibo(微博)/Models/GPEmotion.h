//
//  GPEmotion.h
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPEmotion : NSObject<NSCoding>

// 表情的文字描述
@property (nonatomic, copy) NSString *chs;

// 表情的繁体文字描述
@property (nonatomic, copy) NSString *cht;

// 表情的png图片名
@property (nonatomic, copy) NSString *png;

// emoji表情的编码
@property (nonatomic, copy) NSString *code;

// emoji表情的字符串
@property (nonatomic, copy) NSString *emoji;

// 表情的目录
@property (nonatomic, copy) NSString *directory;

@end
