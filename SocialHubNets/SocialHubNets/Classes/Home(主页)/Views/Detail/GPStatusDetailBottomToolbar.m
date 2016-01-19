//
//  GPStatusDetailBottomToolbar.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusDetailBottomToolbar.h"

@implementation GPStatusDetailBottomToolbar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
    }
    return self;
}

// 添加按钮
- (void)setupBtnWithIcon:(NSString*)icon title:(NSString*)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置高亮背景
    [btn setBackgroundImage:[UIImage resizeImageWithImageName:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    // 高亮时不加暗图片显示
//    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
}

// 设置子空间frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat margin = 10;
    
    CGFloat btnY = 5;
    CGFloat btnW = (self.width - (btnCount + 1) * margin) / btnCount;
    CGFloat btnH = self.height - btnY * 2;
    
    for(int i=0; i<btnCount; i++)
    {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = margin + i * (btnW + margin);
        btn.y = btnY;
    }
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImageName:@"statusdetail_toolbar_background"] drawInRect:rect];
}

@end
