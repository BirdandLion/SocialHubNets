//
//  GPSearchBar.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPSearchBar.h"

@implementation GPSearchBar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 设置背景
        self.background = [UIImage resizedImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
        // 设置内容居中对齐
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 设置左边的放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        // 设置leftview的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        // 设置右边永远显示清楚按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (id)searchBar
{
    return [[self alloc] init];
}

@end
