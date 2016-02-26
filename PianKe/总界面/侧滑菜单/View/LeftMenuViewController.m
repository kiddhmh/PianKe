//
//  LeftMenuViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "GoodPorductsViewController.h"
#import "LoginView.h"
#import "PlayMusicView.h"
#import "AllControllersTool.h"
#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height
@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  UITableView
 */
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation LeftMenuViewController

#pragma mark -
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT * 0.3, VIEWWIDTH, VIEWHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] init];
    }
    return _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.titleArray = @[@"首页",@"电台",@"阅读",@"社区",@"碎片",@"良品",@"设置"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.tableView];
    
    //设置头部视图
    UIView *headerView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0,VIEWWIDTH * 0.75,VIEWHEIGHT * 0.3)];
    headerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:headerView];
    
    //设置尾部播放音乐视图
    PlayMusicView *playMusic = [[PlayMusicView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT * 0.92, VIEWWIDTH / 0.75, VIEWHEIGHT * 0.08)];
    playMusic.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:playMusic];
}


#pragma mark -
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    return cell;
}


#pragma mark -
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击对应的cell切换对应的视图控制器
    [AllControllersTool createViewControllerWithIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    //设置点击cell取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.backgroundColor = [UIColor darkGrayColor];
    });
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

@end


