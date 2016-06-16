//
//  FirstViewController.m
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "FirstViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
NSURLRequest *urlRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //获取屏幕大小
    CGRect cgrect =[UIScreen mainScreen].applicationFrame;
    uiWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, cgrect.size.width, cgrect.size.height+40)];
    urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.196.177.74/"]];
    [self.view addSubview:uiWebView];
    uiWebView.delegate = self;
    [uiWebView loadRequest:urlRequest];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
