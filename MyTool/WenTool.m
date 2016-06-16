//
//  WenTool.m
//  zhongce
//
//  Created by fuwenwen on 16/6/13.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "WenTool.h"


@implementation WenTool : NSObject 


#pragma mark - 基础属性设置
+ (BOOL) isIPhone4s{
    if (kScreenWidth == 320 && kScreenHeight == 480) {
        return YES;
    }
    return NO;
}

+ (BOOL) isIPhone5s{
    if (kScreenWidth == 320 && kScreenHeight == 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone6
{
    if (kScreenWidth == 375) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isIPhone6Plus
{
    if (kScreenWidth == 414) {
        return YES;
    }
    
    return NO;
}

// 字体
+ (UIFont *)expenseFontWith:(CGFloat)size
{
    return [UIFont systemFontOfSize:[WenTool resetSize:size]];
}

+ (UIFont *)defaultFont
{
    return [UIFont systemFontOfSize:15.0];
}


+ (CGFloat)resetSize:(CGFloat)size
{
    if ([WenTool isIPhone6]) {
        size += 2;
    } else if ([WenTool isIPhone6Plus]) {
        size += 4;
    }
    return size;
}



#pragma mark - 转动
+ (void) hudShow
{
    [ProgressHUD show:@"正在加载..."];
}

+ (void) hudShow : (NSString*) msg
{
    [ProgressHUD show:msg];
}

+ (void) hudSuccessHidden
{
    [ProgressHUD dismiss];
}

+ (void) hudSuccessHidden : (NSString*) msg
{
    [ProgressHUD dismiss];
}

+ (void) hudFailHidden
{
    [ProgressHUD showError:nil];
}

+ (void) hudFailHidden : (NSString*) msg
{
    [ProgressHUD showError:msg];
}

+ (UIActivityIndicatorView *)showActivityIndicatorViewInView:(UIView *)view
{
    UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setFrame:[UIScreen mainScreen].bounds];
    activityIndicatorView.center = view.center;
    [view addSubview:activityIndicatorView];
    return activityIndicatorView;
}
/*
 *brief :UIAlertController (ios8.0之后才出现的新控件)
 **/
+ (void)showAlertControllerWithMessage:(NSString *)message onViewController:(UIViewController *)viewController
{
    [viewController.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 工具方法
//获取判断之后的字符串
+ (NSString *)getString:(NSString *)aStr
{
    if (!aStr||[aStr isKindOfClass:[NSNull class]]||[aStr isEqual:@"(null)"]){
        
        aStr = @"0";
        
    }
    
    return aStr;
    
}


// JSON转换数据
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

#pragma mark - 提示视图
+(void)showMessage:(NSString *)content {
    if ([NSString isNil:content]) {
        return;
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[self getString:content] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)alertWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
                  tag:(NSInteger)tag
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:[self getString:message] delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    alert.tag = tag;
    [alert show];
}

+(void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    actionSheet.tag = tag;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:view];
    
}

#pragma mark  - 创建控件
// 创建 label
+ (UILabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
                  text:(NSString *)text
             textColor:(UIColor *)textColor
{
    if (font == nil) {
        font  = [UIFont systemFontOfSize:15.0];
    }
    
    if (textColor == nil) {
        textColor = RGB(100, 100, 100);
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    return label;
}

// 创建button
+ (UIButton *)buttonWith:(CGRect)frame
                    text:(NSString *)text
               backColor:(UIColor *)backColor
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag
{
    if (textColor == nil) {
        textColor = [UIColor whiteColor];
    }
    if (backColor == nil) {
        backColor = [UIColor whiteColor];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.tag = tag;
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame BackGroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)textColor IsBound:(BOOL)isBound CornerRadius:(CGFloat)cornerRadius Text:(NSString *)text ButtonTag:(NSInteger)buttonTag
{
    UIButton *button=  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=frame;
    [button.layer setMasksToBounds:isBound];
    [button.layer setCornerRadius:cornerRadius];//设置矩形四个圆角半径
    [button setTitle:text forState:UIControlStateNormal];
    button. titleLabel.textAlignment=NSTextAlignmentCenter;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor=backgroundColor;
    button.tag=buttonTag;
    return button;
}



// 创建分割线
+ (UIView *)lineViewWith:(CGRect)frame
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor colorWithWhite:0.899 alpha:1.000];
    return lineView;
}

// 画虚线
+ (void)dashedLineWith:(CGRect)frame point:(CGPoint)point CGColor:(CGColorRef)CGColor dashedWidth:(CGFloat)width dashedY:(CGFloat)Y addView:(UIView *)view
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:frame];
    [shapeLayer setPosition:point];
    [shapeLayer setFillColor:CGColor];
    // 设置虚线颜色
    [shapeLayer setStrokeColor:[RGB(100, 100, 100) CGColor]];
    // 设置虚线宽度
    [shapeLayer setLineWidth:0.5f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3是线的宽度  1是线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:1], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, Y);
    CGPathAddLineToPoint(path, NULL, width - 15, Y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[view layer] addSublayer:shapeLayer];
}

// 日期转换成字符串
+ (NSString *)dateTransformToStringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


// 获取当前日期
+ (NSString *)currentDateWithFormatter:(NSString *)formatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter];
    NSString *locationString = [dateformatter stringFromDate:date];
    return locationString;
}

