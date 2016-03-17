//
//  SYBaeTableViewCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicView;
@class list;
@interface SYBaeTableViewCell : UITableViewCell
/**
 *  最上面Label，显示模块
 */
@property (nonatomic,strong) UILabel *ennameLabel;
/**
 *  配图(如果有的话)
 */
@property (nonatomic,strong) UIImageView *coverImageView;
/**
 *  音乐播放视图(如果有的话)
 */
@property (nonatomic,strong) MusicView *musicView;
/**
 *  标题Label(如果有的话)
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  内容简介Label
 */
@property (nonatomic,strong) UILabel *contentLabel;
/**
 *  作者详情Lable(如果有的话)
 */
@property (nonatomic,strong) UILabel *tag_infoLabel;
/**
 *  喜欢数量按钮
 */
@property (nonatomic,strong) UIButton *likeButton;

/**
 *  底部的分解线
 */
@property (nonatomic,strong) UIView *lineView;

/**
 *  数据模型
 */
@property (nonatomic,strong) list *listModel;

+ (NSString *)cellIdentifierForRow:(list *)listModel;

@end
