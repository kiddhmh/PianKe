//
//  SQViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "SQHeaderView.h"
#import "HttpRequestMacro.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "SQHotListFrameModel.h"
#import "SQHotListModel.h"
#import "SVProgressHUD.h"
#import "LoadingView.h"
#import "SQHotTableView.h"
#import "PKRefreshHeader.h"
#import "PKRefreshFooter.h"
#import "SQSecondViewController.h"

@interface SQViewController ()<SQHeaderDelegate>
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  头部的分段控制器
 */
@property (nonatomic,strong) SQHeaderView *sqHeaderView;
/**
 *  存放数据的数组
 */
@property (nonatomic,strong) NSArray *hotListFrames;
/**
 *  存放数据的UITableView
 */
@property (nonatomic,strong) SQHotTableView *hotTableView;
/**
 *  当前加载的内容数量
 */
@property (nonatomic,assign) NSUInteger limitNumber;
/**
 *  当前选中的分段控制器位置
 */
@property (nonatomic,assign) NSUInteger FirstSelected;
@end

@implementation SQViewController


#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self.view addSubview:self.hotTableView];
    [self.view addSubview:self.sqHeaderView];
    self.FirstSelected = 0;
    
    [self.waitView showLoadingTo:self.hotTableView];
    
    self.hotTableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.hotTableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    __weak typeof(self)vc = self;
    self.hotTableView.block = ^(SQHotListModel *listModel){
        SQSecondViewController *sqSecondVC = [[SQSecondViewController alloc] init];
        sqSecondVC.hotList = listModel;
        [vc.navigationController pushViewController:sqSecondVC animated:YES];
    };
    
    [self setupHttpRequest:@"hot"];
}


