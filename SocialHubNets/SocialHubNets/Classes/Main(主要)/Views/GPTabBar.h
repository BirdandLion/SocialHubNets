//
//  GPTabBar.h
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPTabBar;

@protocol GPTabBarDelegate <NSObject>

- (void)tabBarDidClickedPlusButton:(GPTabBar*)tabBar;

@end

@interface GPTabBar : UITabBar

@property (nonatomic, weak) id<GPTabBarDelegate> tabBardelegate;

@end
