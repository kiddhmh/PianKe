//
//  LPRootModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LPDataModel;
@interface LPRootModel : NSObject<NSCoding>
/**
 *  最外层字典
 */
@property (nonatomic,strong) LPDataModel *data;
/**
 *  返回结果
 */
@property (nonatomic,assign) NSInteger result;

/**
 *  数据转模型方法
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


/**
 *  模型转数据方法
 */
- (void)toDictionary;

/*
    当创建一个模型的时候，自己问自己一下，
    我有没有必要将模型归档
 */



@end
