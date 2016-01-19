//
//  UIImage+Resize.h
//  作业1
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage*)resizeImageWithImage:(UIImage*)image;
+ (UIImage*)resizeImageWithImageName:(NSString*)name;
+ (UIImage*)resizedImage:(UIImage*)image;
+ (UIImage*)resizedImageName:(NSString*)name;

@end
