//
//  RadioSecondRadioInfo.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userinfo;
@interface RadioSecondRadioInfo : NSObject
/**
 *  电台ID
 */
@property (nonatomic,assign) NSInteger radioid;
/**
 *  电台标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  电台配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  电台简介
 */
@property (nonatomic,copy) NSString *desc;
/**
 *  收听人数
 */
@property (nonatomic,assign) NSInteger musicvisitnum;
/**
 *  用户信息
 */
@property (nonatomic,strong) userinfo *userinfo;

@end
