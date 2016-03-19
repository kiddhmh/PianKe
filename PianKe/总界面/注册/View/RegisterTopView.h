//
//  RegisterTopView.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTopView : UIView
/**
 *  返回上级页面按钮
 */
@property (nonatomic,strong) UIButton *backBtn;
/**
 *  头像图片
 */
@property (nonatomic,strong) UIImageView *iconImageView;
/**
 *  性别
 */
@property (nonatomic,strong) NSString *xingbie;
@end
