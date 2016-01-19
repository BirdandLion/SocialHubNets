//
//  GPDiscoverViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPDiscoverViewController.h"
#import "GPSearchBar.h"
#import "GPCommonGroup.h"
#import "GPCommonItem.h"
#import "GPCommonCell.h"
#import "GPCommonArrowItem.h"
#import "GPCommonSwitchItem.h"
#import "GPCommonLabelItem.h"
#import "GPCommonCheckItem.h"

#import "GPOneViewController.h"
#import "GPTwoViewController.h"
#import "GPThreeViewController.h"

@interface GPDiscoverViewController ()

@end

@implementation GPDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    // 搜索框
    GPSearchBar *searchBar = [GPSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
        
    // 初始化组模型数据
    [self setupGroups];
    
    // 设置header, footer
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1. 创建组
    GPCommonGroup *group = [GPCommonGroup group];
    [self.groups addObject:group];
    
    // 2. 设置组头尾数据
    group.header = @"第0组头部";
    group.header = @"第0组尾部";
    
    // 3. 设置组的所有行数据
    GPCommonArrowItem *hotStatus = [GPCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话、娱乐, 神最右都搬到这里啦";
    hotStatus.destVcClass = [GPOneViewController class];
    
    GPCommonItem *findPeople = [GPCommonItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subtitle = @"名人、有意思的人都在这里";
    
    // 4. 设置组数据
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1. 创建组
    GPCommonGroup *group = [GPCommonGroup group];
    [self.groups addObject:group];
    
    // 2. 设置组数据
    group.header = @"第1组头部";
    group.header = @"第1组尾部";
    
    // 3. 设置组的所有行数据
    GPCommonItem *gameCenter = [GPCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.badgeValue = @"9999";
    GPCommonLabelItem *near = [GPCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.subtitle = @"(10)";
    near.text = @"周边";
    GPCommonItem *app = [GPCommonItem itemWithTitle:@"应用" icon:@"app"];
    
    // 4. 设置组数据
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1. 创建组
    GPCommonGroup *group = [GPCommonGroup group];
    [self.groups addObject:group];
    
    // 2. 设置组数据
    group.header = @"第2组头部";
    group.header = @"第2组尾部";
    
    // 3. 设置组的所有行数据
    GPCommonSwitchItem *video = [GPCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    GPCommonCheckItem *music = [GPCommonCheckItem itemWithTitle:@"音乐" icon:@"music"];
    GPCommonItem *movie = [GPCommonItem itemWithTitle:@"电影" icon:@"movie"];
    GPCommonItem *cast = [GPCommonItem itemWithTitle:@"博客" icon:@"cast"];
    cast.operation = ^{
        GPLog(@"博客");
    };
    GPCommonItem *more = [GPCommonItem itemWithTitle:@"更多" icon:@"more"];
    more.operation = ^{
        GPLog(@"更多");
    };
    // 4. 设置组数据
    group.items = @[video, music, movie, cast, more];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
