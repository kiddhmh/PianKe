//
//  RadioSecondViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioSecondViewController.h"
#import "RadioSecondCell.h"
#import "RadioSecondHeaderView.h"
#import "HttpTool.h"
#import "UIBarButtonItem+Helper.h"
#import "MJExtension.h"
#import "RadioSecondRadioInfo.h"
#import "RadioSecondListModel.h"
#import "SVProgressHUD.h"
#import "LoadingView.h"
#import "PKRefreshFooter.h"
#import "PKRefreshHeader.h"
#import "RadioThirdViewController.h"
#import "userinfo.h"

@interface RadioSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *radioTableView;
@property (nonatomic,strong) RadioSecondHeaderView *headerView;
/**
 *  表格头部视图数据
 */
@property (nonatomic,strong) NSMutableArray *TopdataSource;
/**
 *  表格内容数据
 */
@property (nonatomic,strong) NSMutableArray *tableViewSource;
/**
 *  电台id
 */
@property (nonatomic,strong) NSString *contentid;

@property (nonatomic,strong) LoadingView *waitView;
@property (nonatomic,assign) NSInteger start;
@end


@implementation RadioSecondViewController

- (void)passContentidForRadio:(NSString *)contentid
{
    if (![contentid isKindOfClass:[NSNull class]]) {
        self.contentid = contentid;
    }
}

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.radioTableView];
    self.headerView = [[RadioSecondHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.4)];
    self.radioTableView.tableHeaderView = self.headerView;
    self.radioTableView.tableFooterView = [[UIView alloc] init];
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.backBarButtonItem = backItem;
    
    //发送网络请求
    [self creatURLRequest];
    
    //等待动画
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.radioTableView];
    
    //添加上拉,下拉刷新
    self.radioTableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.radioTableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
- (void)creatURLRequest
{
    NSDictionary *params = @{
                          @"radioid":self.contentid,
                          @"start":@"0",
                          @"limit":@"10",
                          @"client":@"2",
                          };
    [HttpTool postWithPath:@"ting/radio_detail" params:params success:^(id JSON) {
        
        NSDictionary *dataDic = JSON[@"data"];
        [self.TopdataSource addObject: [RadioSecondRadioInfo mj_objectWithKeyValues:dataDic[@"radioInfo"]]];
        self.tableViewSource = [RadioSecondListModel mj_objectArrayWithKeyValuesArray:dataDic[@"list"]];
        
        self.headerView.radioInfo = [self.TopdataSource firstObject];
        
        [self.radioTableView reloadData];
        [self.waitView dismiss];
        [self.radioTableView.mj_header endRefreshing];
        [self.radioTableView.mj_footer endRefreshing];
        self.start = 0;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.waitView dismiss];
        [self.radioTableView.mj_header endRefreshing];
        [self.radioTableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewSource.count;
}


#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioSecondCell *cell = [RadioSecondCell cellWithtableView:tableView];
    cell.radioListModel = self.tableViewSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioSecondListModel *model = self.tableViewSource[indexPath.row];
    RadioThirdViewController *thirdVC = [[RadioThirdViewController alloc] init];
    RadioSecondRadioInfo *info = [self.TopdataSource firstObject];
    [thirdVC passModel:model andName:info.userinfo.uname];
    [self.navigationController pushViewController:thirdVC animated:YES];
}


#pragma mark - 下拉刷新最新数据
- (void)loadNewData
{
    if ([self.radioTableView.mj_header isRefreshing]) return;
    [self.tableViewSource removeAllObjects];
    [self creatURLRequest];
}



#pragma mark - 上拉加载更多
- (void)loadMoreData
{
    self.start += 10;
    NSDictionary *params = @{
                             @"radioid":self.contentid,
                             @"start":@(self.start),
                             @"limit":@"10",
                             @"client":@"2",
                             };
    [HttpTool postWithPath:@"ting/radio_detail" params:params success:^(id JSON) {
        
        NSDictionary *dataDic = JSON[@"data"];
        
        NSMutableArray *array = [RadioSecondListModel mj_objectArrayWithKeyValuesArray:dataDic[@"list"]];
        [self.tableViewSource addObjectsFromArray:array];
        
        [self.radioTableView reloadData];
        [self.radioTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.radioTableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark -
#pragma mark - 懒加载
- (UITableView *)radioTableView
{
    if (!_radioTableView) {
        _radioTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _radioTableView.delegate = self;
        _radioTableView.dataSource = self;
        _radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _radioTableView;
}

- (NSMutableArray *)TopdataSource
{
    if (!_TopdataSource) {
        _TopdataSource = [NSMutableArray array];
    }
    return _TopdataSource;
}

- (NSMutableArray *)tableViewSource
{
    if (!_tableViewSource) {
        _tableViewSource = [NSMutableArray array];
    }
    return _tableViewSource;
}


@end
