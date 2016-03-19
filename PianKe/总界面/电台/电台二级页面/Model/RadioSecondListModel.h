//
//  RadioSecondListModel.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioSecondListModel : NSObject
/**
 *  头像
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  收听人数
 */
@property (nonatomic,assign) NSInteger musicVisit;
/**
 *  歌曲链接
 */
@property (nonatomic,copy) NSString *musicUrl;

@end