#pragma mark - 发送网络请求
- (void)setupHttpRequest:(NSString *)sort
{
    self.hotListFrames = nil;
    
    NSDictionary *param = @{
                            @"client" : @"1",
                            @"limit" : @"10",
                            @"start" : @0,
                            @"sort" : sort,
                            @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                            @"version" : @"3.0.6"
                            };
    [HttpTool getWithPath:@"http://api2.pianke.me/group/posts_hotlist" params:param success:^(id JSON) {
        
        NSDictionary *dicData = JSON[@"data"];
        NSMutableArray *hostList = [SQHotListModel mj_objectArrayWithKeyValuesArray:dicData[@"list"]];
        self.hotListFrames = [self listFrameWithListModel:hostList];
        self.hotTableView.FrameArray = self.hotListFrames;
        
        [self.hotTableView reloadData];
        [self.waitView dismiss];
        self.limitNumber = self.hotListFrames.count;
    } failure:^(NSError *error) {
        [self.waitView dismiss];
        [self.hotTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
    }];
}


#pragma mark -
#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"社区" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -
#pragma mark - 懒加载
- (SQHeaderView *)sqHeaderView
{
    if (!_sqHeaderView) {
        _sqHeaderView = [[SQHeaderView alloc] initWithFrame:CGRectMake(0,64, SCREENWIDTH, 45)];
        _sqHeaderView.delegate = self;
    }
    return _sqHeaderView;
}

- (NSArray *)hotListFrames
{
    if (!_hotListFrames) {
        _hotListFrames = [NSArray array];
    }
    return _hotListFrames;
}

- (SQHotTableView *)hotTableView
{
    if (!_hotTableView) {
        _hotTableView = [[SQHotTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _hotTableView.contentInset = UIEdgeInsetsMake(55, 0, 0, 0);
    }
    return _hotTableView;
}

- (LoadingView *)waitView
{
    if (!_waitView) {
        _waitView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    }
    return _waitView;
}

/**
 *   将传递进来的数组转换成Frame数组
 */
- (NSArray *)listFrameWithListModel:(NSArray *)listModelArray
{
    NSMutableArray *frames = [NSMutableArray array];
    for (SQHotListModel *model in listModelArray) {
        SQHotListFrameModel *frame = [[SQHotListFrameModel alloc] init];
        frame.hotListModel = model;
        [frames addObject:frame];
    }
    return frames;
}


#pragma mark -
#pragma mark - 下拉刷新方法
- (void)loadNewData
{
    //加载最新的数据
    NSDictionary *param = @{
                            @"client" : @"1",
                            @"limit" : @"10",
                            @"start" : @0,
                            @"sort" : @"hot",
                            @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                            @"version" : @"3.0.6"
                            };
    [HttpTool getWithPath:@"http://api2.pianke.me/group/posts_hotlist" params:param success:^(id JSON) {
        NSDictionary *dicData = JSON[@"data"];
        NSMutableArray *hostList = [SQHotListModel mj_objectArrayWithKeyValuesArray:dicData[@"list"]];
        
        //将数据模型转换成frame模型
        NSArray *newListFrame = [self listFrameWithListModel:hostList];
        
        //先取出数组最前的10个数据

        if (self.hotListFrames.count != 0) {
            NSArray *OldListFrame = [self.hotListFrames subarrayWithRange:NSMakeRange(0, 10)];
            //进行比较
            NSArray *resultArray = [self array:newListFrame With:OldListFrame];
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.hotListFrames];
            [tempArray replaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:resultArray];
        }
        self.hotListFrames = newListFrame;
        
        self.hotTableView.FrameArray = self.hotListFrames;
        
        [self.hotTableView reloadData];
        [self.hotTableView.mj_header endRefreshing];
        self.limitNumber = self.hotListFrames.count;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.hotTableView.mj_header endRefreshing];
    }];
}



#pragma mak -
#pragma mark - 上拉加载更多方法
- (void)loadMoreData
{
    self.limitNumber += 10;
    //往后加载十条数据
    NSDictionary *param = @{
                            @"client" : @"1",
                            @"limit" : @"10",
                            @"start" : @(self.limitNumber),
                            @"sort" : @"hot",
                            @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                            @"version" : @"3.0.6"
                            };
    [HttpTool getWithPath:@"http://api2.pianke.me/group/posts_hotlist" params:param success:^(id JSON) {
        NSDictionary *dicData = JSON[@"data"];
        NSMutableArray *hostList = [SQHotListModel mj_objectArrayWithKeyValuesArray:dicData[@"list"]];
        
        //将数据模型转换成frame模型
        NSArray *oldArray = [self listFrameWithListModel:hostList];
        
        //将加载的之前的数据放到数组的后面
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.hotListFrames];
        [temp addObjectsFromArray:oldArray];
        self.hotListFrames = temp;
        
        self.hotTableView.FrameArray = self.hotListFrames;
        
        [self.hotTableView reloadData];
        [self.hotTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.hotTableView.mj_footer endRefreshing];
    }];
}


/**
 *  比较新旧数据，返回新数组
 */
- (NSArray *)array:(NSArray *)firstArray With:(NSArray *)secondArray
{
    NSMutableArray *first = [NSMutableArray arrayWithArray:firstArray];
    NSMutableArray *second = [NSMutableArray arrayWithArray:secondArray];
    for (int i = 0; i < second.count ; i++) {
        SQHotListFrameModel *frame = second[i];
        for (SQHotListFrameModel *temp in first) {
            if ([frame.hotListModel.content isEqualToString:temp.hotListModel.content] && [frame.hotListModel.coverimg  isEqualToString:temp.hotListModel.coverimg]) {
                [second removeObject:frame];
            }
        }
    }
    [first addObjectsFromArray:second];
    return first;
}


#pragma mark - 
#pragma mark - 头部的分段控制器的代理方法
- (void)sqHeaderDidSelectedSegmentIndex:(NSInteger)index SegmentControl:(UISegmentedControl *)segmentControl
{
    if (index == self.FirstSelected) return;
    if (index == 0) {
        if ([self.hotTableView.mj_header isRefreshing]) return;
        [self.hotTableView.mj_header beginRefreshing];
        [self setupHttpRequest:@"hot"];
        self.FirstSelected = 0;
    }else if (index == 1){
        if ([self.hotTableView.mj_header isRefreshing]) return;
        [self.hotTableView.mj_header beginRefreshing];
        [self setupHttpRequest:@"addtime"];
        self.FirstSelected = 1;
    }

}


@end
