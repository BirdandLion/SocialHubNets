//
//  GPLoadMoreFooterView.h
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPLoadMoreFooterView : UIView

@property (nonatomic, assign) BOOL isRefreshing;

+ (id)loadingMoreFooterView;

- (void)beginRefreshing;
- (void)endRefreshing;

@end

