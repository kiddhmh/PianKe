//
//  MiddleView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "MiddleView.h"
#import "HMHTextField.h"
#import "Masonry.h"
@interface MiddleView ()<UITextFieldDelegate>
/**
 *  邮箱文本框下方的线条
 */
@property (nonatomic,strong) UIView *YXlineView;
/**
 *  密码文本框下方的线条
 */
@property (nonatomic,strong) UIView *MMlineView;

@end

@implementation MiddleView

#pragma mark - 
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.YXtextField];
        [self addSubview:self.MMtextField];
        [self addSubview:self.YXlineView];
        [self addSubview:self.MMlineView];
        [self addSubview:self.LoginBtn];
        
        self.YXtextField.delegate = self;
        self.MMtextField.delegate = self;
        
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark - 
#pragma mark - 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mrk - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //邮箱输入框约束
    [_YXtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.mas_top).offset(10);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.mas_left).offset(30);
        make.bottom.equalTo(vc.MMtextField.mas_top).offset(-20) ;
    }];
    
    //密码输入框约束
    [_MMtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.YXtextField.mas_bottom).offset(20);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.YXtextField.mas_left);
        make.height.equalTo(vc.YXtextField.mas_height);
    }];
    
    //邮箱线条约束
    [_YXlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.YXtextField.mas_bottom);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.YXtextField.mas_left).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    //密码线条约束
    [_MMlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.MMtextField.mas_bottom);
        make.left.equalTo(vc.MMtextField.mas_left).offset(5);
        make.centerX.equalTo(vc.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    
    //登录按钮约束
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.MMtextField.mas_bottom).offset(20);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.MMtextField.mas_left);
        make.height.equalTo(vc.YXtextField.mas_height);
    }];
}


#pragma mark -
#pragma mark - 懒加载
- (HMHTextField *)YXtextField
{
    if (!_YXtextField) {
        //创建邮箱TextField
        _YXtextField = [[HMHTextField alloc] init];
        _YXtextField.title = @"邮箱";
    }
    return _YXtextField;
}

- (HMHTextField *)MMtextField
{
    if (!_MMtextField) {
        _MMtextField = [[HMHTextField alloc] init];
        _MMtextField.title = @"密码";
        _MMtextField.secureTextEntry = YES;
    }
    return _MMtextField;
}


- (UIView *)YXlineView
{
    if (!_YXlineView) {
        _YXlineView = [[UIView alloc] init];
        _YXlineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _YXlineView;
}


- (UIView *)MMlineView
{
    if (!_MMlineView) {
        _MMlineView = [[UIView alloc] init];
        _MMlineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _MMlineView;
}

- (UIButton *)LoginBtn
{
    if (!_LoginBtn) {
        _LoginBtn = [[UIButton alloc] init];
        _LoginBtn.backgroundColor = RGB(55, 207, 16);
        [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _LoginBtn;
}

@end
