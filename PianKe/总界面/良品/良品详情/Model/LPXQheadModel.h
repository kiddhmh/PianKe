//
//  LPXQheadModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/4.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPXQheadModel : NSObject
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  添加时间
 */
@property (nonatomic,copy) NSString *addtime;
/**
 *  楼主头像
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  专栏名字
 */
@property (nonatomic,copy) NSString *uname;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
