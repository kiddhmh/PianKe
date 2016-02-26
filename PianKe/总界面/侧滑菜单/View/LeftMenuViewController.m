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
#import "UIColor+Extension.h"
#import "SideMenuCellTableViewCell.h"
#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height
@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  UITableView
 */
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

/**
 *  Cell上的图片数组
 */
@property (nonatomic,strong) NSArray *cellImages;

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

- (NSArray *)cellImages
{
    if (!_cellImages) {
        _cellImages = [[NSArray alloc] init];
    }
    return _cellImages;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.titleArray = @[@"首页",@"电台",@"阅读",@"社区",@"碎片",@"良品",@"设置"];
    
    self.cellImages = @[@"home",@"radio",@"reading",@"peoples",@"snow",@"good",@"setting"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#303030"];
    [self.view addSubview:self.tableView];
    
    //设置头部视图
    UIView *headerView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0,VIEWWIDTH * 0.75,VIEWHEIGHT * 0.3)];
    [headerView setBackgroundColor:[UIColor colorWithHexString:@"#303030"]];
    [self.view addSubview:headerView];
    
    //设置尾部播放音乐视图
    PlayMusicView *playMusic = [[PlayMusicView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT * 0.9, VIEWWIDTH / 0.75, VIEWHEIGHT * 0.1)];
    playMusic.backgroundColor = RGB(28, 28, 28);
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
    
    SideMenuCellTableViewCell *cell = [SideMenuCellTableViewCell cellWith:tableView];
    cell.title = self.titleArray[indexPath.row];
    cell.iconImage = self.cellImages[indexPath.row];
    
    return cell;
}


#pragma mark -
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击对应的cell切换对应的视图控制器
    [AllControllersTool createViewControllerWithIndex:indexPath.row];
    
    //遍历所有cell，将选中的设为白色，没选中的设为灰色
    for (NSUInteger index = 0; index < self.titleArray.count; index ++) {
        SideMenuCellTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (index == indexPath.row) { //选中cell
            cell.TextColor = [UIColor whiteColor];
        }else { //非选中的cell
            cell.TextColor = [UIColor lightGrayColor];
        }
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

@end


