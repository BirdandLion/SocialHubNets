//
//  GPComposeToolBar.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPComposeToolBar.h"

@interface GPComposeToolBar()

@property (nonatomic, weak) UIButton *emotionButton;

@end

@implementation GPComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizedImageName:@"compose_toolbar_background_os7"]];
        // 添加所有的子空间
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:GPComposeToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:GPComposeToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:GPComposeToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:GPComposeToolBarButtonTypeTrend];
        self.emotionButton = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:GPComposeToolBarButtonTypeEmotion];
    }
    return self;
}

// 添加一个按钮

- (UIButton*)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(GPComposeToolBarButtonType)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage resizedImageName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage resizedImageName:highIcon] forState:UIControlStateHighlighted];
    button.tag = tag;
    [self addSubview:button];
    
    return button;
}

// 按钮监听

- (void)buttonClick:(UIButton*)button
{
    if([self.delegate respondsToSelector:@selector(composeToolBar:didClickedButton:)])
    {
        [self.delegate composeToolBar:self didClickedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    
    for(int i=0; i<count; i++)
    {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.x = i * buttonW;
        button.width = buttonW;
        button.height = buttonH;
    }
}

// 设置emotionbutton
- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    
    if(showEmotionButton)
    {
        [self.emotionButton setImage:[UIImage resizedImageName:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage resizedImageName:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.emotionButton setImage:[UIImage resizedImageName:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage resizedImageName:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

@end
