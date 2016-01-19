//
//  GPStatusDetailFrame.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusDetailFrame.h"
#import "GPStatusOriginalFrame.h"
#import "GPStatusRetweetedFrame.h"

@implementation GPStatusDetailFrame

- (void)setStatus:(GPStatuses *)status
{
    _status = status;
    
    // 1. 计算原创微博frame
    [self setupOriginalFrame];
    // 2. 计算转发微博frame
    [self setupRetweetFrame];
    // 3. 计算自己的frame
    [self setupFrame];
}

// 计算原创微博
- (void)setupOriginalFrame
{
    GPStatusOriginalFrame *originalFrame = [[GPStatusOriginalFrame alloc] init];
    originalFrame.status = self.status;
    self.originalFrame = originalFrame;
}

// 计算转发微博
- (void)setupRetweetFrame
{
    // 没有转发微博,直接返回
    if(self.status.retweeted_status == nil) return;
    
    GPStatusRetweetedFrame *retweetedFrame = [[GPStatusRetweetedFrame alloc] init];
    retweetedFrame.retweetedStatus = self.status.retweeted_status;
    self.retweetedFrame = retweetedFrame;
    
    CGRect frame = retweetedFrame.frame;
    frame.origin.y = CGRectGetMaxY(self.originalFrame.frame);
    retweetedFrame.frame = frame;
}

// 计算自己的frame
- (void)setupFrame
{
    CGFloat x = 0;
    CGFloat y = GPStatusCellMargin;
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = 0;
    if(self.status.retweeted_status == nil)
    {
        h = CGRectGetMaxY(self.originalFrame.frame);
    }
    else
    {
        h = CGRectGetMaxY(self.retweetedFrame.frame);
    }
    
    self.frame = CGRectMake(x, y, w, h);
}

@end
