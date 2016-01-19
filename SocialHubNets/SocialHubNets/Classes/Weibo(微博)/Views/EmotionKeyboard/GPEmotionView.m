//
//  GPEmotionView.m
//  我的微博
//
//  Created by qianfeng on 16/1/15.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionView.h"
#import "GPEmotion.h"

@implementation GPEmotionView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(GPEmotion *)emotion
{
    _emotion = emotion;
    
    if(emotion.emoji)
    {
        // emotion.code --> 0x1f683 --> \Uxxxxx
        // 关闭动画, 禁止emoji切换时带动画
        [UIView setAnimationsEnabled:NO];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView setAnimationsEnabled:YES];
        });
    }
    else
    {
        UIImage *image = [[UIImage imageNamed:emotion.png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
