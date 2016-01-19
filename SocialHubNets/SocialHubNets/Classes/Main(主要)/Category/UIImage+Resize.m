//
//  UIImage+Resize.m
//  作业1
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage*)resizeImageWithImage:(UIImage*)image
{
    CGFloat imageX = image.size.width * 0.5;
    CGFloat imageY = image.size.height * 0.5;
    CGFloat imageW = imageX;
    CGFloat imageH = imageY;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageX, imageY, imageW, imageH)];
}

+ (UIImage*)resizeImageWithImageName:(NSString*)name
{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imageX = image.size.width * 0.5;
    CGFloat imageY = image.size.height * 0.5;
    CGFloat imageW = imageX;
    CGFloat imageH = imageY;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageX, imageY, imageW, imageH)];
}


+ (UIImage*)resizedImage:(UIImage*)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage*)resizedImageName:(NSString*)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
