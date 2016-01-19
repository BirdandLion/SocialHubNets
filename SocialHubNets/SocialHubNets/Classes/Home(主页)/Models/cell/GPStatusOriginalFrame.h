//
//  GPStatusOriginalFrame.h
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPHomeModel.h"

@interface GPStatusOriginalFrame : NSObject

@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect vipFrame;
@property (nonatomic, assign) CGRect photosFrame;

// 自己的frame
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) GPStatuses *status;

@end
