//
//  GPHomeViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPHomeViewController.h"
#import "GPTitleButton.h"
#import "GPPopMenu.h"
#import "UIImageView+WebCache.h"
#import "GPLoadMoreFooterView.h"
#import "GPAccountTool.h"
#import "GPStatusTool.h"
#import "GPUserInfoTool.h"
#import "GPStatusFrame.h"
#import "GPStatusCell.h"
#import "GPStatusDetailViewController.h"

@interface GPHomeViewController ()<GPPopMenuCoverClickedDelegate>

@property (nonatomic, strong) NSMutableArray *statusesFrame;
@property (nonatomic, weak) GPLoadMoreFooterView *footer;
@property (nonatomic, weak) GPTitleButton *titleButton;
@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end

@implementation GPHomeViewController

- (NSMutableArray*)statusesFrame
{
    if(_statusesFrame == nil)
    {
        _statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = GPGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏内容
    [self setupNavBar];
    
    // 集成刷新控件
    [self setupRefresh];
    
    // 加载最新的数据
    [self setupUserInfo];
    
    // 监听链接选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:GPLinkDidSelectedNotification object:nil];
}

- (void)linkDidSelected:(NSNotification*)note
{
    NSString *linkText = note.userInfo[GPLinkText];
    if([linkText hasPrefix:@"http"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
    }
    else
    {
        GPLog(@"打开了非http链接: %@", note.userInfo[GPLinkText]);
    }
}

// 获取用户信息
- (void)setupUserInfo
{
    // 1. 封装请求参数
    GPUserInfoParam *params = [[GPUserInfoParam alloc] init];
    params.access_token = [GPAccountTool account].access_token;
    params.uid = @([[GPAccountTool account].uid longLongValue]);
    
    // 2. 加载用户数据
    [GPUserInfoTool userInfoWithParams:params success:^(GPUserInfoReuslt *result) {

        // 显示用户名
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        
        // 存储用户昵称
        GPAccountModel *account = [GPAccountTool account];
        account.name = result.name;
        [GPAccountTool saveWithAccount:account];
        
    } failure:^(NSError *error) {
        GPLog(@"error: %@", error);
    }];
}

// 集成刷新控件
- (void)setupRefresh
{
    // 1. 添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.view addSubview:refreshControl];
    self.refreshControl =refreshControl;
    // 2. 监听控件
    [refreshControl addTarget:self action:@selector(loadNewStatuses:) forControlEvents:UIControlEventValueChanged];
    // 3. 自动刷新
    [refreshControl beginRefreshing];
    
    // 4. 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loadNewStatuses:refreshControl];
    });
    
    // 5. 添加上来加载更多
    GPLoadMoreFooterView *footer = [GPLoadMoreFooterView loadingMoreFooterView];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

// 设置导航栏
- (void)setupNavBar
{
    // 设置导航栏左item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highligthImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    // 设置导航栏右item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highligthImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置导航栏中间的标题按钮
    GPTitleButton *titleButton = [GPTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleButton = titleButton;
    titleButton.height = 40;
    //    titleButton.width = 100;
    NSString *name = [GPAccountTool account].name;
    
    [titleButton setTitle:(name ? name : @"首页") forState:UIControlStateNormal];
    
    // 设置按钮图片
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置按钮背景图片
    UIImage *image = [UIImage resizedImage:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"]];
    [titleButton setBackgroundImage:image forState:UIControlStateHighlighted];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 加载最新的微博数据
- (void)loadNewStatuses:(UIRefreshControl*)refresh
{    
    // 1. 封装请求参数
    GPHomeStatusesParam *params = [[GPHomeStatusesParam alloc] init];
    params.access_token = [GPAccountTool account].access_token;
    GPStatusFrame *firstStatusFrame = [self.statusesFrame firstObject];
    GPStatuses *firstStatus = firstStatusFrame.status;
    if(firstStatus)
    {
        params.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 2. 加载微博数据
    [GPStatusTool homeStatusWithParams:params success:^(GPHomeStatusesResult *result) {
        NSArray *newFrames = [self statusFrameWithStatuses:result.statuses];
        // 将微博数组转出frame数组
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrame insertObjects:newFrames atIndexes:indexSet];
        
        // 重新加载数据
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新
        [refresh endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusCount:newFrames.count];
        GPLog(@"%ld", newFrames.count);

    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
        // 让刷新控件停止刷新
        [refresh endRefreshing];
    }];
}

// 根据微博模型数组转成微博frame数组
- (NSArray*)statusFrameWithStatuses:(NSArray*)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (GPStatuses *status in statuses) {
        GPStatusFrame *frame = [[GPStatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

// 加载旧的微博数据
- (void)loadOldStatuses
{    
    // 1. 封装参数请求
    GPHomeStatusesParam *params = [[GPHomeStatusesParam alloc] init];
    params.access_token = [GPAccountTool account].access_token;
    GPStatusFrame *lastFrame = [self.statusesFrame lastObject];
    GPStatuses *lastStatus = lastFrame.status;
    if(lastStatus)
    {
        params.max_id = @([lastStatus.idstr longLongValue]);
    }
    
    // 2. 加载数据
    [GPStatusTool homeStatusWithParams:params success:^(GPHomeStatusesResult *result) {
        NSArray *newFrame = [self statusFrameWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的后面
        [self.statusesFrame addObjectsFromArray:newFrame];
        
        // 重新加载数据
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新
        [self.footer endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusCount:newFrame.count];
        GPLog(@"%ld", newFrame.count);
        
    } failure:^(NSError *error) {
        
        NSLog(@"error: %@", error);
        // 让刷新控件停止刷新
        [self.footer  endRefreshing];
        
    }];
}

// 显示刷新的几条微博数据
- (void)showNewStatusCount:(NSInteger)count
{
    // 0. 清零提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.integerValue;
    self.tabBarItem.badgeValue = nil;
    
    // 1. 创建label
    UILabel *label = [[UILabel alloc] init];
    // 2. 创建文字
    if(count)
    {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据", count];
    }
    else
    {
        label.text = @"没有最新的微博数据";
    }
    // 3. 设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    // 4. 设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    // 5. 添加到导航控制器
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 6. 动画 : 如果要恢复原来的位置,用transform
    CGFloat duration = 0.6;
    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置(清空transform)
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

// 点击导航栏title,弹出提示框
- (void)titleClick:(UIButton*)titleButton
{
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 设置弹出框
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    GPPopMenu *popMenu = [GPPopMenu popMenuWithContentView:button];
    popMenu.delegate = self;
    popMenu.dimBackground = YES;
    popMenu.arrowPosition = GPPopMenuPopMenuArrowPositionCenter;
    [popMenu showPopMenuWithRect:CGRectMake(87 , 100, 200, 400)];
}

// 点击了导航栏左item
- (void)friendSearch
{
    GPLog(@"friendSearch");
}

// 点击了导航栏右item
- (void)pop
{
    GPLog(@"pop");
}

#pragma mark - 更新未读消息数
- (void)refresh:(BOOL)fromSelf
{
    if(self.tabBarItem.badgeValue)
    {
        self.tabBarItem.badgeValue = nil;
        [self.refreshControl beginRefreshing];
        [self loadNewStatuses:self.refreshControl];
    }
    else if(fromSelf)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - GPPopMenuCoverClickedDelegate

- (void)popMenuCoverClickedWithPopMenu:(GPPopMenu *)popMenu
{
    GPTitleButton *titleButton = (GPTitleButton*)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 每次加载数据时, 判断是否显示footerView
    tableView.tableFooterView.hidden = self.statusesFrame.count == 0;
    
    return self.statusesFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GPStatusCell *cell = [GPStatusCell statusCellWithTableView:tableView];
    
    cell.statusFrame = self.statusesFrame[indexPath.row];

    return cell;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPStatusFrame *statusFrame = self.statusesFrame[indexPath.row];
    GPStatusDetailViewController *detailController = [[GPStatusDetailViewController alloc] init];
    detailController.status = statusFrame.status;
    [self.navigationController pushViewController:detailController animated:YES]; 
}

// 修改cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPStatusFrame *frame = self.statusesFrame[indexPath.row];
    return frame.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.statusesFrame.count == 0 || self.footer.isRefreshing)
    {
//        NSLog(@"跳出盘帝国");
        return;
    }
    
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能看到整个footer
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    if(delta <= (sawFooterH - 0))
    {
//        NSLog(@"看全了footer");
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadOldStatuses];
        });
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
