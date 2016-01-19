//
//  GPRegexResult.h
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  用来封装一个匹配结果

#import <UIKit/UIKit.h>

@interface GPRegexResult : NSTextAttachment

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
