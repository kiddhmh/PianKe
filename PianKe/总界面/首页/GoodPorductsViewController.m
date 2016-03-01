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
@interface GoodPorductsViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate>
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

@end

@implementation GoodPorductsViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"首页" target:nil action:nil];
                                       
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView = tableView;
    
    //发送网络请求
    [self setupURL];
    
    //设置顶部轮播器
   SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
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
    
    //设置下拉刷新
    self.tableView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)loadNewData
{
    NSLog(@"刷新数据中");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark -
#pragma mark - 发送网络请求获取数据
- (void)setupURL
{
    [HttpTool getWithPath:@"http://api2.pianke.me/pub/today" params:nil success:^(id JSON) {
        
        NSDictionary *dicData = [JSON objectForKey:@"data"];
        NSDictionary *diccarousel = [dicData objectForKey:@"carousel"];
        
        self.carouselImages = [Carousel mj_objectArrayWithKeyValuesArray:diccarousel];

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
        
        //给轮播器设置数据
        for (Carousel *temp in self.carouselImages) {
            [self.cacheImages addObject:temp.img];
        }
        
        self.scrollView.imageURLStringsGroup = self.cacheImages;
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
    }];
}

#pragma mark -
#pragma mark - 轮播器代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击第%ld张图片",index);
}



@end
