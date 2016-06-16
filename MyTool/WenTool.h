//
//  WenTool.h
//  zhongce
//
//  Created by fuwenwen on 16/6/13.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WenTool : NSObject

//基础属性设置
+ (BOOL) isIPhone4s;
+ (BOOL) isIPhone5s;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;

// 字体
+ (UIFont *)expenseFontWith:(CGFloat)size;
+ (UIFont *)defaultFont;

// 加载效果
+ (void) hudShow;
+ (void) hudShow : (NSString*) msg;
+ (void) hudSuccessHidden;
+ (void) hudSuccessHidden : (NSString*) msg;
+ (void) hudFailHidden;
+ (void) hudFailHidden : (NSString*) msg;

// 系统自动网络加载效果
+ (UIActivityIndicatorView *)showActivityIndicatorViewInView:(UIView *)view;

/*
 *brief :添加alertController提示框  (UIAlertController是iOS8.0之后才出现的新控件)
 */
//+ (void)showAlertControllerWithMessage:(NSString *)message onViewController:(UIViewController *)viewController;

// 判断字符串是否为空
+ (NSString *)getString:(NSString *)aStr;

// 提示框alerview,仅显示确定按钮
+(void)showMessage:(NSString *)content;

// 现实提示框alertview
+(void)alertWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
                  tag:(NSInteger)tag
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... ;

