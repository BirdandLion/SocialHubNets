//
//  GPEmotionPopView.h
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPEmotionView;

@interface GPEmotionPopView : UIView

+ (id)emotionPopView;

- (void)dismiss;

- (void)showFromEmotionView:(GPEmotionView*)fromEmotionView;

@end
