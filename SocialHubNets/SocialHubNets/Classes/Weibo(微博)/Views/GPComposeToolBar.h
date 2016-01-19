//
//  GPComposeToolBar.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 以后用这种方式写枚举 : 输入: enumdef
typedef enum : NSUInteger {
    GPComposeToolBarButtonTypeCamera = 0,
    GPComposeToolBarButtonTypePicture,
    GPComposeToolBarButtonTypeMention,
    GPComposeToolBarButtonTypeTrend,
    GPComposeToolBarButtonTypeEmotion
} GPComposeToolBarButtonType;


@class GPComposeToolBar;
@protocol GPComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(GPComposeToolBar*)toolbar didClickedButton:(GPComposeToolBarButtonType)buttonType;

@end

@interface GPComposeToolBar : UIView

@property (nonatomic, assign) BOOL showEmotionButton;

@property (nonatomic, weak) id<GPComposeToolBarDelegate> delegate;

@end
