//
//  GPTitleButton.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPTitleButton.h"

@implementation GPTitleButton

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 内部图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字右对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置文字字体
        self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1. 计算文字的尺寸
    CGSize size = CGSizeMake(CGFLOAT_MAX, self.titleLabel.height);
    NSDictionary *attr = @{NSFontAttributeName: self.titleLabel.font};
    CGSize titleSize = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    // 2. 计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}

@end
