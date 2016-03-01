//
//  RegisterBottomView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RegisterBottomView.h"
#import "HMHTextField.h"
#import "Masonry.h"
@interface RegisterBottomView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *namelineView;
@property (nonatomic,strong) UIView *YXlineView;
@property (nonatomic,strong) UIView *MMlineView;

/**
 *  提示信息
 */
@property (nonatomic,strong) UILabel *messageLabel;


@end

@implementation RegisterBottomView

#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.nameTextField];
        [self addSubview:self.YXTextField];
        [self addSubview:self.MMTextField];
        [self addSubview:self.FinishBtn];
        [self addSubview:self.namelineView];
        [self addSubview:self.YXlineView];
        [self addSubview:self.MMlineView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.messageBtn];
        
        self.nameTextField.delegate = self;
        self.YXTextField.delegate = self;
        self.MMTextField.delegate = self;
        
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
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //昵称输入框约束
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.mas_top).offset([UIScreen mainScreen].bounds.size.height * 0.08);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.mas_left).offset(30);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.06);
    }];
    
    //邮箱输入框约束
    [_YXTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.nameTextField.mas_bottom).offset(15);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.nameTextField.mas_left);
        make.height.equalTo(vc.nameTextField.mas_height);
    }];
    
    //密码输入框约束
    [_MMTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.YXTextField.mas_bottom).offset(15);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.nameTextField.mas_left);
        make.height.mas_equalTo(vc.nameTextField.mas_height);
    }];
    
    //昵称线条约束
    [_namelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.nameTextField.mas_bottom);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.nameTextField.mas_left).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    //邮箱线条约束
    [_YXlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.YXTextField.mas_bottom);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.YXTextField.mas_left).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    //密码线条约束
    [_MMlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.MMTextField.mas_bottom);
        make.left.equalTo(vc.MMTextField.mas_left).offset(5);
        make.centerX.equalTo(vc.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    
    //登录按钮约束
    [_FinishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.MMTextField.mas_bottom).offset(30);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.MMTextField.mas_left);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.06);
    }];
    
    //提示信息
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.FinishBtn.mas_bottom).offset(50);
        make.left.equalTo(vc.FinishBtn.mas_left).offset(10);
        make.right.equalTo(vc.messageBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    //片刻协议按钮
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.messageLabel.mas_centerY);
        make.height.equalTo(vc.messageLabel.mas_height);
        make.left.equalTo(vc.messageLabel.mas_right);
        make.right.equalTo(vc.FinishBtn.mas_right).offset(-10);
    }];
    
}


#pragma mark -
#pragma mark - 懒加载
- (HMHTextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[HMHTextField alloc] init];
        _nameTextField.title = @"昵称";
    }
    return _nameTextField;
}

- (HMHTextField *)YXTextField
{
    if (!_YXTextField) {
        _YXTextField = [[HMHTextField alloc] init];
        _YXTextField.title = @"邮箱";
    }
    return _YXTextField;
}


- (HMHTextField *)MMTextField
{
    if (!_MMTextField) {
        _MMTextField = [[HMHTextField alloc] init];
        _MMTextField.title = @"密码";
        _MMTextField.secureTextEntry = YES;
    }
    return _MMTextField;
}

- (UIButton *)FinishBtn
{
    if (!_FinishBtn) {
        _FinishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_FinishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_FinishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_FinishBtn setBackgroundColor:RGB(55, 207, 16)];
    }
    return _FinishBtn;
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

- (UIView *)namelineView
{
    if (!_namelineView) {
        _namelineView = [[UIView alloc] init];
        _namelineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _namelineView;
}

- (UIButton *)messageBtn
{
    if (!_messageBtn) {
        _messageBtn = [[UIButton alloc] init];
        [_messageBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_messageBtn setTitle:@"片刻协议" forState:UIControlStateNormal];
        [_messageBtn setBackgroundColor:[UIColor clearColor]];
        _messageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _messageBtn;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"点击'完成'按钮，代表你已阅读并同意";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.backgroundColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

@end
