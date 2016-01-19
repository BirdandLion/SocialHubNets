//
//  GPHomeModel.m
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPHomeModel.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "GPRegexResult.h"
#import "GPEmotionAttachment.h"
#import "GPEmotionTool.h"
#import "GPEmotion.h"

// GPHomeModel
@implementation GPHomeModel

- (BOOL)isVip
{
    return self.mbtype > 2;
}

@end


// GPStatuses
@implementation GPStatuses

- (NSDictionary*)objectClassInArray
{
    return @{@"pic_urls" : [GPPhoto class]};
}

// 重写get方法,可以保证调用者使用同样的数据,不用分开处理
- (NSString*)created_at
{
    // 测试数据
    _created_at = @"Mon Sep 24 10:48:07 +0800 2010";
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置时间格式,大写代表24小时制
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [format dateFromString:_created_at];
    // 是否是今年
    if(createDate.isThisYear)
    {
        if(createDate.isToday) // 今天
        {
            NSDateComponents *cmps = [createDate deltaWithNow];
            if(cmps.hour >= 1) // 一小时前发的
            {
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            }
            else if(cmps.minute >= 1) // 一分钟之前发的
            {
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            }
            else // 一分钟内
            {
                return @"刚刚";
            }
        }
        else if(createDate.isYesterday) // 昨天
        {
            format.dateFormat = @"昨天 HH:mm";
            return [format stringFromDate:createDate];
        }
        else // 昨天之前
        {
            format.dateFormat = @"MM-dd HH:mm";
            return [format stringFromDate:createDate];
        }
    }
    else // 非今年
    {
        format.dateFormat = @"yyyy-MM-dd";
        return [format stringFromDate:createDate];
    }
    
    // 转换成其他格式
//    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSString *timeString = [format stringFromDate:createDate];
//    NSLog(@"%@", timeString);    
    return _created_at;
}

// 微博来源
- (void)setSource:(NSString *)source
{
    if(source) // 字符串不为空
    {
        NSRange range;
        if([source containsString:@">"]) // 包含@">"
        {
            range.location = [source rangeOfString:@">"].location + 1;
            if([source containsString:@"</"]) // 包含@"</"
            {
                NSUInteger tmpLocation = [source rangeOfString:@"</"].location;
                if(tmpLocation > range.location) // @"</" 在@">"后面
                {
                    range.length = tmpLocation - range.location;
                    NSString *subSource = [source substringWithRange:range];
                    _source = [NSString stringWithFormat:@"来自%@", subSource];
                }
            }
        }
    }
}

// 根据字符串计算匹配结果(有序)
- (NSArray*)regexResults:(NSString*)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    // 匹配表情
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        GPRegexResult *result = [[GPRegexResult alloc] init];
        result.string = *capturedStrings;
        result.range = *capturedRanges;
        result.emotion = YES;
        [regexResults addObject:result];
    }];
    
    // 匹配为本
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        GPRegexResult *result = [[GPRegexResult alloc] init];
        result.string = *capturedStrings;
        result.range = *capturedRanges;
        result.emotion = NO;
        [regexResults addObject:result];
    }];
    
    // 排序
    [regexResults sortedArrayUsingComparator:^NSComparisonResult(GPRegexResult *obj1, GPRegexResult *obj2) {
        
        return [@(obj1.range.location) compare:@(obj2.range.location)];
        //        if(obj1.range.location < obj1.range.location)
        //        {
        //            return NSOrderedAscending;
        //        }
        //        else if(obj1.range.location > obj1.range.location)
        //        {
        //            return NSOrderedDescending;
        //        }
        //        else
        //        {
        //            return NSOrderedSame;
        //        }
    }];
    
    return regexResults;
}

- (void)setText:(NSString *)text
{
    _text = text;

    [self createAttributeText];
}

- (void)setUser:(GPHomeModel *)user
{
    _user = user;
    
    [self createAttributeText];
}

// 设置转发微博
- (void)setRetweeted_status:(GPStatuses *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    self.retweeted = NO;
    retweeted_status.retweeted = YES;
}

// 设置是否是富文本
- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    if(retweeted)
    {
        NSString *totalText = [NSString stringWithFormat:@"@%@: %@", self.user.name, self.text];
        self.attributeText = [self attributeStringWithText:totalText];
    }
    else
    {
        self.attributeText = [self attributeStringWithText:self.text];
    }
}

// 创建富文本
- (void)createAttributeText
{
    if(self.text == nil || self.user == nil || self.attributeText != nil) return;
    
    self.attributeText = [self attributeStringWithText:self.text];
}

// 把普通文本转换成富文本
- (NSAttributedString*)attributeStringWithText:(NSString*)text
{
    // 匹配字符串
    NSArray *regexResults = [self regexResults:text];
    
    // 解析普通文本中的表情
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(GPRegexResult *result, NSUInteger idx, BOOL *stop) {
        
        GPEmotion *emotion = nil;
        if(result.isEmotion)
        {
            emotion = [GPEmotionTool emotionWithDisc:result.string];
        }
        
        if(emotion)
        {
            // 创建附件对象
            GPEmotionAttachment *attach = [[GPEmotionAttachment alloc] init];
            // 转换表情
            attach.emotion = emotion;
            attach.image = [UIImage imageNamed:attach.emotion.png];
            attach.bounds = CGRectMake(0, -3, GPStatusOriginalTextFont.lineHeight, GPStatusOriginalTextFont.lineHeight);
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributeText appendAttributedString:attachString];
        }
        else
        {
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:GPStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:GPLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:GPStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:GPLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:GPStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:GPLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            [attributeText appendAttributedString:substr];
        }
    }];
    
    [attributeText addAttribute:NSFontAttributeName value:GPStatusOriginalTextFont range:NSMakeRange(0, attributeText.length)];
    
    return attributeText;
}

@end

// GPPhoto
@implementation GPPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    
    // 设置大图的地址
    _bmiddle_pic = [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
