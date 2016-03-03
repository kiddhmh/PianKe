//
//  UIImageView+SDWedImage.h
//  LoveLimitFree
//
//  Created by andezhou on 15/9/8.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DownloadSuccessBlock) (BOOL success, NSInteger cacheType, UIImage *image);
typedef void (^DownloadFailureBlock) (NSError *error);
typedef void (^DownloadProgressBlock) (NSInteger received, NSInteger expected);

@interface UIImageView (SDWedImage)

/**
 *  SDWebImage 下载并缓存图片
 *
 *  @param url 图片的url
 *
 */
- (void)downloadImage:(NSString *)url;

/**
 *  SDWebImage 下载并缓存图片
 *
 *  @param url 图片的url
 *
 *  @param place 还未下载成功时的替换图片
 *
 */
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place;

/**
 *  SDWebImage 下载并缓存图片和下载进度
 *
 *  @param url 图片的url
 *
 *  @param place 还未下载成功时的替换图片
 *
 *  @param success 图片下载成功
 *
 *  @param failure 图片下载失败
 *
 *  @param progress 图片下载进度
 */
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
              success:(DownloadSuccessBlock)success
              failure:(DownloadFailureBlock)failure
             received:(DownloadProgressBlock)progress;


@end
