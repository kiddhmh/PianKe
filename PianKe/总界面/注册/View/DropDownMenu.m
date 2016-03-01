//
//  DropDownMenu.m
//  登陆界面
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "DropDownMenu.h"

@implementation DropDownMenu


+ (void)showWith:(NSString *)str to:(UIView *)view belowSubView:(UIView *)belowview
{
    for (UIView  *sub in view.subviews) {
        if ([sub isKindOfClass:[DropDownMenu class]]) {
            return;
        }
    }
    CGFloat labelX = 0;
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width;
    CGFloat labelH = 30;
    CGFloat labelY = -30;
    
    DropDownMenu *menu = [[DropDownMenu alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelW, labelH)];
    label.text = str;
    label.backgroundColor = RGB(245, 96, 255);
    label.alpha = 0.5;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    
    [menu addSubview:label];
    
    [view insertSubview:menu belowSubview:belowview];
    
    //设置动画
    [UIView animateWithDuration:0.3 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0,labelH * 3);
        
    } completion:^(BOOL finished) {
        
        //延时0.8秒
        [UIView animateWithDuration:0.3 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [menu removeFromSuperview];
        }];
    }];
}

@end
