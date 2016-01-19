//
//  GPComposePhotosView.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPComposePhotosView : UIView

// 显示的图片
@property (nonatomic, copy) NSMutableArray *images;

// 添加一张图片到相册
- (void)addImage:(UIImage*)image;

@end
