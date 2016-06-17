//
//  cellViewController.h
//  zhongce
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTableViewCellDelegate

@end

@interface cellViewController : UITableViewCell


@property (strong,nonatomic) id<HomeTableViewCellDelegate>delegate;
@property (strong,nonatomic) UIImageView * m_userImage;
@property (strong,nonatomic) UILabel * m_titleText;
@property (strong,nonatomic) UILabel * m_typeText;
@property (strong,nonatomic) UILabel * m_userName;
@property (strong,nonatomic) UILabel * m_timeText;


@end
