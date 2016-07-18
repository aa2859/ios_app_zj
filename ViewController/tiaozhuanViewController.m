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
#import "replysTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface tiaozhuanViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate>
{


    UILabel*Title;
    UILabel *UserName;
    UILabel*Time;
    UIImageView *imageStr;
}


@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic)NSString*urlstring;
@property (strong, nonatomic) UIWebView *webView;
@property(strong,nonatomic) UIView*cusheadView;
@property(strong ,nonatomic)NSMutableArray * repalys;
@property(strong,nonatomic)NSString*replynumber;
@property(strong,nonatomic) UIView*footcusheadView;


@property(strong,nonatomic)UITextView*footview;





@end

@implementation tiaozhuanViewController
NSURLRequest *UrlRequest;

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 400)];
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
        //内存处理写在tableview初始化里面，只走一次，比放在cell中节约性能
        NSString *cellReuseIdentifier = NSStringFromClass([replysTableViewCell class]);
        [_tableView registerNib:[UINib nibWithNibName:cellReuseIdentifier bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];

    }
    return _tableView;
}
//初始化repalys
- (NSMutableArray *)repalys{
    if (!_repalys) {
        _repalys = [NSMutableArray array];
    }
    return _repalys;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* timeStr = [self compareCurrentTime:Time.text];
    Time.text= timeStr;
    _cusheadView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 480)];
    _cusheadView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    Title = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 280, 10)];
   
    Title.font= [UIFont boldSystemFontOfSize:25.0f];
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 70, 10)];
    type.text  = @"自动化任务";
    type.font= [UIFont fontWithName:@"Arial" size:13.0f];
    [type setTextColor:[UIColor colorWithWhite:0.4 alpha:0.9]];
    UserName = [[UILabel alloc]initWithFrame:CGRectMake(85, 45, 75, 10)];
    
    UserName.font =[UIFont systemFontOfSize: 13];
    Time = [[UILabel alloc]initWithFrame:CGRectMake(175, 45, 90, 10)];
    
    [Time setTextColor:[UIColor colorWithWhite:0.4 alpha:0.9]];
    Time.font =[UIFont fontWithName:@"Arial" size:13.0f];
    imageStr = [[UIImageView alloc]initWithFrame:CGRectMake(280, 7, 35, 35)];

    
  
    [_cusheadView addSubview:Title];
    [_cusheadView addSubview:type];
    [_cusheadView addSubview:UserName];
    [_cusheadView addSubview:Time];
    [_cusheadView addSubview:imageStr];
    
    
    self.tableView.tableHeaderView =_cusheadView;
    
    [self loadDataWithPage:self.requestID];
    //[self.view addSubview:UiWebView];
    [self request];

    
    
    _footcusheadView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 280)];
    _footcusheadView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];

    _footview =[[UITextView alloc]initWithFrame:CGRectMake(5,20, 310, 100)];
    _footview.layer.borderColor = [UIColor grayColor].CGColor;
    _footview.layer.borderWidth =1.0;
    _footview.layer.cornerRadius =5.0;
    UIButton *push = [[UIButton alloc]initWithFrame:CGRectMake(8, 140, 80, 30)];
    push.backgroundColor = [UIColor blueColor];
    [push setTitle: @"提交回复" forState: UIControlStateNormal];
    
    push.layer.borderWidth =1.0;
    push.layer.cornerRadius =5.0;
    [push addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];

    push.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [_footcusheadView addSubview:push];

    [_footcusheadView addSubview:_footview];
    [self textViewDidBeginEditing:_footview ];
    
    
    self.tableView.tableFooterView= _footcusheadView;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

   
    
    [self.view endEditing:YES];
   // [self LoadDataWithPage:self.requestID];
    [self.view addSubview:self.tableView];
   }

