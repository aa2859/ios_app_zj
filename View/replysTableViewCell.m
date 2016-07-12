//
//  replysTableViewCell.m
//  zhongce
//
//  Created by Apple on 16/7/11.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "replysTableViewCell.h"

@interface replysTableViewCell()
{

}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *replynumber;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *replycontent;

@end

@implementation replysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void) refreshViewWithData:(NSDictionary *)dataDict
{
    NSString *imageStr = dataDict[@"User"][@"Avatar"];
    NSString*userName = dataDict[@"User"][@"userName"];
    NSString * Time = dataDict[@"creatDate"];
    NSLog(@"%@",imageStr);
    NSLog(@"%@",userName);
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", SecondURL,imageStr];
    NSLog(@"%@",urlString);
    NSURL *URL = [NSURL URLWithString:urlString];
    [self.image sd_setImageWithURL:URL placeholderImage:nil options:SDWebImageRetryFailed];
    self.username.text = userName;
    NSString *timeStr = [self compareCurrentTime:Time];
    self.time.text = timeStr;
//    NSString*replysNumeber = dataDict[@"floor"];
//    self.replynumber.text = replysNumeber;
    NSString * replysNumeber = [NSString stringWithFormat:@"#%@",dataDict[@"floor"]];
    self.replynumber.text = replysNumeber;
    NSString* replyContent = dataDict[@"body"];
    self.replycontent.text = replyContent;




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
