//
//  GPStatusOriginalFrame.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusOriginalFrame.h"
#import "GPStatusPhotosView.h"

@implementation GPStatusOriginalFrame

- (void)setStatus:(GPStatuses *)status
{
    _status = status;

    // 0. 头像
    CGFloat iconX = GPStatusCellInset;
    CGFloat iconY = GPStatusCellInset;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 1. 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + GPStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:GPStatusOriginalNameFont maxSize:CGSizeMake(MAXFLOAT, nameY)];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize}; // 转换成frame
    
    // 2. 设置会员等级图片
    if(status.user.isVip)
    {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + GPStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
#warning 由于时间的frame需要实时的系统时间进行重新设置, 所以设置时间的frame方法放到设置数据处: GPStatusOriginalView.m中第98行
    
    // 3. 正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + GPStatusCellInset;
    CGSize textSize = [status.attributeText sizeWithFont:GPStatusOriginalTextFont maxSize:CGSizeMake(SCREEN_WIDTH - 2 * GPStatusCellInset, MAXFLOAT)];
    self.textFrame = (CGRect){{textX, textY}, textSize}; // 转换成frame
    
    // 4.配图相册
    CGFloat h = 0;
    if(status.pic_urls.count)
    {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + GPStatusCellInset;
        CGSize photosSize = [GPStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};

        h = CGRectGetMaxY(self.photosFrame) + GPStatusCellInset;
    }
    else
    {
        h = CGRectGetMaxY(self.textFrame) + GPStatusCellInset;
    }
    
    // 5. 自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SCREEN_WIDTH;
    self.frame = CGRectMake(x, y, w, h);
}

@end
