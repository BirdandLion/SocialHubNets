//
//  GPStatusPhotosView.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusPhotosView.h"
#import "GPStatusPhotoView.h"
#import "GPHomeModel.h"

#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define GPStatusPhotosMaxCount  9
#define GPStatusPhotoW          70
#define GPStatusPhotoH GPStatusPhotoW
#define GPStatusPhotoMargin     10

#define GPStatusPhotosMaxCols(photosCount)   ((photosCount == 4) ? 2 : 3)

@interface GPStatusPhotosView()

// 点击放大后的图片
@property (nonatomic, weak) UIImageView *imageView;
// 点击前图片的frame
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation GPStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        for(int i=0; i < GPStatusPhotosMaxCount; i++)
        {
            GPStatusPhotoView *photoView = [[GPStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势(一个手势监听器, 只能监听一个view)
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

- (void)tapPhoto:(UITapGestureRecognizer*)recognizer
{
    // 1. 创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2. 设置图片浏览器显示的图片
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for(int i=0; i<count; i++)
    {
        GPPhoto *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片地址
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置图片来源于那个视图
        photo.srcImageView = self.subviews[i];
        
        // 添加到图片相册
        [photos addObject:photo];
    }
    
    // 3. 添加浏览器相册
    browser.photos = photos;
    
    // 4. 显示浏览器
    [browser show];
    
    
//    // 1. 添加一个遮盖
//    UIView *cover = [[UIView alloc] init];
//    cover.frame = SCREEN_FRAME;
//    cover.backgroundColor = [UIColor blackColor];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    // 添加手势(一个手势监听器, 只能监听一个view)
//    UITapGestureRecognizer *coverRecognizer = [[UITapGestureRecognizer alloc] init];
//    [coverRecognizer addTarget:self action:@selector(tapCover:)];
//    [cover addGestureRecognizer:coverRecognizer];
//    
//    // 2. 添加图片到遮盖上
//    GPStatusPhotoView *photoView = (GPStatusPhotoView*)recognizer.view;
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
//    imageView.frame = [self convertRect:photoView.frame toView:cover];
//    self.lastFrame = imageView.frame;
//    [cover addSubview:imageView];
//    self.imageView = imageView;
//    
//    // 3. 放大
//    [UIView animateWithDuration:1.0 animations:^{
//        CGRect frame = imageView.frame;
//        frame.size.width = cover.width;
//        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
//        frame.origin.x = 0;
//        frame.origin.y = (cover.height - frame.size.height) * 0.5;
//        imageView.frame = frame;
//    }];
}

//// 点击遮盖
//- (void)tapCover:(UITapGestureRecognizer*)recognizer
//{
//    GPLog(@"tapCover");
//    [UIView animateWithDuration:1.0 animations:^{
//        recognizer.view.backgroundColor = [UIColor clearColor];
//        self.imageView.frame = self.lastFrame;
//    } completion:^(BOOL finished) {
//        [recognizer.view removeFromSuperview];
//        self.imageView = nil;
//    }];
//}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for(int i=0; i<GPStatusPhotosMaxCount; i++)
    {
        GPStatusPhotoView *photoView = self.subviews[i];
        photoView.hidden = YES;
        
        if(i < pic_urls.count)
        {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        }
    }
}

+ (CGSize)sizeWithPhotosCount:(int)count
{
    /* 知道总个数, 计算需要多少行, 多少列 */
    // 一行最多几列
    int maxCols = GPStatusPhotosMaxCols(count);
    
    CGFloat photoMargin = GPStatusPhotoMargin;
    // 相框的宽高
    CGFloat photoW = GPStatusPhotoW;
    CGFloat photoH = GPStatusPhotoH;
    
    // 总行数
    int totalRows = (count + maxCols - 1) / maxCols;
    // 总列数
    int totalCols = (count >= maxCols) ? maxCols : count;

    CGFloat photosW = totalCols * photoW + (totalCols - 1) * photoMargin;
    CGFloat photosH = totalRows * photoH + (totalRows - 1) * photoMargin;
    
    return CGSizeMake(photosW, photosH);
}

// 设置子控件
- (void)layoutSubviews
{
    NSInteger count = self.pic_urls.count;
    int maxCols = GPStatusPhotosMaxCols(count);
    
    for(int i=0; i<count; i++)
    {
        GPStatusPhotoView *photoView = self.subviews[i];
        photoView.width = GPStatusPhotoW;
        photoView.height = GPStatusPhotoH;
        photoView.x = (i % maxCols) * (GPStatusPhotoW + GPStatusPhotoMargin);
        photoView.y = (i / maxCols) * (GPStatusPhotoH + GPStatusPhotoMargin);
    }
}

@end
