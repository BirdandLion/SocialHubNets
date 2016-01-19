//
//  GPOAuthViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/10.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPOAuthViewController.h"
#import "GPRootTabController.h"
#import "GPNewFeatureController.h"
#import "MBProgressHUD+MJ.h"
#import "GPControllerTool.h"
#import "GPAccountModel.h"
#import "GPAccountTool.h"

@interface GPOAuthViewController ()<UIWebViewDelegate>

@end

@implementation GPOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    // 2. 加载登陆界面
    NSString *urtString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",  GPAppKey, GPRedirectURL];
    NSURL *url = [NSURL URLWithString:urtString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

// UIWebView 每次发送一个请求之前,都会先调用这个代理方法,询问代理是否允许该请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    GPLog(@"%@", request.URL.absoluteString);
    NSString *urlString = request.URL.absoluteString;
    // 2. 判断url是否的回调地址
    NSString *str = [NSString stringWithFormat:@"%@/?code=", GPRedirectURL];
    NSRange range = [urlString rangeOfString:str];
    if(range.location != NSNotFound)
    {
        // 截取request token
        NSUInteger from = range.location + range.length;
        NSString *code = [urlString substringFromIndex:from];
        // 获取access token
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

// 根据授权的request token获取access token
// 发送一个post请求
- (void)accessTokenWithCode:(NSString*)code
{
    // 1. 封装请求参数    
    GPAccessTokenParam *param = [[GPAccessTokenParam alloc] init];
    param.client_id = GPAppKey;
    param.client_secret = GPAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = GPRedirectURL;
    
    // 2. 获取access_token
    [GPAccountTool getAccessTokenWithParam:param success:^(GPAccountModel *account) {        
        // 存储授权成功的账号信息
        [GPAccountTool saveWithAccount:account];
        // 选择控制器
        [GPControllerTool chooseRootController];
        // 隐藏HUD
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        GPLog(@"error: %@", error);
        // 隐藏HUD
        [MBProgressHUD hideHUD];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
