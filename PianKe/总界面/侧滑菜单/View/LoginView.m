//
//  LoginView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LoginView.h"
@interface LoginView ()
/**
 *  测试按钮
 */
@property (nonatomic,strong) UIButton *btn;
@end
@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化子控件
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"我的主页" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    for (UIView *sub in self.subviews) {
        sub.frame = CGRectMake(80,50,100,50);
    }
}


@end
