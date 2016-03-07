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
#import "LPXQViewController.h"

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
@property (nonatomic,assign) NSInteger limitNumber;
/**
 *  良品ID数组
 */
@property (nonatomic,strong) NSMutableArray *idmutableArray;

@end

@implementation LPViewController


#pragma mark -
#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.tableView];
        self.idmutableArray = [NSMutableArray array];
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
    
    //添加上拉加载更多
    self.tableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark -
#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    [leftItem setTintColor:[UIColor blackColor]];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"良品" target:nil action:nil];
    [titleItem setTintColor:[UIColor blackColor]];
    
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
//点击表格进入详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //在这里进入良品详情界面
    NSString *selectID = self.idmutableArray[indexPath.row];
    LPXQViewController *lpxqVC = [[LPXQViewController alloc] init];
    
    //将商品id传递到下个界面
    [lpxqVC initWithId:selectID];
    [self.navigationController pushViewController:lpxqVC animated:YES];
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
         
         //获取良品id数据
         for (LPListModel *model in rootModel.data.list) {
             NSString *contentID = model.contentid;
             [self.idmutableArray addObject:contentID];
         }
         
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
         NSArray *newArray = [[NSMutableArray alloc] initWithArray:rootModel.data.list];
         
         //先取出数组中最前面的数据，进行比较，相同的就不用添加进数组
         NSArray *oldArray = [self.mutableArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)]];
         NSMutableArray *newnewArray = [self array:oldArray With:newArray];
         [self.mutableArray replaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:newnewArray];
         
         //获取良品id数据
         NSMutableArray *newIDArray = [NSMutableArray array];
         for (LPListModel *model in newnewArray) {
             NSString *contentID = model.contentid;
             [newIDArray addObject:contentID];
         }
         [self.idmutableArray replaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:newIDArray];
         
         
         //刷新表格
         [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
         
         //移除Loading界面
         [self.waitView dismiss];
     } failure:^(NSError *error)
     {
         //显示错误信息，移除LoadingView
         [SVProgressHUD showErrorWithStatus:@"网络不给力,稍后再试"];
         [self.tableView.mj_header endRefreshing];
         [self.waitView dismiss];
     }];
}



/**
 *  上拉加载更多数据
 */
- (void)loadMoreData
{
    //添加下拉刷新和上拉提取(start变为10，往后加载10条数据)
    /*
     **param
     @"start" : 从第几条数据开始加载
     @"limit" : 一次请求获取多少条数据
     @"client" : 服务器配置代码
     */
    self.limitNumber += 10;
    NSDictionary *param = @{
                            @"start" : @(self.limitNumber),
                            @"limit" : @10,
                            @"client" : @2,
                            };
    
    //发起网络请求
    [HttpTool getWithPath:HTTP_PRODUCTS params:param success:^(id JSON)
     {
         LPRootModel *rootModel = [[LPRootModel alloc] initWithDictionary:JSON];
         //表格数据
         NSArray *oldArray = [[NSMutableArray alloc] initWithArray:rootModel.data.list];
         
         //将旧数据插到数据数组的后面
         [self.mutableArray addObjectsFromArray:oldArray];
         
         //获取良品id数据
         NSMutableArray *oldIdArray = [NSMutableArray array];
         for (LPListModel *model in rootModel.data.list) {
             NSString *contentID = model.contentid;
             [oldIdArray addObject:contentID];
         }
         [self.idmutableArray addObjectsFromArray:oldIdArray];
         
         //刷新表格
         [self.tableView reloadData];
         
         //移除Loading界面
         [self.waitView dismiss];
         [self.tableView.mj_footer endRefreshing];
     } failure:^(NSError *error)
     {
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
         [self.tableView.mj_footer endRefreshing];
         [self.waitView dismiss];
     }];
    
}



- (NSMutableArray *)array:(NSArray *)firstArray With:(NSArray *)secondArray
{
    NSMutableArray *first = [NSMutableArray arrayWithArray:firstArray];
    NSMutableArray *second = [NSMutableArray arrayWithArray:secondArray];
    for (int i = 0; i < second.count ; i++) {
        LPListModel *listM = second[i];
        for (LPListModel *temp in first) {
            if ([listM.contentid isEqualToString:temp.contentid]) {
                [second removeObject:listM];
            }
        }
    }
    [first addObjectsFromArray:second];
    return first;
}


@end

