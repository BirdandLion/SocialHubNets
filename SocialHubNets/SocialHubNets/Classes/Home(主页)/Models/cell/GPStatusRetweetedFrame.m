//
//  GPStatusRetweetedFrame.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusRetweetedFrame.h"
#import "GPStatusPhotosView.h"

@implementation GPStatusRetweetedFrame

- (void)setRetweetedStatus:(GPStatuses *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    CGFloat h = 0;
    
    // 1. 正文
    CGFloat textX = GPStatusCellInset;
    CGFloat textY = textX;
    CGSize textSize = [retweetedStatus.attributeText sizeWithFont:GPStatusRetweetedTextFont maxSize:CGSizeMake(SCREEN_WIDTH - 2 * GPStatusCellInset, MAXFLOAT)];
    self.textFrame = (CGRect){{textX, textY}, textSize}; // 转换成frame
    h = CGRectGetMaxY(self.textFrame) + GPStatusCellInset;
    
    // 2.配图相册
    
    if(retweetedStatus.pic_urls.count)
    {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + GPStatusCellInset;
        CGSize photosSize = [GPStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        h = CGRectGetMaxY(self.photosFrame) + GPStatusCellInset;
    }
    
    // 3. 转发微博的工具条frame
    if(retweetedStatus.isDetail)
    {
        CGFloat toolbarY = 0;
        CGFloat toolbarW = 200;
        CGFloat toolbarX = SCREEN_WIDTH - toolbarW;
        CGFloat toolbarH = 30;
        if(retweetedStatus.pic_urls.count)
        {
            toolbarY = CGRectGetMaxY(self.photosFrame) + GPStatusCellInset;
        }
        else
        {
            toolbarY = CGRectGetMaxY(self.textFrame) + GPStatusCellInset;
        }
        self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        h = CGRectGetMaxY(self.toolbarFrame) + GPStatusCellInset;
    }

    // 4. 自己的frame
    CGFloat x = 0;
    CGFloat y = 0;  // 高度 = 原创微博最大的y值
    CGFloat w = SCREEN_WIDTH;
    self.frame = CGRectMake(x, y, w, h);
    
}

@end
