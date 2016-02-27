//
//  HMHNavigationController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "HMHNavigationController.h"
#import "UIColor+Extension.h"
@interface HMHNavigationController ()

@end

@implementation HMHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //动态更改导航背景 / 样式
    //开启编辑
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置导航条背景颜色
    [bar setBarTintColor:[UIColor colorWithHexString:@"#303030"]];
    //设置字体颜色
    [bar setTintColor:[UIColor whiteColor]];
    //设置样式
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                  }];
    
    //设置导航条按钮样式
    //开启编辑
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置样式
    [item setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                  } forState:UIControlStateNormal];
    
}



/**
 *  更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}



@end
