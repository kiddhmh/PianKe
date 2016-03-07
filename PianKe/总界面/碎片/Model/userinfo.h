//
//  userinfo.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userinfo : NSObject
/**
 *  用户ID
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