// 弹出actionSheet
+(void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles, ... ;

// 创建label
+ (UILabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
                  text:(NSString *)text
             textColor:(UIColor *)textColor;

// 创建button
+ (UIButton *)buttonWith:(CGRect)frame
                    text:(NSString *)text
               backColor:(UIColor *)backColor
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag;

+ (UIButton *)buttonWithFrame:(CGRect)frame
              BackGroundColor:(UIColor *)backgroundColor
                    TextColor:(UIColor *)textColor
                      IsBound:(BOOL)isBound
                 CornerRadius:(CGFloat)cornerRadius
                         Text:(NSString *)text
                    ButtonTag:(NSInteger)buttonTag;

// 创建分割线
+ (UIView *)lineViewWith:(CGRect)frame;

// 添加虚线
+ (void)dashedLineWith:(CGRect)frame point:(CGPoint)point CGColor:(CGColorRef)CGColor dashedWidth:(CGFloat)width dashedY:(CGFloat)Y addView:(UIView *)view;

// 获取验证码
+ (void)sendIndentifierToPhoneWith:(NSString *)phone type:(NSString *)type;

// 验证验证码
+(NSInteger)checkIdentifierWith:(NSString *)string;

// JSON数据转换
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

// date转换成string
+ (NSString *)dateTransformToStringWithDate:(NSDate *)date format:(NSString *)format;

// 请求url
+ (NSString *)requestURL:(NSString *)string;

// uid/sign
+ (NSDictionary *)userBaseMessage;

// 获取当前日期(字符串)
+ (NSString *)currentDateWithFormatter:(NSString *)formatter;

// 默认背景颜色
+ (UIColor *)defaultBackColor;

/**
 *    @brief  默认蓝色
 *
 *    @return 蓝色颜色值
 */
+ (UIColor *)defaultBlueColor;
/**
 *    @brief  主题颜色
 *
 *    @return 主题颜色
 */
+ (UIColor *)themeColor;

/*
 * 添加标签
 */
+ (CGFloat)createAttrNameLabel:(CGRect)frame Text:(NSString *)text  SuperView:(id)view;


// 默认提示框
+ (void)addSuccessAnimatingWithTest:(NSString*)text onView:(UIView *)view isSucess:(BOOL)isSucess;

+ (void)startAbnormalNetworkAnimatingOnView:(UIView *)view;


//数字逗号分隔
+ (NSString *)countNumAndChangeformat:(NSString *)num;

/**
 *    @brief label的多行显示（有行间距）
 *
 *    @param label 需要处理的label
 *
 *    @return label的高度
 */
+ (CGFloat)heightForLabel:(UILabel *)label;

/**
 *    @brief  label宽度自适应
 *
 *    @param label 需要处理的label
 *
 *    @return label的宽度
 */
+ (CGFloat)widthForLabel:(UILabel *)label;

/**
 *    @brief label不同颜色不同字体大小设置
 *
 *    @param label     需要处理的label
 *    @param range     需要处理的文字范围
 *    @param noteColor 显示的不同的颜色
 *    @param noteFont  显示的不同字体大小
 */
+ (void)labelWith:(UILabel *)label RangeOfNote:(NSRange)range NoteColor:(UIColor *)noteColor        NoteFont:(UIFont *)noteFont;

/**
 *    @brief  请求数据Head节点
 *
 *    @return 返回Head节点信息
 */
+ (NSString *)getRequestHeadString;

/**
 *    @brief  获取请求数据Request节点信息（含省市区ID）
 *
 *    @param RGuid   资源请求唯一号，用于唯一标识每次的资源请求，由发起请求的程序生成
 *    @param content 数据内容
 *
 *    @return 返回Request节点信息
 */
+ (NSString *)getResquestCoderWithRGuid:(NSString*)RGuid Content:(NSDictionary *)content;

/**
 *    @brief  获取请求数据Request节点信息(不含省市区ID)
 *
 *    @param RGuid   资源请求唯一号，用于唯一标识每次的资源请求，由发起请求的程序生成
 *    @param content 数据内容
 *
 *    @return 返回Request节点信息
 */
+ (NSString *)getResquestCoderWithRGuid:(NSString *)RGuid
                    noneProvinceContent:(NSDictionary *)content;
/**
 *    @brief  base64编码
 *
 *    @param object 任意类型
 *
 *    @return 编码后的字符串
 */
+ (NSString *)base64WithObject:(id)object;

/**
 *    @brief  正则表达式判断手机号是否正确
 *
 *    @param phone  手机号
 *
 *    @return YES：手机号正确；NO：手机号错误
 */
+ (BOOL)checkTel:(NSString *)phone;


/**
 *    @brief  根据资源文件名获取图片
 *
 *    @param imageName 本地资源文件图片名称
 *
 *    @return 资源图片
 */
+ (UIImage *)imageWithImageName:(NSString *)imageName;

/**
 *    @brief  获取本机缓存中的推送 DeviceToken
 *
 *    @return 推送 DeviceToken
 */
+ (NSString *)getNoteficationDeviceToken;


/**
 *    @brief  从缓存中获取经纬度
 *
 *    @return 包含经纬度的字典 key: latitude，longitude
 */
+ (NSDictionary *)getLocation;

/**
 *    @brief  系统定位经纬度，并缓存到本地
 */
+ (void)locationAtCashe;

/**
 *    @brief  比较两个版本的大小,支持小版本信息比较（3.6.1>3.6）
 *
 *    @param versionA 版本A
 *    @param versionB 版本B
 *
 *    @return YES ：A>B  NO : A<=B
 */
+ (BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB;

/**
 *    @brief  判断是否登陆
 *
 *    @return YES：已登陆 ，NO：未登陆。
 */
+ (BOOL) isLoginAPP;

/**
 *    @brief  绘画扇形图
 *
 *    @param view            扇形图底部视图
 *    @param centerPoint     扇形原点坐标
 *    @param radius          扇形半径
 *    @param startAngle      扇形起始角度
 *    @param endAngle        扇形终止角度
 *    @param backgroundColor 扇形背景颜色
 */
+ (void)drawWithView:(UIView *)view
         centerPoint:(CGPoint)centerPoint
              radius:(CGFloat)radius
          startAngle:(CGFloat)startAngle
            endAngle:(CGFloat)endAngle backgroundColor:(UIColor *)backgroundColor;

/**
 *  验证身份证号
 */
+ (BOOL)checkIdentityCardNo:(NSString *)cardNo;

/**
 *    @brief  一级分类的最后更新时间
 *
 *    @return 时间戳
 */
+ (NSString *) getFirstLevelCategoryLastUpdateTime;

/**
 *    @brief  动画效果：放大后缩小
 *
 *    @param view 需要加动画的视图
 */
+ (void) shakeToShowAt:(UIView *)view;

@end
