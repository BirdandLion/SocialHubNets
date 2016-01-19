//
//  GPSettingsViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPSettingsViewController.h"
#import "GPCommonGroup.h"
#import "GPCommonLabelItem.h"
#import "GPCommonArrowItem.h"
#import "GPGeneralSettingViewController.h"

@interface GPSettingsViewController ()

@end

@implementation GPSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"设置";
    
    // 初始化组模型数据
    [self setupGroups];
    
    [self setupFooter];
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
    GPCommonArrowItem *account = [GPCommonArrowItem itemWithTitle:@"账号管理" icon:nil];
    
    // 4. 设置组数据
    group.items = @[account];
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
    GPCommonArrowItem *notify = [GPCommonArrowItem itemWithTitle:@"通知" icon:nil];
    GPCommonArrowItem *private = [GPCommonArrowItem itemWithTitle:@"隐私与安全" icon:nil];
    GPCommonArrowItem *universal = [GPCommonArrowItem itemWithTitle:@"通用" icon:nil];
    universal.destVcClass = [GPGeneralSettingViewController class];
    
    // 4. 设置组数据
    group.items = @[notify, private, universal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFooter
{
    // 1. 创建控件
    UIButton *logout = [[UIButton alloc] init];
    // 2. 设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [logout setTitleColor:GPColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImageName:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImageName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    // 3. 设置尺寸
    logout.height = 44;
    
    self.tableView.tableFooterView = logout;
}

@end
