//
//  GPStatusFrame.h
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  一个frame包含一个cell内部所有的子空间的frame和显示数据

#import <Foundation/Foundation.h>

@class GPStatuses, GPStatusDetailFrame;

@interface GPStatusFrame : NSObject

// 内容空间的frame数据
@property (nonatomic, strong
           ) GPStatusDetailFrame *detailFrame;
// 工具条的frame
@property (nonatomic, assign) CGRect toolbarFrame;

// cell 的高度
@property (nonatomic, assign) CGFloat cellHeight;

// 微博数据
@property (nonatomic, strong) GPStatuses *status;

@end
