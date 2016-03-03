//
//  LPListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPListModel : NSObject

/**
 *  购买链接
 */
@property (nonatomic,copy) NSString *buyurl;
/**
 *  内容
 */
@property (nonatomic,copy) NSString *contentid;
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  内容标题
 */
@property (nonatomic,copy) NSString *title;

//数据转模型方法
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
