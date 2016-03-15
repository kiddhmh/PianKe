//
//  RadioUserInfo.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioUserInfo : NSObject
/**
 *  用户编号
 */
@property (nonatomic,assign) NSUInteger uid;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *uname;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *icon;

@end
