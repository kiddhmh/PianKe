//
//  GoodPorductsViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "GoodPorductsViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "HttpTool.h"
#import "SVProgressHUD.h"
#import "Carousel.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "PKRefreshHeader.h"
#import "UIBarButtonItem+Helper.h"
#import "PKRefreshFooter.h"
#import "list.h"
#import "SYBaeTableViewCell.h"
#import "Masonry.h"
#import "LoadingView.h"
#import "WebViewController.h"
#import "SYSecondViewController.h"

@interface GoodPorductsViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
/**
 *  首页顶部轮播器图片模型数组
 */
@property (nonatomic,strong) NSArray *carouselImages;
/**
 *  图片数组
 */
@property (nonatomic,strong) NSMutableArray *cacheImages;
/**
 *  轮播器
 */
@property (nonatomic,strong) SDCycleScrollView *scrollView;
/**
 *  tableView
 */
@property (nonatomic,strong) UITableView *tableView;
/**
 *  数据模型数组
 */
@property (nonatomic,strong) NSMutableArray *listArray;
/**
 *  等待页面
 */
@property (nonatomic,strong) LoadingView *waitView;

@end

@implementation GoodPorductsViewController

#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)cacheImages
{
    if (!_cacheImages) {
        _cacheImages = [[NSMutableArray alloc] init];
    }
    return _cacheImages;
}

- (NSArray *)carouselImages
{
    if (!_carouselImages) {
        _carouselImages = [[NSArray alloc] init];
    }
    return _carouselImages;
}


- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorColor = [UIColor clearColor];
    }
    
    return _tableView;
}

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    //设置导航栏按钮
    [self setupNavItem];
    
    //发送网络请求
    [self setupURL];
    
    //设置顶部轮播器
    [self setupImageAction];
    
    //设置下拉刷新
    self.tableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //设置上拉加载更多
    self.tableView.mj_footer = [PKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //显示等待页面
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.tableView];
}



#pragma mark - 
#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    NSString *title = [[NSUserDefaults standardUserDefaults] objectForKey:@"today"];
    MMDrawerBarButtonItem *titleItem;
    if (title) {
        titleItem = [MMDrawerBarButtonItem itemWithTitle:title target:nil action:nil];
    }else{
        titleItem = [MMDrawerBarButtonItem itemWithTitle:@"首页" target:nil action:nil];
    }
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -
#pragma mark - 刷新数据
- (void)loadNewData
{
    [self setupURL];
    
}


- (void)loadMoreData
{
    NSLog(@"加载更多数据");
}


#pragma mark -
#pragma mark - 发送网络请求获取数据
- (void)setupURL
{
    [HttpTool getWithPath:@"http://api2.pianke.me/pub/today" params:nil success:^(id JSON) {
        
        NSDictionary *dicData = [JSON objectForKey:@"data"];
        [self saveItemTitle:(dicData[@"date"])];
        
        self.carouselImages = [Carousel mj_objectArrayWithKeyValuesArray:[dicData objectForKey:@"carousel"]];
        self.listArray = [list mj_objectArrayWithKeyValuesArray:[dicData objectForKey:@"list"]];
        
        //给轮播器设置数据
        for (Carousel *temp in self.carouselImages) {
            [self.cacheImages addObject:temp.img];
        }
        
        self.scrollView.imageURLStringsGroup = self.cacheImages;
        
        [self.tableView reloadData];
        [self.waitView dismiss];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.waitView dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - 
#pragma mark - 初始化子控件
- (void)setupImageAction
{
    //设置顶部轮播器
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.3)];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    //设置分页位置
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //设置时间间隔
    self.scrollView.autoScrollTimeInterval = 3.0;
    //设置当前分页圆点颜色
    self.scrollView.currentPageDotColor = [UIColor whiteColor];
    //设置其它分页圆点颜色
    self.scrollView.pageDotColor = [UIColor lightGrayColor];
    //设置动画样式
    self.scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.tableView.tableHeaderView = self.scrollView;
    
    self.tableView.backgroundColor = [UIColor clearColor];
}


#pragma mark -
#pragma mark - 轮播器代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WebViewController *webVC = [[WebViewController alloc] init];
    Carousel *model = self.carouselImages[index];
    webVC.url = model.url;
    [self.navigationController pushViewController:webVC animated:YES];
}



#pragma mark -
#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        SYBaeTableViewCell *cell = nil;
        list *model = self.listArray[indexPath.row];
        NSString *identifier = [SYBaeTableViewCell cellIdentifierForRow:model];
        Class class = NSClassFromString(identifier);
        
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.listModel = model;
        return cell;
}


#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.height * 0.6;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    list *model = self.listArray[indexPath.row];
    SYSecondViewController *secondVC = [[SYSecondViewController alloc] init];
    [secondVC deliverContentidWithString:model.contentid];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - 
#pragma mark - 设置导航条标题
- (void)saveItemTitle:(NSString *)title
{
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"today"];
}


- (void)test
{
    //            //下载图片并存储
    //            for (Carousel *temp in self.carouselImages) {
    //                SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //
    //                [manager downloadImageWithURL:[NSURL URLWithString:temp.img] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    //                    [manager saveImageToCache:image forURL:imageURL];
    //                    [self.cacheImages addObject:image];
    //
    //                    if (self.cacheImages.count == 6) {
    //                       self.scrollView.images = self.cacheImages;
    //                    }
    //                }];
    //            }
}
@end
