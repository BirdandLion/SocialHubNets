//
//  GPStatusDetailViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusDetailViewController.h"
#import "GPHomeModel.h"
#import "GPStatusDetailFrame.h"
#import "GPStatusDetailView.h"
#import "GPStatusDetailBottomToolbar.h"

@interface GPStatusDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) GPStatusDetailBottomToolbar *toolbar;

@end

@implementation GPStatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    // 创建tableView
    [self setupTableView];
    
    // 创建微博详情控件
    [self setupDetailView];
    
    // 创建底部工具条
    [self setupToolbar];
}

// 创建底部工具条
- (void)setupToolbar
{
    GPStatusDetailBottomToolbar *toolbar = [[GPStatusDetailBottomToolbar alloc] init];
    [self.view addSubview:toolbar];
    toolbar.y = self.tableView.height;
    toolbar.width = self.view.width;
    toolbar.height = self.view.height - self.tableView.height;
    self.toolbar = toolbar;
}

// 创建tableView
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.width = self.view.width;
    tableView.height = self.view.height - 49;
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GPGlobalBackgroundColor;
}

// 创建微博详情控件
- (void)setupDetailView
{
    // 创建微博详情控件
    GPStatusDetailView *detailView = [[GPStatusDetailView alloc] init];
    // 创建frame对象
    GPStatusDetailFrame *frame = [[GPStatusDetailFrame alloc] init];
    // 工具条不显示在转发微博的正文中
    self.status.retweeted_status.detail = YES;
    frame.status = self.status;
    detailView.detailFrame = frame;
    
    self.tableView.tableHeaderView = detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"kelvin";
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
