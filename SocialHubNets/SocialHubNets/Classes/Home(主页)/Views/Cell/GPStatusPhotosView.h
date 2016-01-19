//
//  GPStatusPhotosView.h
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  微博里面的相册

#import <UIKit/UIKit.h>

@interface GPStatusPhotosView : UIView

// 图片数据(里面都是GPPhoto模型)
@property (nonatomic, strong) NSArray *pic_urls;

// 根据count计算size
+ (CGSize)sizeWithPhotosCount:(int)count;

@end
