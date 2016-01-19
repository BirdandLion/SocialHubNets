//
//  GPEmotionToolbar.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionToolbar.h"

#define GPEmotionToolbarButtonMaxCount  4

@interface GPEmotionToolbar()

// 当前选择的按钮
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation GPEmotionToolbar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //创建工具条的按钮
        [self setupButton:@"最近" tag:0];
        [self setupButton:@"默认" tag:1];
        [self setupButton:@"Emoij" tag:2];
        [self setupButton:@"浪小花" tag:3];
        
        // 监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionSelected:) name:GPEmotionDidSelectedNotification object:nil];
    }
    return self;
}

- (void)setupButton:(NSString*)title tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    button.tag = tag;
    
    // 设置按钮文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.subviews.count == 1)
    {
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }
    else if(self.subviews.count == GPEmotionToolbarButtonMaxCount)
    {
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }
    else
    {
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImageName:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
}

// 按钮点击事件处理方法
- (void)buttonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    if([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)])
    {
        [self.delegate emotionToolbar:self didSelectedButton:(GPEmotionToolbarButtonType)button.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 3. 设置工具条的按钮frame
    CGFloat buttonW = self.width / GPEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for(int i=0; i<GPEmotionToolbarButtonMaxCount; i++)
    {
        UIButton *button = self.subviews[i];
        button.x = i * buttonW;
        button.width = buttonW;
        button.height = buttonH;
    }
}

- (void)setDelegate:(id<GPEmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 设置默认按钮
    [self buttonClick:(UIButton*)self.subviews[1]];
}

- (void)emotionSelected:(NSNotification*)note
{
    if(self.selectedButton.tag == GPEmotionToolbarButtonTypeLatest)
    {
        [self buttonClick:self.selectedButton];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
