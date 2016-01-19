//
//  GPStatusDetailView.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusDetailView.h"
#import "GPStatusOriginalView.h"
#import "GPStatusRetweetView.h"

#import "GPStatusDetailFrame.h"

@interface GPStatusDetailView()

@property (nonatomic, weak) GPStatusOriginalView *originalView;
@property (nonatomic, weak) GPStatusRetweetView *retweetView;

@end

@implementation GPStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        // 1. 添加原创微博
        [self setupOriginalView];
        // 2. 添加转发微博
        [self setupRetweetView];
        // 3. 设置背景色
        self.image = [UIImage resizedImageName:@"timeline_card_top_background"];
    }
    return self;
}

// 添加原创微博
- (void)setupOriginalView
{
    GPStatusOriginalView *originalView = [[GPStatusOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}

// 添加转载微博
- (void)setupRetweetView
{
    GPStatusRetweetView *retweetView = [[GPStatusRetweetView alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setDetailFrame:(GPStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    // 1. 设置自己的frame
    self.frame = detailFrame.frame;
    
    // 2. 原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    // 3. 转发微博的frame数据
    self.retweetView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
