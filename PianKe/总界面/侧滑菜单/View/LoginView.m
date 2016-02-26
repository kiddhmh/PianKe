//
//  LoginView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LoginView.h"
#import "SearchBar_textField.h"
#import "Masonry.h"
@interface LoginView ()<UITextFieldDelegate>
/**
 *  搜索框
 */
@property (nonatomic,strong) SearchBar_textField *search;
/**
 *   头像图片
 */
@property (nonatomic,strong) UIButton *photoBtn;


@end
@implementation LoginView


#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化子控件
        [self setupSubViews];
    }
    return self;
}


/**
 *  初始化子控件
 */
- (void)setupSubViews
{
    //创建搜索框
    SearchBar_textField *serach = [SearchBar_textField searchBar];
    self.search = serach;
    self.search.delegate = self;
    self.search.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:serach];
    
    //创建四个按钮
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Home%d",i + 1]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(ChangeMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        
        [self addSubview:btn];
        
        //设置按钮的位置
        CGFloat pading = 30;
        CGFloat margin = 65;
        CGFloat btnX = pading + margin *i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(@20);
            make.left.mas_equalTo(self.mas_left).offset(btnX);
            make.bottom.equalTo(self.search.mas_top).offset(- pading *0.5);
        }];
    }
    
    
    //创建登录注册按钮
    UIButton *photoBtn = [[UIButton alloc] init];
    [photoBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [self addSubview:photoBtn];
    photoBtn.contentMode = UIViewContentModeCenter;
    [photoBtn setTitle:@"登录 | 注册" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    photoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    photoBtn.adjustsImageWhenHighlighted = NO;
    photoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,5);
    photoBtn.titleEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [photoBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    self.photoBtn = photoBtn;
}


/**
 *  排布子控件的位置和尺寸
 */
- (void)layoutSubviews
{
    //设置搜索框的位置
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(self.frame.size.height * 0.35);
        make.width.mas_equalTo(self.frame.size.width * 0.85);
        make.height.mas_equalTo(@25);
    }];
    
    //设置头像的位置
    CGFloat photoW = self.frame.size.height * 0.7;
    CGFloat photoH = self.frame.size.height / 3;
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(photoW);
        make.height.mas_equalTo(photoH);
        make.centerX.mas_equalTo(self.mas_centerX).offset(- self.frame.size.width * 0.2);
        make.centerY.mas_equalTo(self.mas_centerY).offset(- self.frame.size.width * 0.1);
    }];
}


#pragma mark - 
#pragma mark - 代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark - 其他方法
/**
 *  登录注册按钮关联方法
 */
- (void)Login
{
    NSLog(@"点击了登录注册按钮");
}

/**
 *  菜单按钮关联方法
 */
- (void)ChangeMenu:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
}


@end
