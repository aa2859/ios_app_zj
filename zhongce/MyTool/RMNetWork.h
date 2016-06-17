//
//  RMNetWork.h
//  zhongce
//
//  Created by Apple on 16/6/9.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNetWork : NSObject
+ (RMNetWork *)shareInstance;

- (BOOL)rechability;
@end
