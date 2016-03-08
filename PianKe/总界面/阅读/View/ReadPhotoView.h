//
//  ReadPhotoView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/8.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadPhotoView : UIView
/**
 *  图片地址
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  书名
 */
@property (nonatomic,copy) NSString *name;
/**
 *  作者名
 */
@property (nonatomic,copy) NSString *enname;
@end
