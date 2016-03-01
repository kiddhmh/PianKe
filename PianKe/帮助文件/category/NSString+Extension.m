//
//  NSString+Extension.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/1.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (BOOL)match:(NSString *)Pattern
{
    //1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:Pattern options:0 error:nil];
    
    //2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isEmail
{
    NSString *Pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self match:Pattern];
}

@end
