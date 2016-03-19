//
//  ReadingViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ReadingViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"
#import "LoadingView.h"
#import "SDCycleScrollView.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "Readcarousel.h"
#import "ReadListModel.h"
#import "ReadPhotoView.h"
#import "PKRefreshHeader.h"
#import "WebViewController.h"
#import "ReadSecondViewController.h"

@interface ReadingViewController ()<SDCycleScrollViewDelegate>
/**
 *  等待页面
 */
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  顶部滚动视图
 */
@property (nonatomic,strong) SDCycleScrollView *SDscrollView;
/**
 *  顶部视图的图片数据模型数组
 */
@property (nonatomic,strong) NSArray *cacheImages;
/**
 *  书本数据模型数组
 */
@property (nonatomic,strong) NSArray *ReadListArray;
/**
 *  放置整体视图的ScrollView
 */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/**
 *  底部的写作按钮
 */
@property (nonatomic,strong) UIButton *bottomButton;


@end

@implementation ReadingViewController


#pragma mark - 
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    
    [self.view addSubview:self.mainScrollView];
    //设置顶部滚动视图
    [self setupTopView];
    
    //发送网络请求
    [self setupURLRequest];
    
    //添加等待动画
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.view];
    
    //设置下拉刷新控件
    self.mainScrollView.mj_header = [PKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}


#pragma mark -
#pragma mark - 发送网络请求
- (void)setupURLRequest
{
    [HttpTool getWithPath:@"http://api2.pianke.me/read/columns" params:nil success:^(id JSON) {
        
        NSDictionary *dataDic = JSON[@"data"];
        //顶部滚动视图的数据模型
        self.cacheImages = [Readcarousel mj_objectArrayWithKeyValuesArray:dataDic[@"carousel"]];
        //书本的数据模型
        self.ReadListArray = [ReadListModel mj_objectArrayWithKeyValuesArray:dataDic[@"list"]];
        
        //给轮播器设置数据
        NSMutableArray *imgs = [NSMutableArray array];
        for (Readcarousel *temp in self.cacheImages) {
            [imgs addObject:temp.img];
        }
        self.SDscrollView.imageURLStringsGroup = imgs;
        
        [self setupNinePhotoView];
        
        [self.waitView dismiss];
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.waitView dismiss];
    }];
}


#pragma mark - 
#pragma mark - 下拉刷新方法
- (void)loadNewData
{
    [self setupURLRequest];
    [self.mainScrollView.mj_header endRefreshing];
}


#pragma mark -
#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"阅读" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - 
#pragma mark - 设置顶部视图
- (void)setupTopView
{
    //设置顶部轮播器
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,180)];
    scrollView.delegate = self;
    self.SDscrollView = scrollView;
    //设置分页位置
    self.SDscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //设置时间间隔
    self.SDscrollView.autoScrollTimeInterval = 3.0;
    //设置当前分页圆点颜色
    self.SDscrollView.currentPageDotColor = [UIColor whiteColor];
    //设置其它分页圆点颜色
    self.SDscrollView.pageDotColor = [UIColor lightGrayColor];
    //设置动画样式
    self.SDscrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.SDscrollView.backgroundColor = [UIColor lightGrayColor];
    
    [self.mainScrollView addSubview:self.SDscrollView];
}


#pragma mark - 轮播器方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    Readcarousel *model = self.cacheImages[index];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = model.url;
    
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - 
#pragma mark - 设置内容图片
- (void)setupNinePhotoView
{
    CGFloat padding = 5;
    CGFloat photoW = (SCREENWIDTH - 20) / 3;
    CGFloat photoH = photoW;
    NSUInteger index = 0;
    for (ReadListModel *model  in self.ReadListArray) {
        ReadPhotoView *photoView = [[ReadPhotoView alloc] init];
        photoView.coverimg = model.coverimg;
        photoView.name = model.name;
        photoView.enname = model.enname;
        photoView.userInteractionEnabled = YES;
        photoView.tag = index;
        [self.mainScrollView addSubview:photoView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToNextVC:)];
        [photoView addGestureRecognizer:tap];
        
        if (index == 10) {
            CGFloat photobigX = padding;
            CGFloat photobigY = 180 + 4 * padding + 3 * photoH;
            CGFloat photobigW = SCREENWIDTH - 2 * padding;
            CGFloat photobigH = photoH;
            photoView.frame = CGRectMake(photobigX, photobigY, photobigW, photobigH);
        }
        
        //设置frame
        CGFloat photoX = (index % 3) * (photoW + padding) + padding;
        CGFloat photoY = (index / 3) * (photoH + padding) + 180 + padding;
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
        
        index += 1;
    }
    CGFloat contentSizeH = 180 + 4 * photoH + 5 * padding;
    self.mainScrollView.contentSize = CGSizeMake(0,contentSizeH);
    
    [self.mainScrollView addSubview:self.bottomButton];
    self.bottomButton.frame = CGRectMake(padding, contentSizeH - photoH - padding, SCREENWIDTH - 2*padding, (SCREENWIDTH - 20) / 3);
}


#pragma mark - 跳转到二级页面
- (void)GoToNextVC:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    ReadListModel *model;
    ReadSecondViewController *secondVC = [[ReadSecondViewController alloc] init];
    if (index == 10) {
        model = self.ReadListArray[0];
        secondVC.typeID = [NSString stringWithFormat:@"%ld",model.type];
    }else{
    model = self.ReadListArray[index];
    secondVC.typeID = [NSString stringWithFormat:@"%ld",model.type];
    }
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark -
#pragma mark - 懒加载
- (NSArray *)cacheImages
{
    if (!_cacheImages) {
        _cacheImages = [NSArray array];
    }
    return _cacheImages;
}


- (NSArray *)ReadListArray
{
    if (!_ReadListArray) {
        _ReadListArray = [NSArray array];
    }
    return _ReadListArray;
}


- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = [UIScreen mainScreen].bounds;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollView;
}


- (UIButton *)bottomButton
{
    
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] init];
        [_bottomButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        _bottomButton.contentMode = UIViewContentModeScaleAspectFill;
        _bottomButton.adjustsImageWhenHighlighted = NO;
    }
    return _bottomButton;
}

@end
