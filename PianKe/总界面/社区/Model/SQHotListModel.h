//
//  SQHotListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userinfo;
@class counterList;
@interface SQHotListModel : NSObject
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  配图 (如果有的话)
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  内容 
 */
@property (nonatomic,copy) NSString *content;
/**
 *  发布时间
 */
@property (nonatomic,copy) NSString *addtime_f;
/**
 *  用户信息
 */
@property (nonatomic,strong) userinfo *userinfo;
/**
 *  喜欢书/点赞数
 */
@property (nonatomic,strong) counterList *counterList;

@end
