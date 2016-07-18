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
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"



@interface SecondViewController ()<UIWebViewDelegate>
@property(strong,nonatomic) UITextField* username;
@property(strong,nonatomic) UITextField* password;
@property(strong,nonatomic)  UILabel* login;
@property(strong,nonatomic) UIButton *setLogin;
@property(strong,nonatomic) UIButton * zhuce;

@end

@implementation SecondViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect cgrect =[UIScreen mainScreen].applicationFrame;
    _username=[[UITextField alloc]initWithFrame:CGRectMake(10, 100, cgrect.size.width, 60)];
 
    UIColor *myColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(0, 50, cgrect.size.width-30,1)];
    underline.backgroundColor =  myColor;
    [_username addSubview:underline];
        _username.backgroundColor=[UIColor whiteColor];
   // _username.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:_username];
 //   _username.keyboardType = UIKeyboardTypeNumberPad;
    _username.returnKeyType = UIReturnKeyDone;
    _username.keyboardAppearance = UIKeyboardAppearanceDefault;
    _username.placeholder = @"用户名";
    
    
  _password=[[UITextField alloc]initWithFrame:CGRectMake(10, 170, cgrect.size.width, 60)];
    _password.backgroundColor =[UIColor whiteColor];
   // _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.placeholder=@"密码";
    _password.returnKeyType = UIReturnKeyDone;
     _password.keyboardAppearance = UIKeyboardAppearanceDefault;
     _password.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_password];
    UIColor *myColor2 = [UIColor colorWithWhite:0.8 alpha:0.8];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, cgrect.size.width-30,1)];
    underline2.backgroundColor =  myColor2;
    [_password addSubview:underline2];
    
    
    _setLogin=[[UIButton alloc]initWithFrame:CGRectMake(15, 260, cgrect.size.width-30, 60)];
  [ _setLogin setTitle:@"登录" forState:UIControlStateNormal];
    // 湖蓝色
    _setLogin.backgroundColor =[UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1];
    [self.view addSubview:_setLogin];
    _setLogin.layer.cornerRadius = 25.0f;
    
    
    
    _setLogin.layer.masksToBounds = YES;
    _login= [[UILabel alloc]initWithFrame:CGRectMake(80, 340, cgrect.size.width-40, 60)];
    _login.text = @"没有众测账号？去注册";
    [self.view addSubview:_login];
//    _zhuce=[[UIButton alloc]initWithFrame:CGRectMake(80, 340, cgrect.size.width-40, 60)];
//    [_zhuce setTitle:@"没有众测账号？去注册" forState:UIControlStateNormal];
//    _zhuce.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview: _zhuce];
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [self textFieldShouldReturn:_username];
    [self textFieldShouldReturn:_password];

    

    
    
    
   
}
- (void)textViewDidBeginEditing:(UITextField *)textView
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_password resignFirstResponder];
        [_username resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
