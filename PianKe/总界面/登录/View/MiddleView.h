//
//  MiddleView.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMHTextField;
@interface MiddleView : UIView
/**
 *  邮箱文本输入框
 */
@property (nonatomic,strong) HMHTextField *YXtextField;
/**
 *  密码文本输入框
 */
@property (nonatomic,strong) HMHTextField *MMtextField;
/**
 *  确认按钮
 */
@property (nonatomic,strong) UIButton *LoginBtn;

@end
