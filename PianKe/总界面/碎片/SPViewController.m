//
//  SPViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SPViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIBarButtonItem+Helper.h"
#import "HttpTool.h"
#import "HttpRequestMacro.h"
#import "MJExtension.h"
#import "SPTableView.h"
#import "ListModel.h"
#import "SVProgressHUD.h"
#import "ListModelFrame.h"
#import "LoadingView.h"
#import "PKRefreshHeader.h"
#import "PKRefreshFooter.h"
#import "SPXQViewController.h"

@interface SPViewController ()

@property (nonatomic,strong) SPTableView *spTableView;
/**
 *  数组模型数组
 */
@property (nonatomic,strong) NSArray *listModelFrameArray;
/**
 *  等待页面
 */
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  当前加载的内容数量
 */
@property (nonatomic,assign) NSUInteger limitNumber;

@end

@implementation SPViewController


#pragma mark -
#pragma markr - 懒加载
- (SPTableView *)spTableView
{
    if (!_spTableView) {
        _spTableView = [[SPTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _spTableView;
}


- (NSArray *)listModelFrameArray
{
    if (!_listModelFrameArray) {
        _listModelFrameArray = [NSArray array];
    }
    return _listModelFrameArray;
}


#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self.view addSubview:self.spTableView];
    
    [self enterSecondViewController];
    
    //加载网络请求，分析数据
    [self setupHttpRequest:0];
    
    //添加等待页面
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.spTableView];
    
    //添加下拉，上拉刷新
    self.spTableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.spTableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark -
#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"碎片" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -
#pragma mark - 发送网络请求
- (void)setupHttpRequest:(NSUInteger)startNumber
{
    NSDictionary *param = @{
                            @"auth" : @"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                            @"client" : @"1",
                            @"deviceid" : @"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                            @"limit" : @"10",
                            @"start" : @(startNumber),
                            @"version":@"3.0.6"
                            };
    [HttpTool postWithPath:@"timeline/list" params:param success:^(id JSON) {
        [self test];
        NSDictionary *dataDic = JSON[@"data"];
        NSDictionary *listDic = dataDic[@"list"];
        NSArray *listModel = [ListModel mj_objectArrayWithKeyValuesArray:listDic];
        
        //将数据模型转换成frame模型
        self.listModelFrameArray = [self listFrameWithListModel:listModel];
        
        self.spTableView.FrameArray = self.listModelFrameArray;
        
        [self.spTableView reloadData];
        [self.waitView dismiss];
        self.limitNumber = self.listModelFrameArray.count;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.waitView dismiss];
    }];
}


#pragma mark -
#pragma mark - 下拉刷新方法
- (void)loadNewData
{
    //加载最新的数据
    NSDictionary *param = @{
                            @"auth" : @"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                            @"client" : @"1",
                            @"deviceid" : @"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                            @"limit" : @"10",
                            @"start" : @0,
                            @"version":@"3.0.6"
                            };
    [HttpTool postWithPath:@"timeline/list" params:param success:^(id JSON) {
        [self test];
        NSDictionary *dataDic = JSON[@"data"];
        NSDictionary *listDic = dataDic[@"list"];
        NSArray *listModel = [ListModel mj_objectArrayWithKeyValuesArray:listDic];
        
        //将数据模型转换成frame模型
        NSArray *newListFrame = [self listFrameWithListModel:listModel];
        
        //先取出数组最前的10个数据
        NSArray *OldListFrame = [self.listModelFrameArray subarrayWithRange:NSMakeRange(0, 10)];
        //进行比较
        NSArray *resultArray = [self array:newListFrame With:OldListFrame];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.listModelFrameArray];
        [tempArray replaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:resultArray];
        self.listModelFrameArray = tempArray;

        self.spTableView.FrameArray = self.listModelFrameArray;
        
        [self.spTableView reloadData];
        [self.spTableView.mj_header endRefreshing];
        self.limitNumber = self.listModelFrameArray.count;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.spTableView.mj_header endRefreshing];
    }];
}



#pragma mak -
#pragma mark - 上拉加载更多方法
- (void)loadMoreData
{
    self.limitNumber += 10;
    //往后加载十条数据
    NSDictionary *param = @{
                            @"auth" : @"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                            @"client" : @"1",
                            @"deviceid" : @"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                            @"limit" : @"10",
                            @"start" : @(self.limitNumber),
                            @"version":@"3.0.6"
                            };
    [HttpTool postWithPath:@"timeline/list" params:param success:^(id JSON) {
        [self test];
        NSDictionary *dataDic = JSON[@"data"];
        NSDictionary *listDic = dataDic[@"list"];
        NSArray *listModel = [ListModel mj_objectArrayWithKeyValuesArray:listDic];
        
        //将数据模型转换成frame模型
        NSArray *oldArray = [self listFrameWithListModel:listModel];
        
        //将加载的之前的数据放到数组的后面
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.listModelFrameArray];
        [temp addObjectsFromArray:oldArray];
        self.listModelFrameArray = temp;
        
        self.spTableView.FrameArray = self.listModelFrameArray;
        
        [self.spTableView reloadData];
        [self.spTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.spTableView.mj_footer endRefreshing];
    }];
}


/**
 *   将传递进来的数组转换成Frame数组
 */
- (NSArray *)listFrameWithListModel:(NSArray *)listModelArray
{
    NSMutableArray *frames = [NSMutableArray array];
    for (ListModel *model in listModelArray) {
        ListModelFrame *frame = [[ListModelFrame alloc] init];
        frame.listM = model;
        [frames addObject:frame];
    }
    return frames;
}


/**
 *  比较新旧数据，返回新数组
 */
- (NSArray *)array:(NSArray *)firstArray With:(NSArray *)secondArray
{
    NSMutableArray *first = [NSMutableArray arrayWithArray:firstArray];
    NSMutableArray *second = [NSMutableArray arrayWithArray:secondArray];
    for (int i = 0; i < second.count ; i++) {
        ListModelFrame *frame = second[i];
        for (ListModelFrame *temp in first) {
            if ([frame.listM.content isEqualToString:temp.listM.content] && [frame.listM.coverimg  isEqualToString:temp.listM.coverimg]) {
                [second removeObject:frame];
            }
        }
    }
    [first addObjectsFromArray:second];
    return first;
}


#pragma mark - 
#pragma mark - 点击对应的cell进入详情视图方法
- (void)enterSecondViewController
{
    __weak typeof(self)vc= self;
    self.spTableView.enterBlock = ^(ListModelFrame *listFrameModel){
        SPXQViewController *spxqVC = [[SPXQViewController alloc] init];
        [vc.navigationController pushViewController:spxqVC animated:YES];
        ListModel *model = listFrameModel.listM;
        [spxqVC passListModel:model];
    };
}

- (void)test
{
    //1.把JSON保存到Model当中
    //2.根据JSON返回的数据计算每一行行高，并保存到数组
    //数组元素是CGFloat
    //3.根据JSON数据计算每一行的内容，保存到数组
    //数组元素是SPListModel
    //4.给cell提供加载内容的所有数据的模型
    //5.在Controller层当中，把数据处理完毕，送给View
    //在View（tableView）应该是[自定义类型]
}

@end
