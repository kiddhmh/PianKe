//
//  LPXQheadView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/4.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPXQheadModel;
@class SQHotListModel;
@interface LPXQheadView : UIView

@property (nonatomic,strong) SQHotListModel *hotList;
/**
 *  左上角来自哪里的Button
 */
@property (nonatomic,strong) UIButton *fromButton;
/**
 *  右上角More小姐Button
 */
@property (nonatomic,strong) UIButton *moreButton;
/**
 *  标题Lable
 */
@property (nonatomic,strong) UILabel  *titleLabel;
/**
 *  左下角楼主图片
 */
@property (nonatomic,strong) UIImageView *louzhuImageView;
/**
 *  左下角的楼主Label
 */
@property (nonatomic,strong) UILabel *louzhuLabel;
/**
 *  右下角添加时间Lable
 */
@property (nonatomic,strong) UILabel *addtimeLabel;


//用来加载界面数据的方法
- (void)loadData:(LPXQheadModel *)headModel;

@end
