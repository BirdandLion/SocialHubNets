//
//  GPStatusDetailFrame.h
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPStatuses, GPStatusOriginalFrame, GPStatusRetweetedFrame;

@interface GPStatusDetailFrame : NSObject

@property (nonatomic, strong) GPStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) GPStatusRetweetedFrame *retweetedFrame;
@property (nonatomic, assign) CGRect frame;

// 微博数据
@property (nonatomic, strong) GPStatuses *status;

@end
