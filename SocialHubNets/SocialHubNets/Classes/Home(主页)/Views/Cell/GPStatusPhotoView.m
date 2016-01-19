//
//  GPStatusPhotoView.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusPhotoView.h"
#import "UIImageView+WebCache.h"

@interface GPStatusPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation GPStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    { 
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 这种方式的gifView尺寸与图片相同
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
        // 添加gif图标(这种方式的gifView没有尺寸)
//        UIImageView *gifView = [[UIImageView alloc] init];
//        gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
    }
    return self;
}

- (void)setPhoto:(GPPhoto *)photo
{
    _photo = photo; 
    // 1. 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 2. 控制gif图标的显示 pathExtension
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
