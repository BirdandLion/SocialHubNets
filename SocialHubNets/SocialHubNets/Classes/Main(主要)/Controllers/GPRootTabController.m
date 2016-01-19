//
//  GPRootTabController.m
//  新浪微博(kelvin)
//
//  Created by qianfeng on 16/1/7.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPRootTabController.h"
#import "GPRootNavController.h"

#import "GPHomeViewController.h"
#import "GPMessageViewController.h"
#import "GPDiscoverViewController.h"
#import "GPProfileViewController.h"

#import "GPTabBar.h"
#import "GPComposeViewController.h"

#import "GPUserInfoTool.h"
#import "GPAccountTool.h"
#import "GPAccountModel.h"

@interface GPRootTabController () <GPTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) GPHomeViewController *homeController;
@property (nonatomic, weak) GPMessageViewController *messageController;
@property (nonatomic, weak) GPProfileViewController *mineController;
@property (nonatomic, weak) UIViewController *lastSelectedViewController;

@end

@implementation GPRootTabController

// 测试图片超出tabBarItem的图片
// popover_background   

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加所有的控制器
    [self addAllControllers]; 
    
    // 添加自定义的tabBar
    [self addCustomTabBar];
    
    // 利用定时器获取用户未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 获取用户读取APP的icon的权限
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    // 设置自己是自己的代理
    self.delegate = self;
}

// 利用定时器获取用户未读数
- (void)getUnreadCount
{
    GPUnreadCountParam *param = [[GPUnreadCountParam alloc] init];
    param.access_token = [GPAccountTool account].access_token;
    param.uid = [GPAccountTool account].uid;
    
    [GPUserInfoTool userUnreadCountWithParams:param success:^(GPUnreadCountResult *result) {
        NSLog(@"----- %@", result.status);
        
        // 获取首页显示的未读的信息数
        NSInteger unReadCount = [result.status integerValue];
        if(unReadCount == 0)
        {
            self.homeController.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.homeController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", unReadCount];
        }
        
        // 获取消息显示的未读的信息数
        unReadCount = result.messageCount;
        if(unReadCount == 0)
        {
            self.messageController.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.messageController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", unReadCount];
        }
        
        // 获取我显示的未读的信息数
        unReadCount = [result.follower integerValue];
        if(unReadCount == 0)
        {
            self.messageController.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.messageController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", unReadCount];
        }
        
        // 在图片上面显示未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
                
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

// 添加自定义的tabBar
- (void)addCustomTabBar
{
    GPTabBar *customTabBar = [[GPTabBar alloc] init];
    //    customTabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
//    customTabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
    // 必须写在KVC前,否则崩溃
    customTabBar.tabBardelegate = self;
    [self setValue:customTabBar forKeyPath:@"tabBar"];
//    
}

// 添加所有的控制器
- (void)addAllControllers
{
    GPHomeViewController *homeController = [[GPHomeViewController alloc] init];
    [self setItemWithController:homeController title:@"首页" iamgeName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.homeController = homeController;
    
    GPMessageViewController *messageController = [[GPMessageViewController alloc] init];
    [self setItemWithController:messageController title:@"消息" iamgeName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.messageController = messageController;
    
    GPDiscoverViewController *discoverController = [[GPDiscoverViewController alloc] init];
    [self setItemWithController:discoverController title:@"发现" iamgeName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    GPProfileViewController *mineController = [[GPProfileViewController alloc] init];
    [self setItemWithController:mineController title:@"我" iamgeName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.mineController = mineController;
    
    NSLog(@"%@", self.tabBar.items);
    
    self.lastSelectedViewController = homeController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setItemWithController:(UIViewController*)viewController title:(NSString *)title iamgeName:(NSString *)imageName selectedImageName:(NSString*)selectedImageName
{
    // 创建导航
    GPRootNavController *nav = [[GPRootNavController alloc] initWithRootViewController:viewController];
    
    // 设置navagitionitem和tabbaritem的title
    viewController.title = title;
    
    self.tabBarItem.badgeValue = @"5";

//     设置tabBarItem的title颜色
    NSDictionary *tabAttr = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
    [viewController.tabBarItem setTitleTextAttributes:tabAttr forState:UIControlStateSelected];
//    // 设置navigationItem的title颜色
//    NSDictionary *navAttr = @{NSForegroundColorAttributeName: [UIColor blackColor]};
//    [nav.navigationBar setTitleTextAttributes:navAttr];
    // 默认会对selected图片进行渲染,设置不进行渲染
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 添加子控制器
    [self addChildViewController:nav];
}

#pragma mark - GPTabBarDelegate

- (void)tabBarDidClickedPlusButton:(GPTabBar *)tabBar
{
    GPComposeViewController *composeController = [[GPComposeViewController alloc] init];
    GPRootNavController *nav = [[GPRootNavController alloc] initWithRootViewController:composeController];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -- UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    // 取出UINavigationController的栈顶控制器(被选中的控制器)
    UIViewController *currentController = [viewController.viewControllers firstObject];
    if([currentController isKindOfClass:[GPHomeViewController class]])
    {
        [self.homeController refresh:(self.lastSelectedViewController == currentController)];
    }
    
    self.lastSelectedViewController = currentController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
