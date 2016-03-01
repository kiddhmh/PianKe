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
@interface ReadingViewController ()

@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
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



@end
