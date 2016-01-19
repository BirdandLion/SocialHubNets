//
//  GPComposePhotosView.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPComposePhotosView.h"

@interface GPComposePhotosView()

@end

@implementation GPComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)addImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    // 设置图片填充,而不是拉伸适配
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    // 切掉超出的部分
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    int maxColPerRow = 4;
    CGFloat margin = 10;
    
    CGFloat imageViewW = (self.width - margin * (count + 1)) / maxColPerRow;
    CGFloat imageViewH = imageViewW;
    
    for(int i=0; i<count; i++)
    {
        int row = i / maxColPerRow;
        int col = i % maxColPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = margin + col * (imageViewW + margin);
    }
}

- (NSMutableArray*)images
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    
    return array;
}

@end
