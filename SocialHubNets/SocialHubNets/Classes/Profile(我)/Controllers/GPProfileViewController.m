//
//  GPProfileViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPProfileViewController.h"
#import "GPCommonGroup.h"
#import "GPCommonLabelItem.h"
#import "GPCommonCheckItem.h"
#import "GPCommonArrowItem.h"
#import "GPCommonSwitchItem.h"
#import "GPSettingsViewController.h"

@interface GPProfileViewController ()

@end

@implementation GPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting:)];
    
    // 初始化组模型数据
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
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
    GPCommonArrowItem *newFriend = [GPCommonArrowItem itemWithTitle:@"新的好用" icon:@"new_friend"];
    
    // 4. 设置组数据
    group.items = @[newFriend];
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
    GPCommonArrowItem *album = [GPCommonArrowItem itemWithTitle:@"相册" icon:@"album"];
    GPCommonArrowItem *collect = [GPCommonArrowItem itemWithTitle:@"收藏" icon:@"collect"];
    GPCommonArrowItem *like = [GPCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    
    // 4. 设置组数据
    group.items = @[album, collect, like];
}

#pragma mark - 设置按钮点击

- (void)setting:(UIBarButtonItem*)rightButtonItem
{
    GPSettingsViewController *settingsController = [[GPSettingsViewController alloc] init];
    settingsController.title = rightButtonItem.title;
    [self.navigationController pushViewController:settingsController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
