//
//  UIColor+Extension.h
//  图吧导航1号
//
//  Created by Mr.Psychosis on 14/9/23.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
