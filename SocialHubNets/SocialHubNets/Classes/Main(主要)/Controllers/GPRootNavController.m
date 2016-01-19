//
//  GPRootNavController.m
//  新浪微博(kelvin)
//
//  Created by qianfeng on 16/1/7.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPRootNavController.h"

@interface GPRootNavController ()

@end

@implementation GPRootNavController

// 当第一次使用这个类的时候调用一次
+ (void)initialize
{
    [self setNavigationBarItem];
    [self setupBarButtonItem];
}

+ (void)setNavigationBarItem
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
//    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forBarMetrics:UIBarMetricsDefault];
    // 设置navigationItem的title颜色
    NSDictionary *navAttr = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:24]};
    // NSShadowAttributeName: [NSValue valueWithUIOffset:UIOffsetZero] 加上shadow会崩溃
    [appearance setTitleTextAttributes:navAttr];
    
}

+ (void)setupBarButtonItem
{
    // 通过appearance对象可以修改整个项目的UIBarButtonItem的文字颜色, 大小
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    // 设置normal状态的颜色和字体
    NSDictionary *textAttrs = @{NSForegroundColorAttributeName: [UIColor orangeColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置Highlighted状态的颜色和字体
    NSDictionary *highTextAttrs = @{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置Disabled状态的颜色和字体
    NSDictionary *disableAttrs = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [appearance setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count == 0)
    {
    }
    else
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highligthImageName:@"navigationbar_back_highlighted" target:self action:@selector(backAction)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highligthImageName:@"navigationbar_more_highlighted" target:self action:@selector(moreAction)];
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)backAction
{
    GPLog(@"left item");
    [self popViewControllerAnimated:YES];
}

- (void)moreAction
{
    GPLog(@"home");
    [self popToRootViewControllerAnimated:YES];
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
