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
#import "LoadingView.h"
#import "HttpRequestMacro.h"
#import "HttpTool.h"
#import "SVProgressHUD.h"
#import "LPRootModel.h"
#import "LPListModel.h"
#import "LPDataModel.h"
#import "LPRootTableViewCell.h"
#import "PKRefreshFooter.h"
#import "PKRefreshHeader.h"

@interface LPViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  LoadingView
 */
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  表格视图
 */
@property (nonatomic,strong) UITableView *tableView;
/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *mutableArray;
/**
 *  每次请求数据的个数
 */

@end

@implementation LPViewController


#pragma mark - 
#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.tableView];
    }
    return self;
}

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    
    //发起网络请求
    [self sendHttpRequest];
    
    //显示LoadingView（网络请求完毕后移除LoadingView）
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.tableView];
    
    //添加下拉刷新
    self.tableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉加载更多
    self.tableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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


#pragma mark - 
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

               
#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    LPRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LPRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //加载表格数据
    //让表格自己加载数据，在Controller只需要把模型传给cell即可。
    [cell loadDataWith:self.mutableArray[indexPath.row]];
    
    return cell;
}


#pragma mark - 
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}


#pragma mark - 
#pragma mark - 调用方法
/**
 *  发送网络请求，获取数据
 */
- (void)sendHttpRequest
{
    /*
     **param
     @"start" : 从第几条数据开始加载
     @"limit" : 一次请求获取多少条数据
     @"client" : 服务器配置代码
    */
    NSDictionary *param = @{
                            @"start" : @0,
                            @"limit" : @10,
                            @"client" : @2
                            };
    //发起网络请求
    [HttpTool getWithPath:HTTP_PRODUCTS params:param success:^(id JSON)
    {
        LPRootModel *rootModel = [[LPRootModel alloc] initWithDictionary:JSON];
        //表格数据
        self.mutableArray = [[NSMutableArray alloc] initWithArray:rootModel.data.list];
        
        //刷新表格
        [self.tableView reloadData];
        //移除Loading界面
        [self.waitView dismiss];
    } failure:^(NSError *error)
    {
        
        //显示错误信息，移除LoadingView
        [SVProgressHUD showErrorWithStatus:@"网络不给力,稍后再试"];
        [self.waitView dismiss];
    }];
}



/**
 *  下拉刷新最新数据
 */
- (void)loadNewData
{
    NSLog(@"刷新数据中");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}



/**
 *  上拉加载更多数据
 */
- (void)loadMoreData
{
    NSLog(@"加载更多数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}


- (void)addRefreshControl
{
    //添加下拉刷新和上拉提取
    
}


@end

