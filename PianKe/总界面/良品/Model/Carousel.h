//
//  Carousel.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Carousel : NSObject
/**
 * 图片
 */
@property (nonatomic,copy) NSString *img;
/**
 *  点击进入地址
 */
@property (nonatomic,copy) NSString *url;

@property (nonatomic,assign) NSUInteger count;

@end
