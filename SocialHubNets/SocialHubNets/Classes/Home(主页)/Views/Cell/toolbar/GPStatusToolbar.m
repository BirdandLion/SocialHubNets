//
//  GPStatusToolbar.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusToolbar.h"
#import "GPHomeModel.h"

@interface GPStatusToolbar()

@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation GPStatusToolbar

- (NSMutableArray*)dividers
{
    if(_dividers == nil)
    {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

// 分割线
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    [divider setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    divider.contentMode = UIViewContentModeCenter;
    [self.dividers addObject:divider];
    [self addSubview:divider];
}

// 设置子空间frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置分割线的frame
    NSInteger dividerCount = self.dividers.count;
    CGFloat dividerX = self.width / (dividerCount + 1);
    CGFloat dividerH = self.height;

    for(int i=0; i<dividerCount; i++)
    {
        UIImageView *imageView = self.dividers[i];
        imageView.width = 1;
        imageView.height = dividerH;
        imageView.centerX = (i + 1) * dividerX;
        imageView.centerY = dividerH * 0.5;
    }
}

// 重画背景视图 (一旦实现这个方法, 该控件的背景色变为黑色)
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImageName:@"timeline_card_bottom_background"] drawInRect:rect];
}


@end