+ (UIColor *)defaultBackColor
{
    UIColor *color = RGB(237, 237, 237);
    return color;
}

+ (UIColor *)defaultBlueColor{
    return RGB(65, 155, 253);
}

+ (UIColor *)themeColor{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaults objectForKey:@"Theme"];
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",theme]];
    NSBundle *themeBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *plistPath = [themeBundle pathForResource:@"Theme" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    UIColor *themeColor = RGB(230, 82, 82);
    
    if (plistPath) {
        NSString *redStr = [plistDict objectForKey:@"red"];
        NSString *greenStr = [plistDict objectForKey:@"green"];
        NSString *blueStr = [plistDict objectForKey:@"blue"];
        themeColor = [UIColor colorWithRed:[redStr floatValue] green:[greenStr floatValue] blue:[blueStr floatValue] alpha:1.0];
    }
    
    return themeColor;
}



+ (CGFloat)createAttrNameLabel:(CGRect)frame Text:(NSString *)text  SuperView:(id)view{
    UILabel *attrNameLabel = [self labelWith:frame font:[UIFont systemFontOfSize:9] text:text textColor:RGB(0, 141, 223)];
    [attrNameLabel.layer setMasksToBounds:YES];
    [attrNameLabel.layer setCornerRadius:2.0];
    [attrNameLabel.layer setBorderWidth:1.0];
    [attrNameLabel.layer setBorderColor:RGB(0, 141, 223).CGColor];
    attrNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:attrNameLabel];
    attrNameLabel.numberOfLines=1;
    attrNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize citySize = [attrNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, attrNameLabel.frame.size.height)];
    attrNameLabel.frame =CGRectMake(frame.origin.x, frame.origin.y, citySize.width+5, frame.size.height);
    return frame.origin.x+citySize.width+5+3;
}


// 提示框
+ (void)addSuccessAnimatingWithTest:(NSString*)text onView:(UIView *)view isSucess:(BOOL)isSucess
{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 100)];
    [backView.layer setMasksToBounds:YES];
    [backView.layer setCornerRadius:4.0];//设置矩形四个圆角半径
    backView.backgroundColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    [view addSubview:backView];
    CGPoint centerPoint={view.center.x,view.center.y-64};
    backView.center=centerPoint;
    UIImageView *addSuccessImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4-20, 10, 40, 40)];
    [backView addSubview:addSuccessImageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0 ,60, kScreenWidth/2, 20)];
    //[label setText: @"成功加入采购清单"];
    label.text=text;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    [backView addSubview: label];
    
    if(!isSucess)
    {
        addSuccessImageView.image=[UIImage imageNamed:@"orderList_null"];
    }
    else
    {
        addSuccessImageView.image=[UIImage imageNamed:@"alert_success"];
    }
    
    [UIView animateWithDuration:2 animations:^{
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
    }];
    
}


