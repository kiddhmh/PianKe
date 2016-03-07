//
//  ListModelFrame.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define LISTUNAMEFONT [UIFont systemFontOfSize:13]
#define LISTCONTENTFONT [UIFont systemFontOfSize:14]
#define LISTTIMEFONT [UIFont systemFontOfSize:12]
#define CellBorderW 12
@class ListModel;
@interface ListModelFrame : NSObject
/**
 *  碎片数据模型
 */
@property (nonatomic,strong) ListModel *listM;
/**
 *  用户头像Frame
 */
@property (nonatomic,assign) CGRect  iconF;
/**
 *  用户昵称Frame
 */
@property (nonatomic,assign) CGRect unameF;
/**
 *  发布时间Frame
 */
@property (nonatomic,assign) CGRect addTimeF;
/**
 *  内容Frame
 */
@property (nonatomic,assign) CGRect contentF;
/**
 *  点赞数Frame
 */
@property (nonatomic,assign) CGRect commentF;
/**
 *  喜欢数Frame
 */
@property (nonatomic,assign) CGRect likeFrame;
/**
 *  配图的Frame(如果有的话)
 */
@property (nonatomic,assign) CGRect coverimgF;
/**
 *  cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;
/**
 *  底部线的Frame
 */
@property (nonatomic,assign) CGRect lineF;

@end
