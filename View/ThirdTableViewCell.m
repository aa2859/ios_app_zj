//
//  ThirdTableViewCell.m
//  zhongce
//
//  Created by fuwenwen on 16/6/13.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "ThirdTableViewCell.h"
//#import "UIImageView+WebCache.h"

//#define SecondURL @"http://139.196.177.74/Content/userAvatar/"
#import "ThirdViewController.h"

@interface ThirdTableViewCell()
{

}

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *answer;


@end

@implementation ThirdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) refreshViewWithData:(NSDictionary *)dataDict{
    
    NSString *imageStr = dataDict[@"User"][@"Avatar"];
    NSString *title = dataDict[@"title"];
    NSString *userName = dataDict[@"User"][@"userName"];
    NSString *creatime = dataDict[@"creatDate"];
    NSString * replyCnt = dataDict[@"replyCnt"];
    NSLog(@"%@",replyCnt);
    
    NSLog(@"%@",dataDict[@"replyCnt"]);
 
 
    NSString *timeStr = [self compareCurrentTime:creatime];
    RMLog(@"timeSTR = %@",timeStr);

    NSString *urlString = [NSString stringWithFormat:@"%@%@", SecondURL,imageStr];
    NSLog(@"%@",urlString);
    NSURL *URL = [NSURL URLWithString:urlString];
   
    self.timeLabel.text = timeStr;
    self.titleLabel.text = title;
    self.detailLabel.text = userName;
        
    self.answer.layer.cornerRadius = _answer.frame.size.height / 2 ;
    //_answer.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.f];
 
    NSString* s = [NSString stringWithFormat:@"%@", replyCnt];
   self.answer.clipsToBounds = YES;
    //self.answer.text =s;
    NSString *firstStr = [s substringToIndex:1];
    NSString*aa = @"0";
    NSLog(@"%@",aa);
    NSLog(@"%@",firstStr);
    _answer.text =s;
//    if([s  isEqualToString:aa]==1)
//    {
//        
//        _answer.hidden = YES;
//        
//    }
//    else
//    {
//       // _answer.hidden = YES;
//        _answer.text =s;
//        NSLog(@"%@",_answer.text);
//    
//    }
    
    
    [self.ImageView sd_setImageWithURL:URL placeholderImage:nil options:SDWebImageRetryFailed];
    //[self setAtrributeLabelWithText:@"经验心得 c_zhubo 于2天前"];
}

- (void) setAtrributeLabelWithText:(NSString *)text{
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text];
    // 修改富文本中的不同文字的样式
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 4)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 20)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, 20)];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"first"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 15, 15);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    
    // 用label的attributedText属性来使用富文本
    self.detailLabel.attributedText = attri;
}


- (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    
    NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSLog(@"%@",strUrl);
    NSString *strUrl2 = [strUrl substringWithRange:NSMakeRange(0, 19)];
    NSLog(@"%@",strUrl2);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   // [dateFormatter setDateFormat:@"2014-01-20 14:36:07"] ;
    NSDate *timeDate = [dateFormatter dateFromString:strUrl2];
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




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
