//
//  GPPopMenu.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPPopMenu.h"

@interface GPPopMenu()

// 弹出的内容视图
@property (nonatomic, weak) UIView *contentView;
// 底部的cover
@property (nonatomic, weak) UIButton *cover;
// 上面的容器视图
@property (nonatomic, weak) UIImageView *containView;

@end

@implementation GPPopMenu

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cover];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        self.cover = cover;
        
        UIImageView *containView = [[UIImageView alloc] init];
//        containView.image = [UIImage resizedImage:[UIImage imageNamed:@"popover_background"]];
        containView.userInteractionEnabled = YES;
        [self addSubview:containView];
        self.containView = containView;
        
    }
    return self;
}

- (id)initWithContentView:(UIView *)contentView
{
    if(self = [super init])
    {
        self.contentView = contentView;
    }
    return self;
}

+ (id)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

// 设置子视图cover的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

#pragma mark - cover click

- (void)coverClick
{
    [self.delegate popMenuCoverClickedWithPopMenu:self];
    
    [self removeFromSuperview];
}

- (void)showPopMenuWithRect:(CGRect)frame
{
    // 获取窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    // 将自己的视图加载到父视图上面
    [window addSubview:self];

    self.containView.frame = frame;
    [self.containView addSubview:self.contentView];
    
    CGFloat marginLeft = 8;
    CGFloat marginRight = 10;
    CGFloat marginTop = 8;
    CGFloat marginBottom = 10;
    
    self.contentView.frame = CGRectMake(marginLeft, marginTop, self.containView.width - marginLeft - marginRight, self.containView.height - marginTop - marginBottom);
}

#pragma mark - 公共方法

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    self.containView.image = backgroundImage;
}

- (void)setArrowPosition:(GPPopMenuPopMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    
    switch (arrowPosition) {
        case GPPopMenuPopMenuArrowPositionCenter:
            self.containView.image = [UIImage resizedImage:[UIImage imageNamed:@"popover_background"]];
            break;
        case GPPopMenuPopMenuArrowPositionLeft:
            self.containView.image = [UIImage resizedImage:[UIImage imageNamed:@"popover_background_left"]];
            break;
        case GPPopMenuPopMenuArrowPositionRight:
            self.containView.image = [UIImage resizedImage:[UIImage imageNamed:@"popover_background_right"]];
            break;
            
        default:
            break;
    }
}

- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if(dimBackground)
    {
        [self.cover setBackgroundColor:[UIColor blackColor]];
        self.cover.alpha = 0.3;
    }
    else
    {
        [self.cover setBackgroundColor:[UIColor clearColor]];
        self.cover.alpha = 1.0;
    }
}

@end
