//
//  BottomView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "BottomView.h"
#import "Masonry.h"
@interface BottomView ()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation BottomView

#pragma mark - 
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.weiboButton];
        [self addSubview:self.peopleButton];
        [self addSubview:self.doubanButton];
        [self addSubview:self.QQButton];
        
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark - 
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.mas_top).offset(30);
        make.left.equalTo(vc.mas_left).offset(30);
        make.centerX.equalTo(vc.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    
    //文字约束
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.titleView.mas_centerY);
        make.centerX.equalTo(vc.titleView.mas_centerX);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 3 - 5);
    }];
    
    //微博按钮的约束
    [_weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width * 0.15);
    }];
    
    //人人按钮的约束
    [_peopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width * 0.35);
    }];
    
    //豆瓣按钮的约束
    [_doubanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width * 0.55);
    }];
    
    //QQ按钮的约束
    [_QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.left.mas_equalTo([UIScreen mainScreen].bounds.size.width * 0.75);
    }];
}


#pragma mark -
#pragma mark - 懒加载
- (UIButton *)weiboButton
{
    if (!_weiboButton) {
        _weiboButton = [[UIButton alloc] init];
        [_weiboButton setImage:[UIImage imageNamed:@"新浪"] forState:UIControlStateNormal];
    }
    return _weiboButton;
}

- (UIButton *)doubanButton
{
    if (!_doubanButton) {
        _doubanButton = [[UIButton alloc] init];
        [_doubanButton setImage:[UIImage imageNamed:@"豆瓣"] forState:UIControlStateNormal];
    }
    return _doubanButton;
}

- (UIButton *)peopleButton
{
    if (!_peopleButton) {
        _peopleButton = [[UIButton alloc] init];
        [_peopleButton setImage:[UIImage imageNamed:@"人人"] forState:UIControlStateNormal];
    }
    return _peopleButton;
}

- (UIButton *)QQButton
{
    if (!_QQButton) {
        _QQButton = [[UIButton alloc] init];
        [_QQButton setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    }
    return _QQButton;
}

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _titleView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"合作伙伴登录片刻";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

@end
