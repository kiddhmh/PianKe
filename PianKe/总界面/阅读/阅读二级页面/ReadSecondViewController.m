//
//  ReadSecondViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ReadSecondViewController.h"
#import "ReadSecondCell.h"
#import "HttpTool.h"
#import "UIBarButtonItem+Helper.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "LoadingView.h"
#import "ReadSecondListModel.h"
#import "PKRefreshFooter.h"
#import "PKRefreshHeader.h"

@interface ReadSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *readSecondTableView;
/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *dataSource;
/**
 *  标题
 */
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) LoadingView *waitView;
@property (nonatomic,assign) NSInteger total;
@end

@implementation ReadSecondViewController

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.readSecondTableView];
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.backBarButtonItem = backItem;
    
    self.readSecondTableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.readSecondTableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //发送网络请求
    [self creatURLRequest:@"addtime"];
    
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.readSecondTableView];
    self.total = 0;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 网络请求
- (void)creatURLRequest:(NSString *)sort
{
    NSDictionary *params = @{
                             @"client" : @"1",
                             @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                             @"limit" : @10,
                             @"sort" : sort,
                             @"start" : @0,
                             @"typeid" : self.typeID,
                             @"version" : @"3.0.6"
                             };
    [HttpTool postWithPath:@"http://api2.pianke.me/read/columns_detail" params:params success:^(id JSON) {
        NSDictionary *dic = JSON[@"data"];
        self.dataSource = [ReadSecondListModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        
        [self.readSecondTableView reloadData];
        [self.waitView dismiss];
        self.total = 0;
        [self.readSecondTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.waitView dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.readSecondTableView.mj_header endRefreshing];
    }];
    
}


#pragma mark - 下拉刷新
- (void)loadNewData
{
    [self.dataSource removeAllObjects];
    [self creatURLRequest:@"addtime"];
}


#pragma mark - 上拉加载更多
- (void)loadMoreData
{
    self.total += 10;
    NSDictionary *params = @{
                             @"client" : @"1",
                             @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                             @"limit" : @10,
                             @"sort" : @"addtime",
                             @"start" : @(self.total),
                             @"typeid" : self.typeID,
                             @"version" : @"3.0.6"
                             };
    [HttpTool postWithPath:@"http://api2.pianke.me/read/columns_detail" params:params success:^(id JSON) {
        NSDictionary *dic = JSON[@"data"];
         NSMutableArray *array = [ReadSecondListModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        [self.dataSource addObjectsFromArray:array];
        
        [self.readSecondTableView reloadData];
        [self.waitView dismiss];
        [self.readSecondTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.waitView dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.readSecondTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadSecondCell *cell = [ReadSecondCell cellWithTableView:tableView];
    cell.listModel = self.dataSource[indexPath.row];
    return cell;
}


#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


#pragma mark -
#pragma mark - 懒加载
- (UITableView *)readSecondTableView
{
    if (!_readSecondTableView) {
        _readSecondTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _readSecondTableView.delegate = self;
        _readSecondTableView.dataSource = self;
        _readSecondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _readSecondTableView;
}

@end
