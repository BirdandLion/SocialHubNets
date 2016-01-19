//
//  GPGeneralSettingViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPGeneralSettingViewController.h"
#import "GPCommonGroup.h"
#import "GPCommonLabelItem.h"
#import "GPCommonCheckItem.h"
#import "GPCommonArrowItem.h"
#import "GPCommonSwitchItem.h"

@interface GPGeneralSettingViewController ()

@end

@implementation GPGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化组模型数据
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
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
    GPCommonLabelItem *readMode = [GPCommonLabelItem itemWithTitle:@"阅读模式" icon:nil];
    readMode.text = @"有图模式";
    
    // 4. 设置组数据
    group.items = @[readMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
