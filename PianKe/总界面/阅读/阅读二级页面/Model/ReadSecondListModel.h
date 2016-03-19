//
//  ReadSecondListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadSecondListModel : NSObject
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  内容
 */
@property (nonatomic,copy) NSString *content;

@end
