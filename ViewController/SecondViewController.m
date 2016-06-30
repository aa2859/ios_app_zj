//
//  SecondViewController.m
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ThirdViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"



@interface SecondViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;

}
@property (copy, nonatomic) NSMutableArray *ListArray;
@property(weak,nonatomic)NSString* boDy;

@end

@implementation SecondViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSLog(@"%@",_ListArray);
    

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
    NSURL *URL = [NSURL URLWithString:@"http://139.196.177.74/app/Topic/2"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSError *err;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&err];
        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);

       
       
        
        NSLog(@"JSON: %@", responseObject);
        
    
        NSString *aa = responseObject[@"Body"];
      NSString*  string=[aa stringByReplacingOccurrencesOfString:@"\r\n"withString:@"\\r\\n"];
        NSLog(@"%@",aa);
         [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@');",string]];
 
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
//    //AFHTTPSessionManager  *_sessionManager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    
//    manager.requestSerializer.timeoutInterval = 10;
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
   // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    
   // [_sessionManager.requestSerializer setValue:[self getHelpToken] forHTTPHeaderField:@"Authorization"];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain",@"application/xhtml+xml",@"application/xml",@"q=0.9",nil];
   
    
    
 //[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@');",_boDy]];
    
    
    
    
    


    


    //第一步，创建URL
    //
//        NSURL *url = [NSURL URLWithString:@"http://139.196.177.74/app/Topic/2"];
//   
//       NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//   
//        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//     NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    
    
//        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
//    
//        NSError *err;
//    
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//        _boDy = dic[@"Body"];
//   
//    
//    NSLog(@"%@",_boDy);
    
    
//    NSString *str=[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
//    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //    从URL获取json数据
//    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
//        NSLog(@"获取到的数据为：%@",JSON);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
//        NSLog(@"发生错误！%@",error);
//    }];
//    [operation1 start];
    
    
    

    
    
    
    
    
    
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
