//
//  tiaozhuanViewController.m
//  zhongce
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "tiaozhuanViewController.h"

@interface tiaozhuanViewController ()
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation tiaozhuanViewController
NSURLRequest *UrlRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect cgrect =[UIScreen mainScreen].applicationFrame;
    UiWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, cgrect.size.width, cgrect.size.height+40)];
    UrlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
    [self.view addSubview:UiWebView];
    UiWebView.delegate = self;
    [UiWebView loadRequest:UrlRequest];
    self.tableView.delegate=self;
    // Do any additional setup after loading the view.
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
