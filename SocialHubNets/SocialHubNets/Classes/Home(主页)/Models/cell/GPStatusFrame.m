//
//  GPStatusFrame.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusFrame.h"
#import "GPHomeModel.h"
#import "GPStatusDetailFrame.h"
#import "GPStatusOriginalFrame.h"
#import "GPStatusRetweetedFrame.h"

@implementation GPStatusFrame

- (void)setStatus:(GPStatuses *)status
{
    _status = status;
    
    // 1. 计算微博的具体内容
    [self setupDetailFrame];
    // 2. 计算底部工具条
    [self setupToolbarFrame];
    // 3. 计算cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

// 计算微博的具体内容
- (void)setupDetailFrame
{
    GPStatusDetailFrame *detailFrame = [[GPStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}

// 计算底部工具条
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = SCREEN_WIDTH;
    CGFloat toolbarH = 40;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
