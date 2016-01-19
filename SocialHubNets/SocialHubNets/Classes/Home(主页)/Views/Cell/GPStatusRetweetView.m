//
//  GPStatusRetweetView.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusRetweetView.h"
#import "GPStatusRetweetedFrame.h"
#import "GPStatusPhotosView.h"
#import "GPStatusLabel.h"
#import "GPStatusRetweetedToolbar.h"

@interface GPStatusRetweetView()

@property (nonatomic, weak) GPStatusLabel * textLabel;

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) GPStatusPhotosView *photosView;
@property (nonatomic, weak) GPStatusRetweetedToolbar *toolbar;

@end

@implementation GPStatusRetweetView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        // 1. 正文
        GPStatusLabel *textLabel = [[GPStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 2. 配图相册
        GPStatusPhotosView *photosView = [[GPStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 3. 工具条
        GPStatusRetweetedToolbar *toolbar = [[GPStatusRetweetedToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

- (void)setRetweetedFrame:(GPStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    self.userInteractionEnabled = YES;
    
    GPStatuses *status = retweetedFrame.retweetedStatus;
    
    // 1. 正文
    self.textLabel.attributedText = status.attributeText;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 2.配图相册
    if(status.pic_urls.count)
    {
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.hidden = NO;
    }
    else
    {
        self.photosView.hidden = YES;
    }
    
    // 3. 工具条
    if(status.isDetail)
    {
        self.toolbar.status = status;
        self.toolbar.frame = retweetedFrame.toolbarFrame;
        self.toolbar.hidden = NO;
    }
    else
    {
        self.toolbar.hidden = YES;
    }
    
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    // 每次设置frame时,再调用一次drawRect
    [self setNeedsDisplay];
}

// 把图片填充整个空间
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImageName:@"timeline_retweet_background"] drawInRect:rect];
}

@end
