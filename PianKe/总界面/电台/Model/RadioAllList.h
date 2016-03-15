//
//  RadioAllList.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RadioUserInfo;
@interface RadioAllList : NSObject
/**
 *  电台编号
 */
@property (nonatomic,copy) NSString *radioid;
/**
 *  电台标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  电台用户信息
 */
@property (nonatomic,strong) RadioUserInfo *userinfo;
/**
 *  关注人数
 */
@property (nonatomic,assign) NSUInteger count;
/**
 *  电台描述
 */
@property (nonatomic,copy) NSString *desc;
/**
 *  是不是最新的
 */
@property (nonatomic,assign,getter=isnew) BOOL isnew;


@end
