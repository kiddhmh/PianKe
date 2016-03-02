//
//  Tag_Info.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tag_Info : NSObject
/**
 *  作者姓名
 */
@property (nonatomic,copy) NSString *tag;
/**
 *  转载数量
 */
@property (nonatomic,assign) NSUInteger count;

@end
