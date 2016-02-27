//
//  PianKeRefreshHeader.m
//  片刻下拉刷新
//
//  Created by ma c on 16/2/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "PianKeRefreshHeader.h"

@interface PianKeRefreshHeader ()

///刷新动画图片
@property (nonatomic,strong) UIImageView *refreshView;

/**
 *  刷新动画数组
 */
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation PianKeRefreshHeader

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

#pragma mark - 重写方法
#pragma mark - 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    //添加刷新图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.refreshView = imageView;
    
    for (int i = 0; i < 29; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
        [self.array addObject:image];
    }
}


#pragma mark - 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.refreshView.bounds = CGRectMake(0, 0,114, 38);
    self.refreshView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}


#pragma mark - 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}


#pragma mark - 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}


#pragma mark - 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}


#pragma mark - 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.refreshView setImage:[UIImage imageNamed:@"loading"]];
            break;
        case MJRefreshStatePulling:
            [self.refreshView setImage:[UIImage imageNamed:@"pullRefresh"]];
            break;
        case MJRefreshStateRefreshing:
            [self beginAnimation];
            break;
        default:
            break;
    }
}


- (void)beginAnimation
{
//    self.refreshView.animationImages = self.array;
//    self.refreshView.animationDuration = 3.0;
//    self.refreshView.animationRepeatCount = 0;
//    [self.refreshView startAnimating];
}


#pragma mark - 监听拖拽比例 （控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}


@end
