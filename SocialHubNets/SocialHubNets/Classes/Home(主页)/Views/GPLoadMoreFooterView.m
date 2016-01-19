//
//  GPLoadMoreFooterView.m
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPLoadMoreFooterView.h"

@interface GPLoadMoreFooterView()

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation GPLoadMoreFooterView

+ (id)loadingMoreFooterView
{
    UINib *nib = [UINib nibWithNibName:@"GPLoadMoreFooterView" bundle:nil];
    NSArray *array = [nib instantiateWithOwner:nil options:nil];
    return [array lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在努力加载中...";
    [self.loadingView startAnimating];
    self.isRefreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.isRefreshing = NO;
}

@end
