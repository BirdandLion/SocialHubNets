//
//  GPTabBar.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPTabBar.h"

@interface GPTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation GPTabBar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusButton];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"]  forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"]  forState:UIControlStateHighlighted];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
    }
    return self;
}

- (void)plusButtonClick
{
//    GPLog(@"plusButtonClick---");
    [self.tabBardelegate tabBarDidClickedPlusButton:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupTabBarButtonFrame];
    [self setupPlusButtonFrame];
    
//    NSLog(@"layoutSubviews");
}

- (void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

- (void)setupTabBarButtonFrame
{
    int index = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    
    for(UIView *tabBarButton in self.subviews)
    {
        if(![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        
        tabBarButton.width = buttonW;
        tabBarButton.height = buttonH;
        tabBarButton.y = 0;
        if(index >= 2)
        {
            tabBarButton.x = (index + 1) * tabBarButton.width;
        }
        else
        {
            tabBarButton.x = index * tabBarButton.width;
        }
        
        // 设置图片超出tabBarItem的时候,重新设置大小
//        GPLog(@"%@", NSStringFromClass([tabBarButton class]));
//        GPLog(@"%@", tabBarButton.subviews);
//        for(UIView *tabBarImageView in tabBarButton.subviews)
//        {
//            if([tabBarImageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
//            {
//                tabBarImageView.width = 30;
//                tabBarImageView.height = 30;
//            }
//        }
        
        index++;
    }
}

@end
