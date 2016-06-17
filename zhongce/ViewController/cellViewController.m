//
//  cellViewController.m
//  zhongce
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "cellViewController.h"

@interface cellViewController ()

@end

@implementation cellViewController

@synthesize m_timeText,m_titleText,m_typeText,m_userImage,m_userName;


//自定义cell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self create_view];
    }
    return  self;


}
-(void)create_view
{
    m_userImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 50, 50)];
    
    m_titleText=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 170, 20)];
    [m_titleText setTextColor:[UIColor blueColor]];
    [m_titleText setFont:[UIFont systemFontOfSize:15]];
    
    m_typeText =[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 80, 10)];
    [m_typeText setTextColor:[UIColor blackColor]];
    [m_typeText setFont:[UIFont systemFontOfSize:13]];
    
    m_userName=[[UILabel alloc]initWithFrame:CGRectMake(140, 35, 170, 10)];
    [m_userName setTextColor:[UIColor blueColor]];
    [m_userName setFont:[UIFont systemFontOfSize:13]];
    
    [self.contentView addSubview:m_userImage];
    [self.contentView addSubview:m_userName];
    [self.contentView addSubview:m_titleText];
    [self.contentView addSubview:m_typeText];



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
