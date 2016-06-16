//
//  AppDelegate.m
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import "AppDelegate.h"

#import "tiaozhuanViewController.h"
#import "ThirdViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self create_tabBar];

    return YES;
}

-(void)create_tabBar
{
    FirstViewController *firstView = [[FirstViewController alloc]init];
    firstView.title = @"首页";
    ThirdViewController *thirdView =[[ThirdViewController alloc]init];
    thirdView.title =@"案例管理";
    SecondViewController *secondView =[[SecondViewController alloc]init];
    secondView.title=@"我的";
    
    UINavigationController *first_view =[[UINavigationController alloc]initWithRootViewController:firstView];
    UINavigationController * third_view =[[UINavigationController alloc]initWithRootViewController:thirdView];
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    //30
    //144
    //255  61 89 171
    
    
    bar.barTintColor = [UIColor colorWithRed:61/255.0 green:105/255.0 blue:255/255.0 alpha:1.0];
    //设置字体颜色
    
    bar.tintColor = [UIColor whiteColor];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UINavigationController * second_view =[[UINavigationController alloc]initWithRootViewController:secondView];
    
    first_view.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"first.pdf"]  tag:0];
    third_view.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"定制" image:[UIImage imageNamed:@"second.pdf"] tag:1];
    second_view.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"first.pdf"] tag:2];
    
    NSArray *listarray = [NSArray arrayWithObjects:first_view,third_view,second_view ,nil];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers=listarray;
    self.window.rootViewController=tabBarController;
    
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
