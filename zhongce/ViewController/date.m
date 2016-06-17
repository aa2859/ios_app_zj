//
//  date.m
//  zhongce
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "date.h"

@implementation date

+(date *)headimage:(NSURL *)headimage title:(NSString *)title content:(NSString *)content
{
    date * Date =[[date alloc]init];
   
//    m_userImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 50, 50)];
//    
//    m_titleText=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 170, 20)];
//    [m_titleText setTextColor:[UIColor blueColor]];
//    [m_titleText setFont:[UIFont systemFontOfSize:15]];
//    
//    m_typeText =[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 80, 10)];
//    [m_typeText setTextColor:[UIColor blackColor]];
//    [m_typeText setFont:[UIFont systemFontOfSize:13]];
//    
//    m_userName=[[UILabel alloc]initWithFrame:CGRectMake(140, 35, 170, 10)];
//    [m_userName setTextColor:[UIColor blueColor]];
//    [m_userName setFont:[UIFont systemFontOfSize:13]];

    
    
    Date.title = title;
    
    Date.headimage = headimage;
    Date.content = content;
    
    return Date;

}
  
@end
