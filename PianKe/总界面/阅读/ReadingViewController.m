//
//  ReadingViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ReadingViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"
#import "LoadingView.h"
@interface ReadingViewController ()

@end

@implementation ReadingViewController


#pragma mark - 
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupNavItem];
    
    //添加等待动画
    LoadingView *waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [waitView showLoadingTo:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [waitView dismiss];
    });
}


#pragma mark -
#pragma mark - 自动适配



#pragma mark - 
#pragma mark - 初始化子控件方法
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"阅读" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -
#pragma mark - 懒加载


@end
