//
//  GPEmotionTextView.m
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionTextView.h"
#import "GPEmotion.h"
#import "RegexKitLite.h"
#import "GPEmotionAttachment.h"

@implementation GPEmotionTextView

- (void)appendEmotion:(GPEmotion*)emotion
{
    if(emotion.emoji)
    {
        [self insertText:emotion.emoji];
    }
    else
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        // 创建一个带有图片的表情的富文本
        GPEmotionAttachment *attach = [[GPEmotionAttachment alloc] init];
        attach.image = [UIImage imageNamed:emotion.png];
        attach.emotion = emotion;
        attach.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        // 记录插入的位置
        NSInteger insertIndex = self.selectedRange.location;
        // 插入表情到光标位置
        [attributedText insertAttributedString:attachString atIndex:insertIndex];
        // 设置字体, 否则字体会越来越小
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        // 重新赋值
        self.attributedText = attributedText;
        // 光标重新回到插入位置
        self.selectedRange = NSMakeRange(insertIndex + 1, 0);
    }
    
//    // 1. 现拥有之前的富文本
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
////    NSAttributedString *subStr = nil;
//    
//    // 2. 拼接表情
//    if(emotion.emoji)
//    {
//        NSAttributedString *subStr = [[NSAttributedString alloc] initWithString:emotion.emoji];
//        [attributedText appendAttributedString:subStr];
//    }
//    else
//    {
//        GPEmotionAttachment *attach = [[GPEmotionAttachment alloc] init];
//        attach.image = [UIImage imageNamed:emotion.png];
//        // 获取行高
//        CGFloat imageW = self.font.lineHeight;
//        CGFloat imageH = imageW;
//        attach.bounds = CGRectMake(0, -3, imageW, imageH);
//        NSAttributedString *subStr = [NSAttributedString attributedStringWithAttachment:attach];
//        [attributedText appendAttributedString:subStr];
//    }
//    
//    // 3. 重新设置字体,因为text文字的大小由font决定,而attributedText文字大小由addAttribute方法决定
//    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
//    
//    // 4. 重新显示
//    self.attributedText = attributedText;
}

- (NSString*)realText
{
    NSMutableString *string = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        GPEmotionAttachment *attach = attrs[@"NSAttachment"];
        if(attach)
        {
            [string appendString:attach.emotion.chs];
        }
        else
        {
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:substr];
        }
    }];
    return string;
}

@end
