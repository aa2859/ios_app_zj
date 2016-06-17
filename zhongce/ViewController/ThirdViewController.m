//
//  ThirdViewController.m
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "ThirdViewController.h"

#import "ThirdTableViewCell.h"
#import "tiaozhuanViewController.h"

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;

}

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSMutableArray *listArray;

@end

@implementation ThirdViewController

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10, 75, kScreenWidth - 20, kScreenHeight - 64 - 49)];
        _tableView.allowsSelection=YES;
        _tableView.delegate = self;
        _tableView.dataSource=self;
        _tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
        
        //常规下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self pullDownToRefreshData];
        }];
        
        //下拉刷新动画
//         MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//             [self pullDownToRefreshData];
//         }];
//         UIImage *image1 = [UIImage imageNamed:@"first"];
//         UIImage *image2 = [UIImage imageNamed:@"second"];
//
//
//         NSArray *idleImages = @[image1];
//         NSArray *pullingImages = @[image1];
//         NSArray *refreshImages = @[image1, image2];
//       
//         [header setImages:idleImages forState:MJRefreshStateIdle];
//         [header setImages:pullingImages forState:MJRefreshStatePulling];
//         [header setImages:refreshImages forState:MJRefreshStateRefreshing];
         //_tableView.mj_header = header;

        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self dragUp_loadData];
        }];
    }
    return _tableView;
}

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    _page = 1;
    [self loadDataWithPage:_page];
}

- (void) pullDownToRefreshData{
    [self.listArray removeAllObjects];
    _page = 1;
    [self loadDataWithPage:_page];
}

-(void)dragUp_loadData
{
    _page++;//请求页面＋1
    [self loadDataWithPage:_page];
}

//#pragma tableview delegate && datasource
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 45;
//}
//#warning  可以自定义headerview
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 45)];
//    headerView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.350];
//    UILabel *titleLabel = [WenTool labelWith:headerView.bounds font:nil text:@"查看：全部/*自动化任务/*众测任务" textColor:[UIColor blueColor]];
//    [titleLabel setFrame:CGRectMake(-15, 0, CGRectGetWidth(self.tableView.frame), 45)];
//    titleLabel.textAlignment = NSTextAlignmentRight;
//    [headerView addSubview:titleLabel];
//    return headerView;
//}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThirdTableViewCell";
    //处理内存问题,对nib的加载
    [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
    }
    if ([self.listArray count]) {
        NSDictionary *dataDict = self.listArray[indexPath.row];
        [cell refreshViewWithData:dataDict];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMLog(@"row = %ld", indexPath.row);
//    tiaozhuanViewController *detailView = [[tiaozhuanViewController alloc]init];
//    [self.navigationController pushViewController:detailView animated:NO];
    //self.tableView.delegate=detailView;
    
}


- (void)loadDataWithPage:(NSInteger)page{
    [WenTool hudShow];
    NSString *urlString = [NSString stringWithFormat:@"%@?page=%ld", FirstURL, (long)page];
    NSURL *URL=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];

    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response,NSData* data,NSError *geterror)
     {
         NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         if ([dataArray count]) {
             [self.listArray addObjectsFromArray:dataArray];
             [self.tableView.mj_footer endRefreshing];
         }else{
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
         }
         [self.tableView.mj_header endRefreshing];
         [self.tableView reloadData];
         [WenTool hudSuccessHidden];
         
         
   
     }];
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
