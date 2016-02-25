//
//  AllControllersTool.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "AllControllersTool.h"
#import "GoodPorductsViewController.h"

@implementation AllControllersTool

#pragma mark -
#pragma mark - 调度方法
+ (void)createViewControllerWithIndex:(NSUInteger)index
{
    //获取当前类的(唯一)对象
    AllControllersTool *dispatchTool = [AllControllersTool shareOpenController];
    
    //用当前类的对象 执行实际选择执行的方法
    [dispatchTool openViewControllerWithIndex:index];
}


+ (instancetype)shareOpenController
{
    //获取到调度的唯一对象
    static AllControllersTool *tempTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempTool = [[AllControllersTool alloc] init];
    });
    
    return tempTool;
}


#pragma mark -
#pragma mark - 实际选择执行的方法
- (void)openViewControllerWithIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
            //第一次加载，加载[良品]界面
            
            break;
        case 1:
            //第一次加载，加载[]界面
            break;
        case 2:
            //第一次加载，加载[]界面
            break;
        
        default:
            break;
    }
    
    
}


@end
