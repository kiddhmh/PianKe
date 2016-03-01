//
//  LoginViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "TopView.h"
#import "RegisterViewController.h"
#import "MiddleView.h"
#import "BottomView.h"
#import "HMHTextField.h"
#import "NSString+Extension.h"
#import "DropDownMenu.h"

@interface LoginViewController ()
/**
 *  上面部分的View
 */
@property (nonatomic,strong) TopView *topView;
/**
 *  中间部分的View
 */
@property (nonatomic,strong)  MiddleView *middleView;
/**
 *  底部部分的Vie
 */
@property (nonatomic,strong) BottomView *bottomView;

@end

@implementation LoginViewController

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.bottomView];
    
    //给按钮添加关联方法
    //返回按钮
    [self.topView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮
    [self.topView.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    //确认按钮
    [self.middleView.LoginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //给子控件添加约束
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
#pragma mark - 懒加载
- (TopView *)topView
{
    if (!_topView) {
        _topView = [[TopView alloc] init];
    }
    return _topView;
}


- (MiddleView *)middleView
{
    if (!_middleView) {
        _middleView = [[MiddleView alloc] init];
    }
    return _middleView;
}

- (BottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc] init];
    }
    return _bottomView;
}


#pragma mark - 
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //设置上部分视图约束
    CGFloat topViewH = self.view.frame.size.height / 2;
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(vc.view);
        make.height.mas_equalTo(topViewH);
    }];
    
    //设置中间视图约束
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.topView.mas_bottom);
        make.left.and.right.equalTo(vc.topView);
        make.bottom.equalTo(vc.bottomView.mas_top);
    }];
    
    //设置底部视图的约束
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(vc.view);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.2);
    }];
}


#pragma mark -
#pragma mark - 代理方法


#pragma mark - 
#pragma mark - 通知方法
/**
 *  页面上移
 */
- (void)changeFrame
{
    self.view.transform = CGAffineTransformMakeTranslation(0, -50);
}

/**
 *  页面恢复
 */
- (void)backFrame
{
    self.view.transform = CGAffineTransformIdentity;
}


#pragma mark - 
#pragma mark - 按钮关联的方法
/**
 *  返回上一级页面
 */
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  进入注册页面
 */
- (void)registerUser
{
    RegisterViewController *UserVC = [[RegisterViewController alloc] init];
    
    [self presentViewController:UserVC animated:YES completion:nil];
}

/**
 *  确认登录按钮
 */
- (void)login
{
    if ([self isRight]) {
        NSLog(@"登录成功");
    }else
    {
        NSLog(@"登录失败");
    }
}


#pragma mark -
#pragma mark - 判断文本框是否符合规范
- (BOOL)isRight
{
    if (self.middleView.YXtextField.text.length == 0) {
        [DropDownMenu showWith:@"请输入邮箱" to:self.view belowSubView:self.view];
        return NO;
    }else if (self.middleView.MMtextField.text.length == 0)
    {
        [DropDownMenu showWith:@"请输入密码" to:self.view belowSubView:self.view];
        return NO;
    }else if ([self.middleView.YXtextField.text isEmail] == NO){
        [DropDownMenu showWith:@"邮箱格式错误" to:self.view belowSubView:self.view];
    }
    return YES;
}


/**
 * 隐藏状态栏
 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
