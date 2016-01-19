//
//  GPStatusRetweetedFrame.h
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPHomeModel.h"

@interface GPStatusRetweetedFrame : NSObject

//@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect photosFrame;
@property (nonatomic, assign) CGRect toolbarFrame;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) GPStatuses *retweetedStatus;

@end
