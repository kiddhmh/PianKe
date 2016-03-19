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
#import "Masonry.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "RadioThirdViewController.h"
#import "RadioSecondListModel.h"

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

@property (nonatomic,strong) LoginView *headView;

@property (nonatomic,strong) PlayMusicView *playMusicView;

@end

@implementation LeftMenuViewController


#pragma mark -
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView selectRowAtIndexPath:indexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    LoginView *headerView = [[LoginView alloc] init];
    [headerView setBackgroundColor:[UIColor colorWithHexString:@"#303030"]];
    
    //头部视图搜索按钮关联方法
    [headerView.searchBtn addTarget:self action:@selector(GotoSearch) forControlEvents:UIControlEventTouchUpInside];
    
    //头部视图登录/注册按钮关联方法
    [headerView.photoBtn addTarget:self action:@selector(GotoLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:headerView];
    self.headView = headerView;
    
    //设置尾部播放音乐视图
    PlayMusicView *playMusic = [[PlayMusicView alloc] init];
    playMusic.backgroundColor = RGB(28, 28, 28);
    [self.view addSubview:playMusic];
    self.playMusicView = playMusic;
    __weak typeof(self)vc = self;
    self.playMusicView.block = ^(RadioSecondListModel *listModel){
        RadioThirdViewController *thirdVC = [[RadioThirdViewController alloc] init];
        [thirdVC passModel:listModel andName:@""];
        [vc presentViewController:thirdVC animated:YES completion:nil];
    };
    
    //自动适配
    [self setupConstrain];
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
    
    if (indexPath.row == 0) {
        cell.TextColor = [UIColor whiteColor];
    }
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


#pragma mark - 
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


#pragma mark - 
#pragma mark -添加（自动适配）约束
- (void)setupConstrain
{
    __weak typeof(self)vc = self;
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(vc.view.mas_top);
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.height.mas_equalTo(VIEWHEIGHT * 0.3);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(vc.headView.mas_bottom);
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.bottom.equalTo(vc.playMusicView.mas_top);
    }];
    
    [self.playMusicView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.bottom.equalTo(vc.view.mas_bottom);
        make.height.mas_equalTo(VIEWHEIGHT * 0.1);
    }];
    
}


#pragma mark - 
#pragma mark - 按钮关联方法
/**
 *  头部视图搜索按钮关联方法
 */
- (void)GotoSearch
{
    //进入搜索页面
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
}

/**
 *  头部视图登录/注册按钮关联方法
 */
- (void)GotoLogin
{
    //进入登录页面
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


/**
 * 更改状态栏颜色
*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end


