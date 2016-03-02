//
//  PKRefreshFooter.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "PKRefreshFooter.h"

@implementation PKRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i < 28; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏状态
    self.refreshingTitleHidden = YES;
    self.stateLabel.hidden = YES;
}

@end
