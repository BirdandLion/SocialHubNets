//
//  GPEmotionTextView.h
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPTextView.h"
@class GPEmotion;

@interface GPEmotionTextView : GPTextView

- (void)appendEmotion:(GPEmotion*)emotion;

- (NSString*)realText;

@end
