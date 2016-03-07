//
//  counterList.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface counterList : NSObject
/**
 *  点赞数
 */
@property (nonatomic,assign) NSUInteger comment;
/**
 *  喜欢数
 */
@property (nonatomic,assign) NSUInteger like;
@end
