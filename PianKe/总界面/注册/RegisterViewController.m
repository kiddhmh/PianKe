//
//  RegisterViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTopView.h"
#import "Masonry.h"
#import "RegisterBottomView.h"
@interface RegisterViewController ()
/**
 *  上部分视图
 */
@property (nonatomic,strong) RegisterTopView *topView;
/**
 *  下部分视图
 */
@property (nonatomic,strong) RegisterBottomView *bottomView;

@end

@implementation RegisterViewController


#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topView];
    [self.topView.backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomView];
    
    [self setupAutoLayout];
    
    //添加通知监听键盘的显示和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFrame) name:UIKeyboardWillHideNotification object:nil];
}


/**
 *  页面被销毁时，移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //设置上部分视图约束
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.view.mas_top);
        make.centerX.equalTo(vc.view.mas_centerX);
        make.left.equalTo(vc.view.mas_left);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.4);
    }];
    
    //设置下部分视图的约束
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.topView.mas_bottom);
        make.left.and.right.bottom.equalTo(vc.view);
    }];
    
}

#pragma mark -
#pragma mark - 懒加载
- (RegisterTopView *)topView
{
    if (!_topView) {
        _topView = [[RegisterTopView alloc] init];
    }
    return _topView;
}


- (RegisterBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[RegisterBottomView alloc] init];
    }
    return _bottomView;
}


#pragma mark -
#pragma mrk - 按钮关联方法
/**
 *  返回上一级页面
 */
- (void)backTo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark - 通知方法
/**
 *  页面上移
 */
- (void)changeFrame
{
    self.view.transform = CGAffineTransformMakeTranslation(0, -100);
}

/**
 *  页面恢复
 */
- (void)backFrame
{
    self.view.transform = CGAffineTransformIdentity;
}

@end
