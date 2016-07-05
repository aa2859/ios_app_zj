//
//  tiaozhuanViewController.m
//  zhongce
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "tiaozhuanViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"

@interface tiaozhuanViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic)NSString*urlstring;

@end

@implementation tiaozhuanViewController
NSURLRequest *UrlRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    
        CGRect cgrect =[UIScreen mainScreen].applicationFrame;
    UiWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, cgrect.size.width, cgrect.size.height+40)];
   // NSString *urlstring=[NSString stringWithFormat:@"%@%@",FirstURL,self.requestID];
    
  //  UrlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    [self.view addSubview:UiWebView];
    UiWebView.delegate = self;
   // [UiWebView loadRequest:UrlRequest];
    self.tableView.delegate=self;
    // Do any additional setup after loading the view.

    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [UiWebView loadHTMLString:htmlString baseURL:baseURL];
    UiWebView.scalesPageToFit = YES;
    
    
}



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
    _urlstring=[NSString stringWithFormat:@"%@%@",FirstURL,self.requestID];
    NSURL *URL = [NSURL URLWithString:_urlstring];
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
        NSString*title = responseObject[@"title"];
        
        self.title = title;
        NSString*  string=[aa stringByReplacingOccurrencesOfString:@"\r\n"withString:@"\\r\\n"];
        NSLog(@"%@",aa);
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@');",string]];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1){
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:UiWebView];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"index====%ld",(long)indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == 1){
        /* 通过webview代理获取到内容高度后,将内容高度设置为cell的高 */
        return UiWebView.frame.size.height;
    }else{
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}









@end
