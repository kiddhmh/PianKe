//
//  HttpTool.h
//  图吧导航1号
//
//  Created by Mr.Psychosis on 14/11/15.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"
#import <UIKit/UIKit.h>

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

typedef void (^HttpSuccessBlock) (id JSON);
typedef void (^HttpFailureBlock) (NSError *error);

@interface HttpTool : NSObject

/**
 *  AFN get请求
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 *  AFN post请求
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;


/**
 *  AFN POST上传图片
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param images 需要上传的图片数组，二进制格式的图片
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)postWithImgPath:(NSString *)path
                 params:(NSDictionary *)params
                 images:(NSArray *)images
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure;

/**
 *   取消网络请求
 */
+ (void)cancelAllRequest;

@end
