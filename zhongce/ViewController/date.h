//
//  date.h
//  zhongce
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface date : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSURL*headimage;
@property(nonatomic,copy)NSString*content;




+(date *) headimage:(NSURL *)headimage title:(NSString *)title content:(NSString *)content;


@end
