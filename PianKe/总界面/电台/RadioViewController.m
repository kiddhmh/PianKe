//
//  RadioViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIBarButtonItem+Helper.h"
#import "MMDrawerBarButtonItem.h"
#import "HttpTool.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "RadioAllList.h"
#import "RadioCarousel.h"
#import "RadioHostList.h"
#import "RadioHeaderView.h"
#import "RadioListCell.h"
#import "PKRefreshHeader.h"
#import "PKRefreshFooter.h"
#import "AFNetworking.h"
#import "WebViewController.h"
#import "RadioSecondViewController.h"

@interface RadioViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  存放顶部视图的数据
 */
@property (nonatomic,strong) NSMutableArray *radioHeaderArray;
/**
 *  表格头部视图
 */
@property (nonatomic,strong) RadioHeaderView *radioHeaderView;
/**
 *  表格
 */
@property (nonatomic,strong) UITableView *radioTableView;
/**
 *  表格数据源数组
 */
@property (nonatomic,strong) NSMutableArray *radioAllListArray;


@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self.view addSubview:self.radioTableView];
    self.radioTableView.tableHeaderView = self.radioHeaderView;
    self.radioTableView.tableFooterView = [[UIView alloc] init];
    
    [self creatUrlRequest];
    
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.radioTableView];
    
    //创建下拉刷新
    self.radioTableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //创建上拉刷新
    self.radioTableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
}

#pragma mark -
#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"电台" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - 
#pragma mark - 发送网络请求
- (void)creatUrlRequest
{
    [HttpTool getWithPath:@"http://api2.pianke.me/ting/radio" params:nil success:^(id JSON) {
       
        NSDictionary *dataDic = JSON[@"data"];
        NSMutableArray *headerarray = [RadioCarousel mj_objectArrayWithKeyValuesArray:dataDic[@"carousel"]];
        NSMutableArray *hotarray = [RadioHostList mj_objectArrayWithKeyValuesArray:dataDic[@"hotlist"]];
        [self.radioHeaderArray addObject:headerarray];
        [self.radioHeaderArray addObject:hotarray];
        //设置表格头部视图的数据
        self.radioHeaderView.listArray = self.radioHeaderArray;
        //设置表格的数据
        self.radioAllListArray = [RadioAllList mj_objectArrayWithKeyValuesArray:dataDic[@"alllist"]];
        
        [self.radioTableView reloadData];
        [self.waitView dismiss];
        [self.radioTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
        [self.waitView dismiss];
        [self.radioTableView.mj_header endRefreshing];
    }];
    
    
}



#pragma mark - 表格数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.radioAllListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioListCell *cell = [RadioListCell cellWith:tableView];
    cell.allList = self.radioAllListArray[indexPath.row];
    return cell;
}


#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioSecondViewController *secondVC = [[RadioSecondViewController alloc] init];
    RadioAllList *model = self.radioAllListArray[indexPath.row];
    [secondVC passContentidForRadio:model.radioid];

    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - 下拉刷新方法
- (void)loadNewData
{
    [self creatUrlRequest];
}


#pragma mark - 上拉刷新方法
- (void)loadMoredata
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.radioTableView.mj_footer endRefreshing];
    });
}


#pragma mark - 
#pragma mark - 懒加载
- (NSMutableArray *)radioHeaderArray
{
    if (!_radioHeaderArray) {
        _radioHeaderArray = [NSMutableArray array];
    }
    return _radioHeaderArray;
}


- (NSMutableArray *)radioAllListArray
{
    
    if (!_radioAllListArray) {
        _radioAllListArray = [NSMutableArray array];
    }
    return _radioAllListArray;
}

- (UITableView *)radioTableView
{
    if (!_radioTableView) {
        _radioTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _radioTableView.delegate = self;
        _radioTableView.dataSource = self;
    }
    return _radioTableView;
}


- (RadioHeaderView *)radioHeaderView
{
    if (!_radioHeaderView) {
        _radioHeaderView = [[RadioHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENHEIGHT, (180 + HotImageW + 2 * Margin))];
        __weak typeof(self)weakSelf = self;
        _radioHeaderView.block = ^(NSString * url){
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.url = url;
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        };
    }
    return _radioHeaderView;
}

@end
