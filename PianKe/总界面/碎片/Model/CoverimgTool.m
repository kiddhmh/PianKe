//
//  CoverimgTool.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "CoverimgTool.h"

@implementation CoverimgTool

+ (double)sizeWithSizeString:(NSString *)sizeString
{
    NSString *pattern = @"[*]";
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
   NSArray *results = [regular matchesInString:sizeString options:0 range:NSMakeRange(0, sizeString.length)];
    
    NSRange resultRange;
    for (NSTextCheckingResult *result in results) {
        resultRange = result.range;
    }
    
    NSString *strW = [sizeString substringWithRange:NSMakeRange(0, resultRange.location)];
    NSString *strH = [sizeString substringWithRange:NSMakeRange(resultRange.location + 1, sizeString.length - resultRange.location - 1)];
    
    double scale = [strH doubleValue] / [strW doubleValue];
    
    return scale;
}

@end
