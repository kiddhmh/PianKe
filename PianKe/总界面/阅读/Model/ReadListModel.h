//
//  ReadListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/8.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadListModel : NSObject
/**
 *  类型
 */
@property (nonatomic,assign) NSUInteger type;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *name;
/**
 *  作者名
 */
@property (nonatomic,copy) NSString *enname;
/**
 *  图片
 */
@property (nonatomic,copy) NSString *coverimg;

@end
