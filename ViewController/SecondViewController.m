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


@interface SecondViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;

}
@property (copy, nonatomic) NSMutableArray *ListArray;
@end

@implementation SecondViewController

- (NSMutableArray *)ListArray{
    if (!_ListArray) {
        _ListArray = [NSMutableArray array];
    }
    return _ListArray;
}

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
    NSString * aa = [[NSString alloc]init];
    aa=@"jhahahah";
//    [htmlFile stringByEvaluatingJavaScriptFromString:editormd.markdownToHTML($("script")];
    [webview stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"anzeige\").innerHTML=\"Hello World\";"];
                                                                             
    
     
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
    NSString *urlString = [NSString stringWithFormat:@"http://139.196.177.74/app/Topic/3"];
    //这里传进参数，然后ip+page
    NSLog(@"%@",urlString);
    NSURL *URL=[NSURL URLWithString:urlString];
    NSMutableURLRequest *rst=[[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [rst setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response,NSData* data,NSError *geterror)
     {
         NSArray *DataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"%@",DataArray);
       
         [self.ListArray addObjectsFromArray:DataArray];
         
         
     }];

NSLog(@"正在加载...");
    
    
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载网页成功时的代理方法!
    NSLog(@"加载成功　");
    
  
        //1.OC中调用JS的文档对象. (先拼出文档对象的属性) 可以在浏览器控制台输入来进行测试
//        NSLog(@"%@", [webview stringByEvaluatingJavaScriptFromString:@"document.title"]);
    
        //2.OC中调用JS的方法
//        [webview stringByEvaluatingJavaScriptFromString:@"markdownView(http://139.196.177.74/app/Topic/1)"];
    NSString *str1 = @"小菜的性能日记 3 (性能测试范围与用户行为模型)- [小菜的性能日记 1](https://testerhome.com/topics/3795) - [小菜的性能日记 2](https://testerhome.com/topics/3799) - [小菜的性能日记 3](https://testerhome.com/topics/3828) - [小菜的性能日记 4](https://testerhome.com/topics/3930) # 性能测试范围与用户行为模型 &emsp;&emsp;小菜最近又接到一个测试任务，这次的项目时一个旧系统升级改造项目。小菜接到任务后第一时间找到项目经理讨论性能测试范围，可项目经理扔给小菜一个100多测试点的文档就走了，这可让小菜头痛不已。小菜去找大鸟大吐苦水。 小菜：“大鸟，这次的项目好复杂啊，100多个功能点，光准备测试脚本都要好几个星期呢，而且因为没有监控模块项目经理对处理能力（TPS）的要求也说不出个所以然来，这要做好我估计怎么着也得半年吧” 大鸟 :cold_sweat:：“呵呵。。你__一个性能测试做个半年，你那项目还要不要上线了__。” 小菜 :triumph:：“大鸟你倒是说的轻松，这100多个功能点，难道给你做就能半个月就能测的好吗？” 大鸟：”你要把全部功能点都测到 当然要很久。不过性能测试可做不到像做功能那样全覆盖，你可以挑选一些重要功能点纳入你的测试范围“ 选择__性能测试范围__都会遵守下面三点： __1. 用户使用最频繁的功能 2. 开发人员认为可能存在风险的功能（毕竟亲生的） 3. 重要的功能（比如支付等与钱相关的功能）__ 小菜扣了扣鼻子:weary:：“哎˜˜这道理你都和我说过好几遍啦，可这__系统什么监控模块都没有怎么分析用户使用行为__啊。” 大鸟:anger::“谁和你说没有的？中间件的access_log就是很好的监控模块。我早就帮你统计好啦，看吧” ![](https://testerhome.com/photo/2015/cc6ba9951391d738e26a3f99fcaffc8f.png) “这个系统是用mvc struts编写的，每一个用户提交事件都会对应到一个.action方法，你只要统计每天每个方法的调用次数，就能大致的分析出用户的使用行为了“ “哦˜˜˜access_log 还能这样用啊，我一直以为它只是用来排查错误的呢:sweat_smile: ” “这样一来测试范围也差不多可以确定下来了，分析出来的调用数量也正好可以作为这次性能测试的指标（TPS）” “哎呀，大鸟啊 经你这么一整这个项目看来还是蛮简单的嘛:smile:” “小菜啊 ， __性能测试的重点永远在于分析与挖掘，每一份你能获得的数据都是宝贵的，你要懂得如何去分析使用这些数据。__” “大鸟 还是那么文邹邹的，我这道行当然不能和大鸟比啦 :pray:”";
       [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@');",str1]];
    
    
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
