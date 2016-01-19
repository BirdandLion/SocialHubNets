//
//  GPEmotionToolbar.h
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  表情底部的工具条

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GPEmotionToolbarButtonTypeLatest,
    GPEmotionToolbarButtonTypeDefault,
    GPEmotionToolbarButtonTypeEmoij,
    GPEmotionToolbarButtonTypeLxh
} GPEmotionToolbarButtonType;

@class GPEmotionToolbar;

@protocol GPEmotionToolbarDelegate <NSObject>

- (void)emotionToolbar:(GPEmotionToolbar*)toolbar didSelectedButton:(GPEmotionToolbarButtonType)buttonType;

@end

@interface GPEmotionToolbar : UIView

@property (nonatomic, weak) id <GPEmotionToolbarDelegate> delegate;

@end
