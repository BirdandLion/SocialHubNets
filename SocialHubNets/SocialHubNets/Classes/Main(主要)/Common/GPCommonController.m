//
//  GPCommonController.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPCommonController.h"
#import "GPCommonGroup.h"
#import "GPCommonItem.h"
#import "GPCommonCell.h"

@interface GPCommonController ()

@property (nonatomic, copy) NSMutableArray *groups;

@end

@implementation GPCommonController

/**
 用一个模型来描述没组的信息:组头, 组尾
 用一个模型来描述每行的信息, 图标,子标题,右边的样式(箭头,数字,开关,打钩)
 */

- (NSMutableArray*)groups
{
    if(_groups == nil)
    {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

// 屏蔽tableView的样式
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
        
    // 设置tableView的属性
    self.tableView.backgroundColor = GPGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    GPCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPCommonGroup *group = self.groups[indexPath.section];
    GPCommonItem *item = group.items[indexPath.row];
    
    GPCommonCell *cell = [GPCommonCell cellWithTableView:tableView];
    cell.item = item;
    [cell setIndexPath:indexPath RowsInSection:group.items.count];
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GPCommonGroup *group = self.groups[section];
    return group.header;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    GPCommonGroup *group = self.groups[section];
    return group.footer;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    GPCommonGroup *group = self.groups[indexPath.section];
    GPCommonItem *item = group.items[indexPath.row];
    
    // 判断是否有控制器
    if(item.destVcClass)
    {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 调用item的block
    if(item.operation)
    {
        item.operation();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
