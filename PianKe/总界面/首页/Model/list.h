//
//  list.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Tag_Info;
@interface list : NSObject
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  属于哪个模块
 */
@property (nonatomic,copy) NSString *name;
/**
 *  英文名
 */
@property (nonatomic,copy) NSString *enname;
/**
 *  内容简介
 */
@property (nonatomic,copy) NSString *content;
/**
 *  喜欢数量
 */
@property (nonatomic,assign) NSUInteger like;
/**
 *  作者信息
 */
@property (nonatomic,strong) Tag_Info *tag_info;
/**
 *  文章标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  歌曲序号
 */
@property (nonatomic,assign) NSUInteger songid;

@property (strong, nonatomic) NSString *contentid;

@end
