//
//  GPPopMenu.h
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

enum GPPopMenuPopMenuArrowPosition
{
    GPPopMenuPopMenuArrowPositionCenter,
    GPPopMenuPopMenuArrowPositionLeft,
    GPPopMenuPopMenuArrowPositionRight
};
typedef enum GPPopMenuPopMenuArrowPosition GPPopMenuPopMenuArrowPosition;

@class GPPopMenu;

@protocol GPPopMenuCoverClickedDelegate <NSObject>

- (void)popMenuCoverClickedWithPopMenu:(GPPopMenu*)popMenu;

@end

@interface GPPopMenu : UIView

@property (nonatomic, weak) id <GPPopMenuCoverClickedDelegate> delegate;

// 背景图片
@property (nonatomic, strong) UIImage *backgroundImage;

// 填出图片的箭头方向
@property (nonatomic, assign) GPPopMenuPopMenuArrowPosition arrowPosition;
// 填出视图的外部视图变暗
@property (nonatomic, assign, getter=isDimBackground) BOOL dimBackground;

// 初始化函数
- (id)initWithContentView:(UIView *)contentView;
+ (id)popMenuWithContentView:(UIView *)contentView;

- (void)showPopMenuWithRect:(CGRect)frame;

@end
