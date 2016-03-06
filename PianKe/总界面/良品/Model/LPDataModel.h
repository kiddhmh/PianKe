//
//  LPDataModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPDataModel : NSObject

/**
 *  返回内容的数组
 */
@property (nonatomic,strong) NSArray *list;
/**
 *  返回内容数量
 */
@property (nonatomic,assign) NSInteger total;

//数据转模型方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
