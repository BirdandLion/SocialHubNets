//
//  GPEmotionPopView.m
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionPopView.h"
#import "GPEmotionView.h"

@interface GPEmotionPopView()

@property (strong, nonatomic) IBOutlet GPEmotionView *emotionView;

@end

@implementation GPEmotionPopView

+ (id)emotionPopView
{
    NSString *className = NSStringFromClass([GPEmotionPopView class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
    
}

// 显示表情弹出的控件
// param: emotionView, 从哪儿表情上弹出
- (void)showFromEmotionView:(GPEmotionView*)fromEmotionView
{
    if(fromEmotionView == nil) return;
    
    // 1. 显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2. 添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3. 设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    // 4. 转换坐标系到父窗口
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

// 如果是init方法初始化的对象,没有直接给出尺寸,不会调用该方法, 除非初始化时给出尺寸( xib肯定会调用该方法, 因为有尺寸 )
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}


@end