+ (void)startAbnormalNetworkAnimatingOnView:(UIView *)view
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 200, 30)];
    label.center=view.center;
    [label setText: @"网络异常，请重新加载"];
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:4.0];//设置矩形四个圆角半径
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    [view addSubview: label];
    [UIView animateWithDuration:2 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

//数字逗号分隔
+ (NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}



+ (CGFloat)heightForLabel:(UILabel *)label{
    label.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString ridObject:label.text]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //注意，每一行的行间距分两部分，topSpacing和bottomSpacing。
    paragraphStyle.lineSpacing=5.0;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    CGSize size = [label sizeThatFits:CGSizeMake(CGRectGetWidth(label.frame), MAXFLOAT)];
    label.frame =CGRectMake(CGRectGetMinX(label.frame), CGRectGetMinY(label.frame), CGRectGetWidth(label.frame), size.height);
    return size.height;
}

+ (CGFloat)widthForLabel:(UILabel *)label{
    label.numberOfLines=0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, label.frame.size.height)];
    label.frame =CGRectMake(CGRectGetMinX(label.frame),  CGRectGetMinY(label.frame), size.width, CGRectGetHeight(label.frame));
    return size.width;
}

+ (void)labelWith:(UILabel *)label RangeOfNote:(NSRange)range NoteColor:(UIColor *)noteColor        NoteFont:(UIFont *)noteFont
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [noteStr addAttributes:@{NSForegroundColorAttributeName:noteColor,NSFontAttributeName:noteFont} range:range];
    [label setAttributedText:noteStr] ;
}


+ (BOOL)checkTel:(NSString *)phone
{
    if ([phone length] == 0) {
        [self showMessage:@"手机号为空"];
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString * regex = @"^1[34578]\\d{9}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phone];
    if (!isMatch) {
        [self showMessage:@"请输入正确的手机号码"];
        return NO;
    }
    return YES;
}


+ (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaults objectForKey:@"Theme"];
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",theme]];
    NSBundle *themeBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [themeBundle pathForResource:imageName ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}




+ (BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB
{
    NSArray *arrayNow = [versionB componentsSeparatedByString:@"."];
    NSArray *arrayNew = [versionA componentsSeparatedByString:@"."];
    BOOL isBigger = NO;
    NSInteger i = arrayNew.count > arrayNow.count? arrayNow.count : arrayNew.count;
    NSInteger j = 0;
    BOOL hasResult = NO;
    for (j = 0; j < i; j ++) {
        NSString* strNew = [arrayNew objectAtIndex:j];
        NSString* strNow = [arrayNow objectAtIndex:j];
        if ([strNew integerValue] > [strNow integerValue]) {
            hasResult = YES;
            isBigger = YES;
            break;
        }
        if ([strNew integerValue] < [strNow integerValue]) {
            hasResult = YES;
            isBigger = NO;
            break;
        }
    }
    if (!hasResult) {
        if (arrayNew.count > arrayNow.count) {
            NSInteger nTmp = 0;
            NSInteger k = 0;
            for (k = arrayNow.count; k < arrayNew.count; k++) {
                nTmp += [[arrayNew objectAtIndex:k]integerValue];
            }
            if (nTmp > 0) {
                isBigger = YES;
            }
        }
    }
    return isBigger;
}


+ (void)drawWithView:(UIView *)view centerPoint:(CGPoint)centerPoint radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle backgroundColor:(UIColor *)backgroundColor{
    UIBezierPath *_bezierpath=[UIBezierPath   bezierPathWithArcCenter:centerPoint
                                                               radius:radius
                                                           startAngle:startAngle-M_PI_2
                                                             endAngle:endAngle -M_PI_2
                                                            clockwise:YES];
    [_bezierpath addLineToPoint:centerPoint];
    [_bezierpath closePath];
    
    CAShapeLayer *_shapeLayer=[CAShapeLayer layer];
    _shapeLayer.fillColor=backgroundColor.CGColor;
    _shapeLayer.path = _bezierpath.CGPath;
    _shapeLayer.position = CGPointMake(-centerPoint.x+view.frame.size.width/2,-centerPoint.y+view.frame.size.height/2);
    [view.layer addSublayer:_shapeLayer];
}

+ (BOOL)checkIdentityCardNo:(NSString *)cardNo
{
    if (cardNo.length < 15 || cardNo.length == 16 || cardNo.length==17) {
        return  NO;
    }
    if (cardNo.length == 15) {
        return YES;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

+ (void) shakeToShowAt:(UIView *)view{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}


@end
