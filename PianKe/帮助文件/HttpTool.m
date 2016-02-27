//
//  HttpTool.h
//  图吧导航1号
//
//  Created by Mr.Psychosis on 14/11/15.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

// 服务器地址
static NSString *const kBaseURLString = @"http://api2.pianke.me/";

@implementation AFHttpClient

+ (instancetype)sharedClient {
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif", nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end

@implementation HttpTool

#pragma mark - AFN网络请求
#pragma mark POST请求
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure == nil) return;
        failure(error);
        
    }];
}

#pragma mark GET请求
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        if (success == nil) return;
        success(JSON);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure == nil) return;
        failure(error);
        
    }];
}

#pragma mark POST上传图片
+ (void)postWithImgPath:(NSString *)path
                 params:(NSDictionary *)params
                 images:(NSArray *)images
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure {
    NSString *basePath  = [NSString stringWithFormat:@"%@%@", kBaseURLString, path];

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:basePath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSUInteger idx = 0; idx < images.count; idx ++) {

            NSDate *date = [NSDate new];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyyMMddHHmmss"];
            [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            
            [formData appendPartWithFileData:images[idx] name:[NSString stringWithFormat:@"header%zi", idx + 1 ] fileName:[NSString stringWithFormat:@"%@%zi.jpg", [df stringFromDate:date], idx + 1 ] mimeType:@"image/jpg"];
        }
    } error:nil];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    opration.responseSerializer = [AFJSONResponseSerializer serializer];
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return;
        failure(error);
    }];
    
    [opration start];
}

#pragma mark -
#pragma mark 取消网络请求
+ (void)cancelAllRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
