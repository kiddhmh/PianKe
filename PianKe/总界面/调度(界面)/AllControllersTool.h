//
//  AllControllersTool.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//
//调度管理工具
#import <Foundation/Foundation.h>

@interface AllControllersTool : NSObject

/**
 *  决定究竟加载哪个界面(唯一调用此类的入口)
 *
 *  @param index 控制器的序列号
 */
+ (void)createViewControllerWithIndex:(NSUInteger)index;

@end
