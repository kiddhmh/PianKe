//
//  UIImageView+SDWedImage.m
//  LoveLimitFree
//
//  Created by andezhou on 15/9/8.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "UIImageView+SDWedImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWedImage)

#pragma mark -
#pragma mark SDWebImage缓存图片
- (void)downloadImage:(NSString *)url {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
#pragma mark SDWebImage缓存图片
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

#pragma mark SDWebImage图片下载进度
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
              success:(DownloadSuccessBlock)success
              failure:(DownloadFailureBlock)failure
             received:(DownloadProgressBlock)progress {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageLowPriority | SDWebImageRetryFailed  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (receivedSize && expectedSize) {
            progress(receivedSize, expectedSize);
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            failure(error);
        }else{
            self.image = image;
            success(finished, cacheType, image);
        }
    }];
}

@end
