//
//  GPNewFeatureController.m
//  我的微博
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPNewFeatureController.h"
#import "GPRootTabController.h"

/*
 * 一个控件能看见,但是点击无反应
 * 1. UIControl *control; control.enabled
 * 2. UIView *view; view.userInteractionEnabled
 * 3. 控件不在父控件的视图范围内
 * 4. 控件被一个clearColor的控件挡住
 * 5. 父控件的上面的4种请客
 
 * 创建了一个控件,就是看不见
 * 1. 当前控件没有添加到父控件
 * 2. 当前控件没有frame
 * 3. 当前控件的位置不在屏幕范围内
 * 4. 当前控件背景色为clearColor
 * 5. 当前控件的hidden为YES
 * 6. 当前控件的alpha<=0.01
 * 7. 被其他控件挡住了
 * 8. 当前控件是现实图片的控件,但是图片不存在或没有设置图片
 * 9. 当前现实控件是现实文字的控件,文字颜色和背景色一样,比如UILbael, UIButton
 * 10. 检测父控件的前9中情况
 */

#define NUMBEROFSCROLLPAGES 4

@interface GPNewFeatureController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

//@property (nonatomic, assign) BOOL flag;

@end

@implementation GPNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScrollView];
    [self addPageControl];
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    
    CGFloat imageW = SCREEN_WIDTH;
    CGFloat imageH = SCREEN_HEIGHT;
    CGFloat imageY = 0;
    
    for(int i=0; i<NUMBEROFSCROLLPAGES; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d", i + 1]];
        
        CGFloat imageX = imageW * i;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        if(i == NUMBEROFSCROLLPAGES - 1)
        {
            imageView.userInteractionEnabled = YES;
            
            UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];;
            [imageView addSubview:startButton];
            [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
            startButton.size = startButton.currentBackgroundImage.size;
            startButton.centerX = SCREEN_WIDTH * 0.5;
            startButton.centerY = SCREEN_HEIGHT * 0.8;
            [startButton addTarget:self action:@selector(startWeibo) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [imageView addSubview:shareButton];
            // 设置中心的前,一定要先设置size,否则没有size,就设置会以中心的作为起点
            shareButton.width = 150;
            shareButton.height = 25;
            shareButton.centerX = SCREEN_WIDTH * 0.5;
            shareButton.centerY = SCREEN_HEIGHT * 0.7;

            [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            [shareButton setTitle:@"分享给好友" forState:UIControlStateNormal];
            [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//            shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -150);
            shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * NUMBEROFSCROLLPAGES, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)addPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    self.view.backgroundColor = [UIColor redColor];
//    pageControl.x = (SCREEN_WIDTH - 100) * 0.5;
//    pageControl.y = SCREEN_HEIGHT - 20;
//    pageControl.width = 100;
//    pageControl.height = 20;
    pageControl.centerX = SCREEN_WIDTH * 0.5;
    pageControl.centerY = SCREEN_HEIGHT * (1 - 0.03);
    
    pageControl.numberOfPages = NUMBEROFSCROLLPAGES;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
}

- (void)startWeibo
{
//    NSLog(@"startWeibo---");
    // 显示主控制器
    GPRootTabController *tabBarViewController = [[GPRootTabController alloc] init];
    // 切换控制器 
    // push [self.navigationController pushViewController:tabBarViewController animated:NO];
    // modal [self presentViewController:tabBarViewController animated:NO completion:nil];
    
    // self.window.rootViewController 该方式最后,节省内存
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabBarViewController;
}

- (void)shareClick:(UIButton*)shareButton
{
    shareButton.selected = !shareButton.isSelected;
    
//    self.flag = !self.flag;
//    if(self.flag)
//    {
//        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int count = (scrollView.contentOffset.x + SCREEN_WIDTH * 0.5) / SCREEN_WIDTH;
    self.pageControl.currentPage = count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    GPLog(@"dealloc");
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
