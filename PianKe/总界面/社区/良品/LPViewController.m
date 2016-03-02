//
//  LPViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIBarButtonItem+Helper.h"
@interface LPViewController ()

@end

@implementation LPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setupNavItem];
}

#pragma mark -
#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"良品" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



@end