-(void)butClick:(UIButton *)sender
{
    // 1.设置请求路径
    NSURL *URL2=[NSURL URLWithString:@"http://139.196.177.74/app/token"];
    //不需要传递参数
    
    //    2.创建请求对象
    NSMutableURLRequest *request2=[NSMutableURLRequest requestWithURL:URL2];//默认为get请求
    request2.timeoutInterval=10.0;//设置请求超时为5秒
    request2.HTTPMethod=@"POST";//设置请求方法
    [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//这个很关键，一定要设置
    [request2 setValue:@"Basic YXBwOnRlc3Q=" forHTTPHeaderField:@"Authorization"];
    
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"grant_type=password&username=c_fuwenwen&password=Cpic1234"];
    //把拼接后的字符串转换为data，设置请求体
    request2.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //    3.发送请求
    NSData *returnData2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    
    
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:returnData2
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSString * token = dic[@"access_token"];
    NSString* token_type=dic[@"token_type"];
    NSLog(@"%@",token);
    NSLog(@"%@",returnData2);
    NSString* aStr;
    aStr = [[NSString alloc] initWithData:returnData2 encoding:NSASCIIStringEncoding];
    NSLog(@"%@",aStr);
    
    NSString * pinjie = [NSString stringWithFormat:@"%@  %@", token_type,token ];
    
    
    NSString*Url = [NSString stringWithFormat:@"http://139.196.177.74/app/api/topic/%@/Reply",self.requestID];
    NSURL * url = [NSURL URLWithString:Url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:pinjie forHTTPHeaderField:@"Authorization"];
    
    
    [manager.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString*text = _footview.text;
    [parameters setObject:text forKey:@"body"];
    
    [manager POST:url.absoluteString
       parameters:parameters
          success:^(NSURLSessionTask *task, id responseObject) {
              NSLog(@"response:%@", responseObject);
          }
     
          failure:^(NSURLSessionTask *task, NSError *error) {
              NSLog(@"error:%@", error);
          }];
    
    
  //[self.tableView reloadData];

    [self loadDataWithPage:self.requestID];
//    NSString*urL=[NSString stringWithFormat:@"%@%@/replys",FirstURL,self.requestID];
//  
//    NSURL *URL = [NSURL URLWithString:urL];
//
//   
//    
//    //第二步，通过URL创建网络请求
//    
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    
//    //第三步，连接服务器
//    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//     NSArray *data2arry = [NSKeyedUnarchiver unarchiveObjectWithData:received];
//    
//    NSArray *list = data2arry;
//   
//    [self.repalys addObjectsFromArray:list];
//    [self.tableView reloadData];
//    NSLog(@"%@",str);     //就这么简单，到这里就完成了，str就是请求得到的结果
//    
//

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"回复成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [myAlertView show];

}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_footview resignFirstResponder];
}


//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [_footview resignFirstResponder];
//}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_footview resignFirstResponder];
}

- (NSString *) compareCurrentTime:(NSString *)str
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // [dateFormatter setDateFormat:@"2014-01-20 14:36:07"] ;
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSLog(@"%@",timeDate);
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    NSLog(@"%f",timeInterval);
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"• 刚刚发布•"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"•于 %ld分钟前发布•",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"•于 %ld小时前发布•",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"•于 %ld天前发布•",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"•于 %ld月前发布•",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"•于 %ld年前发布•",temp];
    }
    
    return  result;
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
        
        
        NSString *aa = responseObject[@"Body"];
        NSString*title = responseObject[@"title"];
        
        //全局接收数据
       Title.text = responseObject[@"title"];
        UserName.text = responseObject[@"User"][@"userName"];
       
        [imageStr sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@", SecondURL,responseObject[@"User"][@"Avatar"]]]placeholderImage:nil options:SDWebImageRetryFailed];
         NSString* timeStr = [self compareCurrentTime: responseObject[@"creatDate"]];
         Time.text  = timeStr;
        
        self.title = title;
        NSString*  string=[aa stringByReplacingOccurrencesOfString:@"\r\n"withString:@"\\r\\n"];
        
        NSLog(@"%@",aa);
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"markdownView('%@');",string]];
       _replynumber = [NSString stringWithFormat:@"%@",responseObject[@"replyCnt"]];
        NSLog(@"%@",_replynumber);
//                [self refreshData:responseObject];
        [self.tableView reloadData];
      

        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    

    
    UIScrollView *webViewScroll = webView.subviews[0];//取到webView的Scrollview
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webViewScroll.contentSize.width, webViewScroll.contentSize.height);
    
    [webViewScroll setContentSize:CGSizeMake(640, 480)];
    
    [webViewScroll setScrollEnabled:YES];
    
    self.webView.frame = webView.frame;
   // self.tableView.tableHeaderView = self.webView;
    [_cusheadView addSubview: self.webView];
    
    


}


-(void)loadDataWithPage:(NSString*)ID
{
    [WenTool hudShow];
    NSString*url=[NSString stringWithFormat:@"%@%@/replys",FirstURL,ID];
    NSURL *URL = [NSURL URLWithString:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *list = responseObject;
        [self.repalys addObjectsFromArray:list];
        [self.tableView reloadData];
//        [_repalys addObjectsFromArray:dataArray];
         [WenTool hudSuccessHidden];

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
    return  [self.repalys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"replysTableViewCell";
    //处理内存问题,对nib的加载
//    [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
//    replysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    replysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (cell == nil) {
//        cell = [[replysTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }
    if ([self.repalys count]) {

        NSDictionary *dataDict = self.repalys[indexPath.row];
        
        [cell refreshViewWithData:dataDict];
   
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}



- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 30)];
    titleLabel.backgroundColor = [UIColor  groupTableViewBackgroundColor];
    if ([_replynumber integerValue]) {
        NSString*titleLabelText = [NSString stringWithFormat:@"共收到%@条回复",_replynumber];
        titleLabel.text = titleLabelText;
    }
    else
    {
        titleLabel.text = @"共收到0条回复";
        
    }
  
  
   
    
    return titleLabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 28;


}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 320, 30)];
    titleLabel.backgroundColor = [UIColor  groupTableViewBackgroundColor];
    titleLabel.text = @"回帖";
    
    
    return titleLabel;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 120 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}










@end
