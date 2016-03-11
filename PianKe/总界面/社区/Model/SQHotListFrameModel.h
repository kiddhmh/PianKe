//
//  SQHotListFrameModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define HotTitleFont [UIFont boldSystemFontOfSize:18]
#define HotcontentidFont [UIFont systemFontOfSize:14]
#define HotTimeFont [UIFont systemFontOfSize:12]
#define CellBorderW 13
@class SQHotListModel;
@interface SQHotListFrameModel : NSObject
/**
 *  数据模型
 */
@property (nonatomic,strong) SQHotListModel *hotListModel;
/**
 *  配图frame(如果有的话)
 */
@property (nonatomic,assign) CGRect coverImageViewF;
/**
 *  标题frame
 */
@property (nonatomic,assign) CGRect titleLabelF;
/**
 *  内容Frame
 */
@property (nonatomic,assign) CGRect contentidLabelF;
/**
 *  添加时间Frame
 */
@property (nonatomic,assign) CGRect addtimelabelF;
/**
 *  评论数量Frame
 */
@property (nonatomic,assign) CGRect commentLabelF;
/**
 *  cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;
/**
 *  底部线的Frame
 */
@property (nonatomic,assign) CGRect lineF;


@end
