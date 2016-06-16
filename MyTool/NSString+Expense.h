//
//  NSString+Expense.h
//  zhongce
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 fuwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Expense)
// 判断字符串是否为空或者nil  jjj
+ (BOOL)isNil:(NSString *)string;

// 判断手机号格式是否正确
- (BOOL)isCorrectTelOrPhone:(BOOL)allCheck;

// 自适应字体宽度

- (CGSize)customSizeWithFont:(UIFont *)font;

// 当参数为空时返回@""
+(NSString*)ridObject:(id)object;


@end
