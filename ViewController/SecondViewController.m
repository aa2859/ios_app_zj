//
//  SecondViewController.m
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;

}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    webview = [[UIWebView alloc]init];
    webview.frame = self.view.bounds;
    webview.delegate = self;
    [self.view addSubview:webview];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [webview loadHTMLString:htmlString baseURL:baseURL];

    webview.scalesPageToFit = YES;

   
}

#pragma mark - webView的代理方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载网页失败时的代理方法
    NSLog(@"失败");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //加载之前会调用这个方法
    //是否应该 开始请求网页,根据相关的条件你可以 return YES或者NO
    NSLog(@"正在加载...");
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载网页成功时的代理方法!
    NSLog(@"加载成功　");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页时的代理方法,大家可以 使用 HUD 来提示一下 用户正在加载
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
