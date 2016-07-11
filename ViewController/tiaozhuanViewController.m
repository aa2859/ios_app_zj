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

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface tiaozhuanViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic)NSString*urlstring;
@property (strong, nonatomic) UIWebView *webView;
@property(strong,nonatomic) UIView*cusheadView;



@end

@implementation tiaozhuanViewController
NSURLRequest *UrlRequest;

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 450)];
        _webView.delegate = self;
    }
    return _webView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0, kScreenWidth,kScreenHeight )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
   
    //[self.view addSubview:UiWebView];
    
    _cusheadView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 480)];
    _cusheadView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 280, 10)];
    title.text =@"测试任务123";
    title.font= [UIFont boldSystemFontOfSize:25.0f];
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 70, 10)];
    type.text  = @"自动化任务";
    type.font= [UIFont fontWithName:@"Arial" size:13.0f];
    [type setTextColor:[UIColor colorWithWhite:0.4 alpha:0.9]];
    UILabel * username = [[UILabel alloc]initWithFrame:CGRectMake(85, 45, 75, 10)];
    username.text = @"c_zhubo";
    username.font =[UIFont systemFontOfSize: 13];
    UILabel * time = [[UILabel alloc]initWithFrame:CGRectMake(175, 45, 90, 10)];
    time.text= @"于4天前发布";
    [time setTextColor:[UIColor colorWithWhite:0.4 alpha:0.9]];
    time.font =[UIFont fontWithName:@"Arial" size:13.0f];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(280, 7, 35, 35)];
    UIImage*imagename= [UIImage imageNamed:@"Icon-Small"];
    image.image = imagename;
    [_cusheadView addSubview:title];
    [_cusheadView addSubview:type];
    [_cusheadView addSubview:username];
    [_cusheadView addSubview:time];
    [_cusheadView addSubview:image];
    [self request];
     self.tableView.tableHeaderView =_cusheadView;
    
    
    
}

- (void)request{
   
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [self.webView loadRequest:request];
   
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
//    self.tableView.tableHeaderView = self.webView;
    [_cusheadView addSubview:self.webView];

    
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
        NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
        int height = [height_str intValue];
        webView.frame = CGRectMake(0,60,320,height);
//        CGFloat dwidth =[[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@').offsetWith;",string]]floatValue];
//        CGFloat dheight =[[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@').offsetHeight;",string]]floatValue];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    

    
//    UIScrollView *webViewScroll = webView.subviews[0];//取到webView的Scrollview
//    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webViewScroll.contentSize.width, webViewScroll.contentSize.height);
//    self.webView.frame = webView.frame;
   // self.tableView.tableHeaderView = self.webView;
    [_cusheadView addSubview: self.webView];
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条", indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 28;
//}



//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 30)];
//    titleLabel.text = @"回复数";
//    titleLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
//    
//    return titleLabel;
//}










@end
