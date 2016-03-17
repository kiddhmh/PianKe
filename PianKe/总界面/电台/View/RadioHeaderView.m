//
//  RadioHeaderView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioHeaderView.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "RadioCarousel.h"
#import "RadioHostList.h"

@interface RadioHeaderView ()<SDCycleScrollViewDelegate>
/**
 *  顶部的轮播器
 */
@property (nonatomic,strong) SDCycleScrollView *SDscrollView;
/**
 *  顶部轮播器的数据
 */
@property (nonatomic,strong) NSMutableArray *SDImages;


@end

@implementation RadioHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
    }
    return self;
}


- (void)setupSubView
{
    //创建顶部的图片轮播器
    [self setupTopView];
    
    //创建下方的最热专辑
    CGFloat margin = Margin;
    CGFloat btnW = HotImageW;
    CGFloat btnH = btnW;
    for (int i = 0; i < 3; i ++) {
        CGFloat btnX = margin + (margin + btnW) * i;
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(btnX, 180 + margin, btnW, btnH);
        imgView.tag = 100 + i;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
    }
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
    
    [self addSubview:self.SDscrollView];
}



#pragma mark - 进行设置数据
- (void)setListArray:(NSMutableArray *)listArray
{
    _listArray = listArray;
    //设置顶部轮播器的图片数据
    NSMutableArray *topListArray = [listArray objectAtIndex:0];
    for (RadioCarousel *carousel in topListArray) {
        NSString *img = carousel.img;
        [self.SDImages addObject:img];
    }
    
    self.SDscrollView.imageURLStringsGroup = self.SDImages;
    
    
    //设置下方最热专辑的数据
    NSMutableArray *hotArray = [listArray objectAtIndex:1];
    for (int i = 0; i < 3; i ++) {
        RadioHostList *list = hotArray[i];
        NSString *img = list.coverimg;
        UIImageView *imgView = [self viewWithTag:(100 + i)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
}


#pragma mark - 轮播器代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSMutableArray *topListArray = self.listArray[0];
    RadioCarousel *model = topListArray[index];
    self.block(model.url);
}


#pragma mark - 懒加载
- (NSMutableArray *)SDImages
{
    if (!_SDImages) {
        _SDImages = [NSMutableArray array];
    }
    return _SDImages;
}

@end
