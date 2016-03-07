//
//  ListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userinfo;
@class counterList;
@interface ListModel : NSObject
/**
 *  用户信息
 */
@property (nonatomic,strong) userinfo *userinfo;
/**
 *  点赞/喜欢数
 */
@property (nonatomic,strong) counterList *counterList;
/**
 *  发布的时间(数字形式)
 */
@property (nonatomic,assign) NSUInteger addtime;
/**
 *  发布的时间
 */
@property (nonatomic,strong) NSString *addtime_f;
/**
 *  歌曲信息(如果有的话)
 */
@property (nonatomic,assign) NSUInteger songid;
/**
 *  内容
 */
@property (nonatomic,strong) NSString *content;
/**
 *  配图(如果有的话)
 */
@property (nonatomic,strong) NSString *coverimg;
/**
 *  配图的大小(如果有的话)
 */
@property (nonatomic,strong) NSString *coverimg_wh;
/**
 *  你是否喜欢
 */
@property (nonatomic,assign,getter=isLike) BOOL islike;

@end
