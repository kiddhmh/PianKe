//
//  TopView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "TopView.h"
#import "Masonry.h"
@interface TopView ()
/**
 *  图标
 */
@property (nonatomic,strong) UIImageView *logoImageView;

@end
@implementation TopView

#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.registerBtn];
        [self addSubview:self.logoImageView];
        
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark -
#pragma mark - 懒加载
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _backBtn;
}


- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:[UIColor clearColor]];
        [_registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _registerBtn;
}


- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"片刻LOGO"];
    }
    return _logoImageView;
}


#pragma mark -
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //返回按钮
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 40));
        make.left.equalTo(vc.mas_left).offset(20);
        make.top.equalTo(vc.mas_top).offset(20);
    }];
    
    //注册按钮
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.right.equalTo(vc.mas_right).offset(-20);
        make.centerY.equalTo(vc.backBtn.mas_centerY);
    }];
    
    //LOGO图标
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(vc.mas_centerX);
        make.centerY.equalTo(vc.mas_centerY).offset(-vc.frame.size.height / 4);
    }];
}

@end
