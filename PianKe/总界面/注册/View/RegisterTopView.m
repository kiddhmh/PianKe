//
//  RegisterTopView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RegisterTopView.h"
#import "Masonry.h"
@interface RegisterTopView ()
/**
 *  男生按钮
 */
@property (nonatomic,strong) UIButton *boyButton;
/**
 *  女生按钮
 */
@property (nonatomic,strong) UIButton *girlButton;

@end
@implementation RegisterTopView

#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.iconImageView];
        [self addSubview:self.boyButton];
        [self addSubview:self.girlButton];
        
        //设置子控件的自动适配
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark -
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //返回按钮约束
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 40));
        make.left.equalTo(vc.mas_left).offset(20);
        make.top.equalTo(vc.mas_top).offset(20);
    }];
    
    //头像图片约束
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(56, 56));
        make.centerX.equalTo(vc.mas_centerX);
        make.centerY.equalTo(vc.mas_centerY).offset(- [UIScreen mainScreen].bounds.size.height * 0.05);
    }];
    
    //男生头像的约束
    [_boyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.mas_left).offset([UIScreen mainScreen].bounds.size.width * 0.2);
        make.bottom.equalTo(vc.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(53, 25));
    }];
    
    //女生头像的约束
    [_girlButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vc.mas_right).offset(-[UIScreen mainScreen].bounds.size.width * 0.2);
        make.bottom.equalTo(vc.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(53, 25));
    }];
}


#pragma mark -
#pragma mark - 按钮关联方法
- (void)select:(UIButton *)btn
{
    if (btn ==self.boyButton) {
        self.boyButton.enabled = NO;
        self.girlButton.enabled = YES;
        self.xingbie = @"1";
        
    }else
    {
        self.boyButton.enabled = YES;
        self.girlButton.enabled = NO;
        self.xingbie = @"2";
    }
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


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"上传头像"];
    }
    return _iconImageView;
}


- (UIButton *)boyButton
{
    if (!_boyButton) {
        _boyButton = [[UIButton alloc] init];
        [_boyButton setImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
        [_boyButton setImage:[UIImage imageNamed:@"男_sel"] forState:UIControlStateDisabled];
        [_boyButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        _boyButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _boyButton;
}


- (UIButton *)girlButton
{
    if (!_girlButton) {
        _girlButton = [[UIButton alloc] init];
        [_girlButton setImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
        [_girlButton setImage:[UIImage imageNamed:@"女_sel"] forState:UIControlStateDisabled];
        [_girlButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        _girlButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _girlButton;
}

@end
