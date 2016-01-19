//
//  GPBadgeView.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPBadgeView.h"

@implementation GPBadgeView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        // 按钮的高度就是背景图片的高度
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    // 设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算自己的尺寸
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(150, self.titleLabel.font.lineHeight)];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    // 如果文本比背景图片宽, 加大自身的宽度
    self.width = titleSize.width > bgW ? titleSize.width + 10 : bgW;
}

@end
