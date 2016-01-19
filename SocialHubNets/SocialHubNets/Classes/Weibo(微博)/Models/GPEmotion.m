//
//  GPEmotion.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotion.h"
#import "NSString+Emoji.h"

@implementation GPEmotion

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code
{
    if(code == nil) return;
    
    _code = code;
    
    self.emoji = [NSString emojiWithStringCode:code];
}

// 当从文件中解析出一个对象的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.cht = [aDecoder decodeObjectForKey:@"cht"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
    }
    return self;
}

// 将对象写入文件时调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.cht forKey:@"cht"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.directory forKey:@"directory"];
}

// 重写判断两个对象是否相等
- (BOOL)isEqual:(GPEmotion*)emotion
{
    if(self.code) // emoji表情
    {
        return [self.code isEqualToString:emotion.code];
    }
    else
    {
        return [self.png isEqualToString:emotion.png] && [self.chs isEqualToString:emotion.chs] && [self.cht isEqualToString:emotion.cht] ;
    }
}

@end
