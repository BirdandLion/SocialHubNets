//
//  GPEmotionKeyboard.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  表情键盘

#import "GPEmotionKeyboard.h"
#import "GPEmotionListView.h"
#import "GPEmotionToolbar.h"
#import "MJExtension.h"
#import "GPEmotion.h"
#import "GPEmotionTool.h"

@interface GPEmotionKeyboard() <GPEmotionToolbarDelegate>
// 添加表情列表
@property (nonatomic, weak) GPEmotionListView *listView;
// 添加工具条
@property (nonatomic, weak) GPEmotionToolbar *toolbar;


@end

@implementation GPEmotionKeyboard

+ (id)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1. 添加表情列表
        GPEmotionListView *listView = [[GPEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2. 添加工具条
        GPEmotionToolbar *toolbar = [[GPEmotionToolbar alloc] init];
        [self addSubview:toolbar];
        toolbar.delegate = self;
        self.toolbar = toolbar;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 设置工具条frame
    self.toolbar.x = 0;  // 默认为0, 可以不写
    self.toolbar.width = self.width;
    self.toolbar.height = 45;
    self.toolbar.y = self.height - self.toolbar.height;
    
    // 2. 设置listView的frame
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.toolbar.y;
}

#pragma mark - GPEmotionToolbarDelegate

- (void)emotionToolbar:(GPEmotionToolbar *)toolbar didSelectedButton:(GPEmotionToolbarButtonType)buttonType
{
    switch (buttonType) {
        case GPEmotionToolbarButtonTypeDefault:
            self.listView.emotions = [GPEmotionTool defaultEmotions];
            break;
            
        case GPEmotionToolbarButtonTypeEmoij:
            self.listView.emotions = [GPEmotionTool emojiEmotions];
            break;
            
        case GPEmotionToolbarButtonTypeLxh:
            self.listView.emotions = [GPEmotionTool lxhEmotions];
            break;
            
        case GPEmotionToolbarButtonTypeLatest:
            self.listView.emotions = [GPEmotionTool recentEmotions];
        default:
            break;
    }
}

@end
